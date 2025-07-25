<?php

namespace App\Controller;

use App\Entity\Trick;
use App\Entity\Image;
use App\Entity\Video;
use App\Entity\Comment;
use App\Form\CommentType;
use App\Repository\CommentRepository;
use App\Repository\TrickRepository;
use App\Repository\ImageRepository;
use App\Repository\VideoRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Attribute\Route;
use App\Form\EditType;


class TrickController extends AbstractController
{
    #[Route('/trick/{slug}', name: 'app_trick_show')]
    public function show(Request $request, string $slug, TrickRepository $trickRepository, CommentRepository $commentRepository, EntityManagerInterface $entityManager): Response
    {
        $trick = $trickRepository->findOneBySlugWithRelations($slug);
        
        if (!$trick) {
            throw $this->createNotFoundException('Trick non trouvé');
        }
        
        $page = $request->query->getInt('page', 1);
        $pagerfanta = $commentRepository->findCommentsByTrick($trick, $page, 10);
        
    
        $comment = new Comment();
        $form = $this->createForm(CommentType::class, $comment);
        $form->handleRequest($request);
        

        if ($form->isSubmitted() && $form->isValid() && $this->getUser()) {
            $comment->setTrick($trick);
            $comment->setAuthor($this->getUser());
            $comment->setCreatedAt(new \DateTime());
            
            $commentRepository->save($comment);
            
            $this->addFlash('success', 'Votre commentaire a été ajouté avec succès!');
      
            return $this->redirectToRoute('app_trick_show', ['slug' => $slug]);
        }
        
        return $this->render('trick/show.html.twig', [
            'trick' => $trick,
            'commentForm' => $form->createView(),
            'pager' => $pagerfanta
        ]);
    }

    #[Route('/trick/{slug}/edit', name: 'app_trick_edit')]
    public function edit(Request $request, string $slug, TrickRepository $trickRepository, EntityManagerInterface $entityManager): Response
    {
        $trick = $trickRepository->findOneBySlugWithRelations($slug);
        
        if (!$trick) {
            throw $this->createNotFoundException('Trick non trouvé');
        }

        $form = $this->createForm(EditType::class, $trick);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {

            $this->addFlash('info', 'DEBUG: Formulaire soumis et valide'); 
            
            $imageFile = $form->get('imageFile')->getData();
            if ($imageFile) {
                $newFilename = md5(uniqid()) . '.' . $imageFile->guessExtension();
                //sécurisation du nom des fichiers, uniqid() génère un identifiant unique aléatoire, md5() génère un hash md5 unique
                //guessExtension() détermine l'extention sécurisée du fichier basé sur le type MIME
                //évite les injections de fichiers et les risques de collision entre les noms de fichiers.
                try {
                    $imageFile->move(
                        $this->getParameter('tricks_images_directory'),
                        $newFilename
                    );
                    
               
                    $image = new Image();
                    $image->setFilename($newFilename);
                    $image->setAltText($trick->getTitle());
                    $image->setTrick($trick);
                    $entityManager->persist($image);
                } catch (\Exception $e) {
                    $this->addFlash('error', 'Une erreur est survenue lors de l\'upload de l\'image');
                }
            }
  
            $videoUrl = $form->get('videoUrl')->getData();
            if ($videoUrl) {
                $video = new Video();
                $video->setUrl($videoUrl);
                $video->setTrick($trick);
          
                if (strpos($videoUrl, 'youtube') !== false || strpos($videoUrl, 'youtu.be') !== false) {
                    $video->setPlatform('youtube');
                } elseif (strpos($videoUrl, 'vimeo') !== false) {
                    $video->setPlatform('vimeo');
                } else {
                    $video->setPlatform('autre');
                }
                $entityManager->persist($video);
            }
            

            $entityManager->persist($trick);
            $entityManager->flush();
            

            $this->addFlash('success', 'Les modifications ont été enregistrées avec succès');


            return $this->redirectToRoute('app_trick_show', [
                'slug' => $trick->getSlug(),
            ]);
        }

        return $this->render('trick/edit.html.twig', [
            'trick' => $trick,
            'form' => $form->createView(),
        ]);
    }
    
    #[Route('/trick/image/{id}/delete', name: 'app_image_delete', methods: ['POST'])]
    public function deleteImage(Image $image, EntityManagerInterface $entityManager, Request $request): Response
    {
        $trick = $image->getTrick();
        $slug = $trick->getSlug();
        
  
        if ($this->isCsrfTokenValid('delete'.$image->getId(), $request->request->get('_token'))) {
//le  token empêche les attaques pour supprimer des fichiers,
// empêche la suppression non autorisée des images.
            $imagePath = $this->getParameter('tricks_images_directory').'/'.$image->getFilename();
            if (file_exists($imagePath)) {
                unlink($imagePath);
            }
            
      
            $entityManager->remove($image);
            $entityManager->flush();
            
            $this->addFlash('success', 'Image supprimée avec succès');
        }

        if ($request->isXmlHttpRequest()) {
            return new JsonResponse(['success' => true]);
        }
        

        return $this->redirectToRoute('app_trick_edit', ['slug' => $slug]);
    }
    
    #[Route('/trick/video/{id}/delete', name: 'app_video_delete', methods: ['POST'])]
    public function deleteVideo(Video $video, EntityManagerInterface $entityManager, Request $request): Response
    {
        $trick = $video->getTrick();
        $slug = $trick->getSlug();
        

        if ($this->isCsrfTokenValid('delete'.$video->getId(), $request->request->get('_token'))) {
            $entityManager->remove($video);
            $entityManager->flush();
            
            $this->addFlash('success', 'Vidéo supprimée avec succès');
        }
        

        if ($request->isXmlHttpRequest()) {
            return new JsonResponse(['success' => true]);
        }
        
    
        return $this->redirectToRoute('app_trick_edit', ['slug' => $slug]);
    }

    #[Route('/trick/{slug}/delete', name: 'app_trick_delete')]
    public function delete(Request $request, string $slug, TrickRepository $trickRepository, EntityManagerInterface $entityManager): Response
    {
        $trick = $trickRepository->findOneBySlugWithRelations($slug);
        
        if (!$trick) {
            throw $this->createNotFoundException('Trick non trouvé');
        }
        
        if ($this->isCsrfTokenValid('delete'.$trick->getSlug(), $request->request->get('_token'))) {
            foreach ($trick->getImages() as $image) {
                $imagePath = $this->getParameter('tricks_images_directory').'/'.$image->getFilename();
                if (file_exists($imagePath)) {
                    unlink($imagePath);
                }
            }
            
            $entityManager->remove($trick);
            $entityManager->flush();
            
            $this->addFlash('success', 'Trick supprimé avec succès');
        }

        return $this->redirectToRoute('app_home');
    }
}
