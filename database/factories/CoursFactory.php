<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Cours>
 */
class CoursFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        $date_debut = $this->faker->date();

        return [
            'id_cours' => $this->faker->unique()->numberBetween(1, 50),
            'intitule_cours' => $this->faker->sentence(3), // 更改這裡
            'descriptions' => $this->faker->firstName,
            'prix' => $this->faker->numberBetween(1, 1000),
            'pre_requis' => $this->faker->sentence(20),
            'date_debut' => $date_debut,
            'date_fin' => $this->faker->dateTimeBetween($date_debut, '+1 year')->format('Y-m-d'),
        ];
    }
}
