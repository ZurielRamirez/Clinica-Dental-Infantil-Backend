<?php

namespace Database\Seeders;

use App\Models\Appointment;
use App\Models\Patient;
use App\Models\User;
use Illuminate\Database\Seeder;

class AppointmentSeeder extends Seeder
{
    public function run(): void
    {
        $pacientes = Patient::all();
        $dentistas = User::whereHas('roles', function ($q) {
            $q->where('name', 'dentist');
        })->get();

        $estados = ['pending', 'confirmed', 'completed', 'cancelled'];

        foreach ($pacientes as $i => $paciente) {
            $dentista = $dentistas[$i % $dentistas->count()];
            $fecha = fake()->dateTimeBetween('-15 days', '+15 days');

            Appointment::create([
                'patient_id' => $paciente->id,
                'dentist_id' => $dentista->id,
                'appointment_date' => $fecha->format('Y-m-d H:i:s'),
                'status' => $estados[$i % count($estados)],
                'notes' => fake()->randomElement([
                    'Revisión de rutina', 'Seguimiento de tratamiento',
                    'Primera consulta', 'Control post-tratamiento', null,
                ]),
            ]);
        }
    }
}