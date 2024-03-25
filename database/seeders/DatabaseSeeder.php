<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Utilisateur;
use App\Models\Cours;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        // 使用 factory 生成數據
       // Utilisateur::factory(10)->create();
        Cours::factory(10)->create();



    }
}
