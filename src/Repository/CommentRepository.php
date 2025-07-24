<?php

namespace App\Repository;

use App\Entity\Comment;
use App\Entity\Trick;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use Pagerfanta\Doctrine\ORM\QueryAdapter;
use Pagerfanta\Pagerfanta;

class CommentRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Comment::class);
    }
    

    public function findCommentsByTrick(Trick $trick, int $page = 1, int $limit = 10): Pagerfanta
    {
        $queryBuilder = $this->createQueryBuilder('c')
            ->andWhere('c.trick = :trick')
            ->setParameter('trick', $trick)
            ->orderBy('c.createdAt', 'DESC');
            
        $adapter = new QueryAdapter($queryBuilder);
        $pagerfanta = new Pagerfanta($adapter);
        
        $pagerfanta->setMaxPerPage($limit);
        $pagerfanta->setCurrentPage($page);
        
        return $pagerfanta;
    }
    

    public function save(Comment $comment): void
    {
        $entityManager = $this->getEntityManager();
        $entityManager->persist($comment);
        $entityManager->flush();
    }
}
