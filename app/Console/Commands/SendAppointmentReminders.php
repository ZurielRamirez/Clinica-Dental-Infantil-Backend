<?php

namespace App\Console\Commands;

use App\Models\Appointment;
use App\Services\TwilioService;
use Illuminate\Console\Attributes\Description;
use Illuminate\Console\Attributes\Signature;
use Illuminate\Console\Command;

#[Signature('app:send-appointment-reminders')]
#[Description('Envía recordatorios SMS 24 horas antes de cada cita agendada')]
class SendAppointmentReminders extends Command
{
    public function handle(TwilioService $twilio)
    {
        $desde = now()->addHours(23);
        $hasta = now()->addHours(25);

        $citas = Appointment::with('patient.tutor')
            ->where('status', 'pending')
            ->whereNull('reminder_sent_at')
            ->whereBetween('appointment_date', [$desde, $hasta])
            ->get();

        $this->info("Citas encontradas para recordatorio: {$citas->count()}");

        foreach ($citas as $cita) {
            $tutor = $cita->patient->tutor ?? null;

            if (!$tutor || !$tutor->phone) {
                $this->warn("Cita #{$cita->id} sin tutor o sin teléfono, se omite.");
                continue;
            }

            $fecha = $cita->appointment_date->format('d/m/Y H:i');
            $mensaje = "Hola {$tutor->name}, te recordamos que {$cita->patient->first_name} tiene cita mañana {$fecha}. - Clínica Dental Infantil";

            try {
                $twilio->sendSms($tutor->phone, $mensaje);
                $cita->update(['reminder_sent_at' => now()]);
                $this->info("Recordatorio enviado para la cita #{$cita->id}");
            } catch (\Exception $e) {
                $this->error("Error enviando recordatorio de la cita #{$cita->id}: " . $e->getMessage());
            }
        }

        return Command::SUCCESS;
    }
}