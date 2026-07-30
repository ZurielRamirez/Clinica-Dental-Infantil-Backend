<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
</head>
<body style="font-family: Arial, sans-serif; background-color: #f4f4f4; padding: 20px;">
    <div style="max-width: 500px; margin: 0 auto; background: #ffffff; border-radius: 8px; padding: 24px;">
        <h2 style="color: #0B5B42;">Clínica Dental Infantil</h2>

        @if($tipo === 'confirmacion')
            <p>Hola <strong>{{ $appointment->patient->tutor->name }}</strong>,</p>
            <p>Tu cita para <strong>{{ $appointment->patient->first_name }}</strong> ha quedado agendada:</p>
        @else
            <p>Hola <strong>{{ $appointment->patient->tutor->name }}</strong>,</p>
            <p>Tu cita para <strong>{{ $appointment->patient->first_name }}</strong> ha sido <strong>cancelada</strong>:</p>
        @endif

        <p><strong>Fecha:</strong> {{ $appointment->appointment_date->format('d/m/Y H:i') }}</p>

        @if($appointment->notes)
            <p><strong>Notas:</strong> {{ $appointment->notes }}</p>
        @endif

        <hr style="margin: 20px 0; border: none; border-top: 1px solid #eee;">
        <p style="font-size: 12px; color: #888;">Este es un correo automático, por favor no respondas a este mensaje.</p>
    </div>
</body>
</html>
