<?php

namespace App\Controller;

use App\Entity\Trick;
use App\Repository\TrickRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\Form\Extension\Core\Type\TextType;

final class HomeController extends AbstractController
{
    #[Route('/', name: 'app_home')]
    public function index(TrickRepository $trickRepository): Response
    {
        // un minimum de 10 tricks doivent être affichés
        $tricks = $trickRepository->findBy([], ['createdAt' => 'DESC'], 10);
        
        return $this->render('home/index.html.twig', [
            'tricks' => $tricks,
        ]);
    }
}

