<?php
namespace App\Controller;

use App\Entity\User;
use App\Entity\ResetPassword;
use App\Form\UserType;
use App\Repository\UserRepository;
use App\Repository\ResetPasswordRepository;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
//utilisation de l'algorithme de hachage de mot de passe
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Bridge\Twig\Mime\TemplatedEmail;
use Symfony\Component\Mailer\MailerInterface;
use Symfony\Component\Form\Extension\Core\Type\EmailType;
use Symfony\Component\Validator\Constraints\NotBlank;
use Symfony\Component\Validator\Constraints\Email;
use Symfony\Component\Security\Http\Authentication\AuthenticationUtils;

final class SecurityController extends AbstractController
{
    #[Route('/signup', name: 'signup')]
    public function signup(Request $request, EntityManagerInterface $em, UserPasswordHasherInterface $passwordHasher, MailerInterface $mailer): Response
    {
        if (!$request->isMethod('POST')) {
            $user = new User();
            $userForm = $this->createForm(UserType::class, $user);
            
            return $this->render('security/signup.html.twig', [
                'form' => $userForm->createView(),
            ]);
        }
        
        $user = new User();
        $userForm = $this->createForm(UserType::class, $user);
        $userForm->handleRequest($request);
        
        if (!$userForm->isValid()) {
            foreach ($userForm->getErrors(true) as $error) {
                $this->addFlash('error', $error->getMessage());
            }
            return $this->redirectToRoute('signup');
        }
        
        $user->setPassword($passwordHasher->hashPassword($user, $user->getPassword()));
        
        try {
            $em->persist($user);
            $em->flush();
            
  
            $emailSent = $this->sendWelcomeEmail($user, $mailer);
            
            if ($emailSent) {
                $this->addFlash('success', 'Inscription réussie ! Vous pouvez maintenant vous connecter. Un email de bienvenue vous a été envoyé.');
            } else {
                $this->addFlash('success', 'Inscription réussie ! Vous pouvez maintenant vous connecter.');
                $this->addFlash('warning', 'Impossible d\'envoyer l\'email de bienvenue. Votre compte est néanmoins bien créé.');
            }
            return $this->redirectToRoute('login');
            
        } catch (\PDOException $e) {
            // gestion des erreurs de base de données
            if (str_contains($e->getMessage(), 'Duplicate entry') && str_contains($e->getMessage(), 'email')) {
                $this->addFlash('error', 'Cette adresse email est déjà utilisée.');
            } else {
                $this->addFlash('error', 'Une erreur est survenue lors de l\'enregistrement.');
            }
            
            return $this->redirectToRoute('signup');
            
        } catch (\Exception $e) {
            $this->addFlash('error', 'Une erreur inattendue est survenue.');
            return $this->redirectToRoute('signup');
        }
    }

    #[Route('/login', name: 'login')]
    public function login(AuthenticationUtils $authenticationUtils): Response
    {
        if ($this->getUser()) {
            return $this->redirectToRoute('home');
        }
        $error = $authenticationUtils->getLastAuthenticationError();
        $username = $authenticationUtils->getLastUsername();
        
        if ($error) {
            if ($error instanceof \Symfony\Component\Security\Core\Exception\UserNotFoundException) {
                $this->addFlash('warning', 'L\'utilisateur n\'existe pas. Vérifiez votre nom d\'utilisateur.');
            } elseif ($error instanceof \Symfony\Component\Security\Core\Exception\BadCredentialsException) {
                $this->addFlash('warning', 'Identifiants invalides. Vérifiez votre nom d\'utilisateur et mot de passe.');
            } else {
                $errorMessage = $error->getMessage();
                $this->addFlash('error', 'Échec de connexion: ' . $errorMessage);
            }
        }

        return $this->render('security/login.html.twig', [
            'error' => $error,
            'username' => $username,
            'controller_name' => 'SecurityController',
        ]);
    }

    private function sendWelcomeEmail(User $user, MailerInterface $mailer): bool
    {
        try {
            $email = new TemplatedEmail();
            $email->subject('Bienvenue sur Snowtricks!')
                  ->from('snowtricks@demomailtrap.co')
                  ->to($user->getEmail())
                  ->text('Nous sommes ravis de vous avoir sur Snowtricks !')
                  ->htmlTemplate('email/welcome.html.twig')
                  ->context([
                      'user' => $user,
                  ]);
            
            $mailer->send($email);
            return true;
        } catch (\Exception $e) {
            
            error_log('Erreur lors de l\'envoi de l\'email de bienvenue: ' . $e->getMessage());
            return false;
        }
    }

    #[Route('/logout', name: 'logout')]
    public function logout()
    {
     
    }

    #[Route('/reset-password/{token}', name: 'reset_password')]
    public function resetPassword($token, Request $request, UserRepository $userRepository, ResetPasswordRepository $resetPasswordRepository, EntityManagerInterface $em, UserPasswordHasherInterface $passwordHasher): Response
    {
        
        if ($request->isMethod('GET')) {
            return $this->render('security/reset_password.html.twig', [
                'token' => $token
            ]);
        }
        
        
        $password = $request->request->get('password');
        $passwordConfirm = $request->request->get('password_confirm');
        
        if (!$password || $password !== $passwordConfirm) {
            $this->addFlash('error', 'Les mots de passe ne correspondent pas.');
            return $this->redirectToRoute('reset_password', ['token' => $token]);
        }
        
        $resetPassword = $resetPasswordRepository->findOneBy(['token' => $token]);
        $user = null;
        
        if ($resetPassword) {
            $user = $resetPassword->getUser();
        } else {
         
            $resetPasswords = $resetPasswordRepository->findAll();
            
            foreach ($resetPasswords as $resetPwd) {
              
                $storedToken = $request->getSession()->get('reset_token_' . $resetPwd->getUser()->getId());
                if ($storedToken && $storedToken === $token) {
                    $user = $resetPwd->getUser();
                    $resetPassword = $resetPwd;
                    break;
                }
            }
        }
        
        if (!$user) {
            $this->addFlash('error', 'Token invalide ou expiré.');
            return $this->redirectToRoute('password_reset_request');
        }
        
        $resetPassword = $resetPasswordRepository->findOneBy(['user' => $user]);
        
        if (!$resetPassword) {
            $this->addFlash('error', 'Aucune demande de réinitialisation de mot de passe trouvée.');
            return $this->redirectToRoute('password_reset_request');
        }
        
        if ($resetPassword->getExpiredAt() < new \DateTimeImmutable()) {
            $this->addFlash('error', 'La demande de réinitialisation de mot de passe a expiré.');
            return $this->redirectToRoute('password_reset_request');
        }
        
     
        $user->setPassword($passwordHasher->hashPassword($user, $password));
        $em->persist($user);
        $em->flush();
        
    
        $resetPasswordRepository->remove($resetPassword);
        $request->getSession()->remove('reset_token_' . $user->getId());
        
        $this->addFlash('success', 'Votre mot de passe a été réinitialisé avec succès.');
        return $this->redirectToRoute('login');
    }

    #[Route('/password_reset_request', name: 'password_reset_request')]
    public function resetPasswordRequest(MailerInterface $mailer, Request $request, UserRepository $userRepository, ResetPasswordRepository $resetPasswordRepository, EntityManagerInterface $em): Response
    {
        $emailForm = $this->createFormBuilder()
            ->add('email', EmailType::class, [
                'label' => 'Email',
                'attr' => [
                    'placeholder' => 'Entrez votre adresse email'
                ],
                'constraints' => [
                    new NotBlank([
                        'message' => 'Veuillez entrer votre adresse email',
                    ]),
                    new Email([
                        'message' => 'Veuillez entrer une adresse email valide',
                    ]),
                ],
            ])
            ->getForm();
            
        $emailForm->handleRequest($request);
            
        if ($emailForm->isSubmitted() && $emailForm->isValid()) {
       $emailValue = $emailForm->get('email')->getData();
       $user = $userRepository->findOneBy(['email' => $emailValue]);
       if (!$user) {
           $this->addFlash('error', 'Aucun utilisateur trouvé avec cette adresse email.');
           return $this->redirectToRoute('password_reset_request');
       }
       if ($user) {
        $oldResetPassword = $resetPassword=$resetPasswordRepository->findOneBy(['user' => $user]);
        if ($oldResetPassword) {
            $em->remove($oldResetPassword);
            $em->flush();
        }

        $token = substr(str_replace(['/', '+', '='], '', base64_encode(random_bytes(30))), 0, 20);
        
      
        $resetPassword = new ResetPassword();
        $resetPassword->setUser($user);
        $resetPassword->setExpiredAt(new \DateTimeImmutable('+2 hours'));
        $resetPassword->setToken($token); 
        

        $request->getSession()->set('reset_token_' . $user->getId(), $token);
        
        $em->persist($resetPassword);
        $em->flush();
       $email = new TemplatedEmail();
        $email->subject('Réinitialisation de votre mot de passe')
              ->from('snowtricks@demomailtrap.co')
              ->to($emailValue)
              ->text('Vous avez demandé la réinitialisation de votre mot de passe. Cliquez sur le lien ci-dessous pour le réinitialiser.')
              ->htmlTemplate('email/reset_password.html.twig')
              ->context([
           
                  'token'=>$token
                ]);
     $mailer->send($email);
        $this->addFlash('success', 'Un email de réinitialisation de mot de passe a été envoyé à votre adresse email.');
        return $this->redirectToRoute('login');
       }
      }
        

       return $this->render('security/password_reset_request.html.twig', [
           'emailForm' => $emailForm->createView(),
       ]);
    }
}
