<?php

namespace Database\Seeders;

use App\Models\Patient;
use App\Models\User;
use Illuminate\Database\Seeder;

class PatientSeeder extends Seeder
{
    public function run(): void
    {
        $tutor = User::where('email', 'tutor@gmail.com')->first();

        if ($tutor) {
            Patient::create([
                'tutor_id' => $tutor->id,
                'first_name' => 'Mateo',
                'last_name' => 'Perez',
                'birth_date' => '2018-05-14',
                'allergies' => 'Penicilina',
                'medical_notes' => 'Paciente colaborador',
            ]);

            Patient::create([
                'tutor_id' => $tutor->id,
                'first_name' => 'Sofía',
                'last_name' => 'Perez',
                'birth_date' => '2020-09-21',
                'allergies' => 'Ninguna',
                'medical_notes' => 'Miedo a los ruidos fuertes',
            ]);
        }

        $otrosNombres = [
            ['Emiliano', 'Torres'], ['Regina', 'Sánchez'], ['Santiago', 'Cruz'],
            ['Valentina', 'Ruiz'], ['Diego', 'Martínez'], ['Ximena', 'Hernández'],
            ['Leonardo', 'Jiménez'], ['Camila', 'Morales'], ['Emilio', 'Vázquez'],
            ['Renata', 'López'], ['Mateo', 'González'], ['Sofía', 'Ramírez'],
        ];

        $tutores = User::whereHas('roles', function ($q) {
            $q->where('name', 'tutor');
        })->where('email', '!=', 'tutor@gmail.com')->get();

        foreach ($otrosNombres as $i => $nombre) {
            $tutorAsignado = $tutores[$i % $tutores->count()];

            Patient::create([
                'tutor_id' => $tutorAsignado->id,
                'first_name' => $nombre[0],
                'last_name' => $nombre[1],
                'birth_date' => fake()->dateTimeBetween('-11 years', '-2 years')->format('Y-m-d'),
                'allergies' => fake()->randomElement(['Ninguna', 'Penicilina', 'Ninguna', 'Polen', 'Ninguna']),
                'medical_notes' => fake()->randomElement([
                    'Paciente colaborador', 'Primera visita', 'Requiere acompañamiento',
                    'Sin antecedentes relevantes', 'Ansiedad leve ante procedimientos',
                ]),
            ]);
        }
    }
}