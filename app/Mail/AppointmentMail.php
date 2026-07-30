<?php

namespace App\Mail;

use App\Models\Appointment;
use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Queue\SerializesModels;

class AppointmentMail extends Mailable
{
    use Queueable, SerializesModels;

    public Appointment $appointment;
    public string $tipo;

    public function __construct(Appointment $appointment, string $tipo)
    {
        $this->appointment = $appointment;
        $this->tipo = $tipo;
    }

    public function envelope(): Envelope
    {
        $asuntos = [
            'confirmacion' => 'Tu cita ha sido agendada - Clínica Dental Infantil',
            'cancelacion' => 'Tu cita ha sido cancelada - Clínica Dental Infantil',
        ];

        return new Envelope(
            subject: $asuntos[$this->tipo] ?? 'Notificación de cita',
        );
    }

    public function content(): Content
    {
        return new Content(
            view: 'emails.appointment',
        );
    }

    public function attachments(): array
    {
        return [];
    }
}