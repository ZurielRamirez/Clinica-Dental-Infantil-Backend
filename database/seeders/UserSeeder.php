<?php

namespace Database\Seeders;

use App\Models\Role;
use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    public function run(): void
    {
        $adminRole = Role::where('name', 'admin')->first();
        $dentistRole = Role::where('name', 'dentist')->first();
        $tutorRole = Role::where('name', 'tutor')->first();

        $admin = User::create([
            'name' => 'Administrador General',
            'email' => 'admin@clinicadental.com',
            'phone' => '+5219511234567',
            'password' => Hash::make('password123'),
        ]);
        $admin->roles()->attach($adminRole);

        $dentist = User::create([
            'name' => 'Dra. María González',
            'email' => 'dentista@clinicadental.com',
            'phone' => '+5219511234568',
            'password' => Hash::make('password123'),
        ]);
        $dentist->roles()->attach($dentistRole);

        $dentistas = [
            'Dr. Carlos Ramírez',
            'Dra. Fernanda López',
        ];
        foreach ($dentistas as $i => $nombre) {
            $d = User::create([
                'name' => $nombre,
                'email' => 'dentista' . ($i + 2) . '@clinicadental.com',
                'phone' => fake()->numerify('+521951#######'),
                'password' => Hash::make('password123'),
            ]);
            $d->roles()->attach($dentistRole);
        }

        $tutor = User::create([
            'name' => 'Juan Perez',
            'email' => 'tutor@gmail.com',
            'phone' => '+5219513928808',
            'password' => Hash::make('password123'),
        ]);
        $tutor->roles()->attach($tutorRole);

        $tutores = [
            'Ana Martínez', 'Luis Hernández', 'Karla Jiménez', 'Roberto Cruz',
            'Patricia Morales', 'Jorge Sánchez', 'Daniela Torres', 'Miguel Ángel Ruiz',
            'Cynthia Vázquez',
        ];
        foreach ($tutores as $i => $nombre) {
            $t = User::create([
                'name' => $nombre,
                'email' => 'tutor' . ($i + 2) . '@gmail.com',
                'phone' => fake()->numerify('+521951#######'),
                'password' => Hash::make('password123'),
            ]);
            $t->roles()->attach($tutorRole);
        }
    }
}