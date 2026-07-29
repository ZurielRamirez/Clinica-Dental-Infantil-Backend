<?php

namespace Database\Seeders;

use App\Models\Treatment;
use Illuminate\Database\Seeder;

class TreatmentSeeder extends Seeder
{
    public function run(): void
    {
        $tratamientos = [
            ['Limpieza Dental Infantil', 'Profilaxis y aplicación de flúor', 500.00],
            ['Resina Fotocurable', 'Restauración por caries', 800.00],
            ['Pulpotomía', 'Tratamiento pulpar para dientes de leche', 1200.00],
            ['Extracción Simple', 'Extracción de diente caduco', 450.00],
            ['Sellador de Fosetas', 'Prevención de caries en molares', 350.00],
            ['Consulta de Valoración', 'Revisión inicial y diagnóstico', 300.00],
            ['Aplicación de Flúor', 'Tratamiento preventivo tópico', 250.00],
            ['Corona Pediátrica', 'Corona de acero para dientes tratados', 1500.00],
            ['Pulpectomía', 'Tratamiento de conducto en dientes temporales', 1400.00],
            ['Mantenedor de Espacio', 'Prevención de mal oclusión tras extracción', 1100.00],
            ['Profilaxis con Flúor Barniz', 'Limpieza más protección con barniz fluorado', 600.00],
            ['Radiografía Dental', 'Estudio radiográfico de diagnóstico', 200.00],
        ];

        foreach ($tratamientos as $t) {
            Treatment::create([
                'name' => $t[0],
                'description' => $t[1],
                'price' => $t[2],
            ]);
        }
    }
}