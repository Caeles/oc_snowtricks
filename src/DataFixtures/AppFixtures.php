<?php

namespace App\DataFixtures;

use App\Factory\CategoryFactory;
use App\Factory\CommentFactory;
use App\Factory\ImageFactory;
use App\Factory\TrickFactory;
use App\Factory\UserFactory;
use App\Factory\VideoFactory;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;

class AppFixtures extends Fixture
{
    public function load(ObjectManager $manager): void
    {

        UserFactory::createMany(5);

        $categories = [
            'Grabs',
            'Rotations',
            'Flips',
            'Butters',
            'Jumps',
            'Old school',
            'Rails',
            'Big Air'
        ];

        foreach ($categories as $categoryName) {
            CategoryFactory::new()->create([
                'name' => $categoryName
            ]);
        }

        TrickFactory::createMany(10, function() {
            return [
                'category' => CategoryFactory::random(),
                'author' => UserFactory::random(),
            ];
        });

        foreach (TrickFactory::all() as $index => $trick) {
            $trickNumber = $index + 1;
            
            $imageCount = min(2, mt_rand(1, 2));
            
            for ($i = 1; $i <= $imageCount; $i++) {
                $safeNumber = min($trickNumber, 11);
                
                ImageFactory::new()->create([
                    'trick' => $trick,
                    'filename' => 'trick_' . $safeNumber . '_' . $i . '.jpg',
                ]);
            }
            

            if (mt_rand(0, 1)) {
                VideoFactory::createMany(mt_rand(1, 3), function() use ($trick) {
                    return [
                        'trick' => $trick,
                        'url' => 'https://www.youtube.com/embed/dQw4w9WgXcQ',
                    ];
                });
            }
            
 
            $commentCount = mt_rand(0, 15);
            if ($commentCount > 0) {
                CommentFactory::createMany($commentCount, function() use ($trick) {
                    return [
                        'trick' => $trick,
                        'author' => UserFactory::random(),
                    ];
                });
            }
        }
        
   
    }
}
