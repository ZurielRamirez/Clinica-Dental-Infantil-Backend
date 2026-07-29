<?php

namespace App\Http\Controllers\Api;

use App\Models\Patient;
use App\Http\Requests\AppointmentRequest;
use App\Http\Resources\AppointmentResource;
use App\Http\Controllers\Controller;
use App\Models\Appointment;
use App\Services\TwilioService;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

class AppointmentController extends Controller
{
    protected TwilioService $twilio;

    public function __construct(TwilioService $twilio)
    {
        $this->twilio = $twilio;
    }

    public function index(Request $request): JsonResponse
    {
        $this->authorize('viewAny', Appointment::class);

        $user = $request->user();

        $query = Appointment::with(['patient', 'dentist']);

        if ($user->hasRole('dentist')) {
            $query->where('dentist_id', $user->id);
        } elseif ($user->hasRole('tutor')) {
            $query->whereHas('patient', function ($q) use ($user) {
                $q->where('tutor_id', $user->id);
            });
        }

        $appointments = $query->paginate(10);

        return AppointmentResource::collection($appointments)->response();
    }

   public function store(AppointmentRequest $request): JsonResponse
{
    $this->authorize('create', Appointment::class);

    $data = $request->validated();
    $user = $request->user();

    if ($user->hasRole('tutor')) {
        $patient = Patient::findOrFail($data['patient_id']);

        if ($patient->tutor_id !== $user->id) {
            abort(403, 'No puedes agendar citas para pacientes que no son tuyos.');
        }
    }

    $yaOcupado = Appointment::where('dentist_id', $data['dentist_id'])
        ->where('appointment_date', $data['appointment_date'])
        ->exists();

    if ($yaOcupado) {
        return response()->json([
            'message' => 'El dentista ya tiene una cita agendada en ese horario.',
        ], 422);
    }

    $data['status'] = 'pending';

    $appointment = Appointment::create($data);
    $appointment->load('patient.tutor');

    $this->notificarConfirmacion($appointment);

    return (new AppointmentResource($appointment))->response()->setStatusCode(201);
}

private function notificarConfirmacion(Appointment $appointment): void
{
    $tutor = $appointment->patient->tutor;

    if (!$tutor || !$tutor->phone) {
        return;
    }

    $fecha = $appointment->appointment_date->format('d/m/Y H:i');
    $mensaje = "Hola {$tutor->name}, tu cita para {$appointment->patient->first_name} quedó agendada para el {$fecha}. - Clínica Dental Infantil";

    try {
        $this->twilio->sendSms($tutor->phone, $mensaje);
    } catch (\Exception $e) {
        \Log::error('Error enviando SMS de confirmación: ' . $e->getMessage());
    }
}
    public function show(Appointment $appointment): JsonResponse
    {
        $this->authorize('view', $appointment);

        return (new AppointmentResource($appointment->load('patient', 'dentist', 'treatments')))->response();
    }

    public function update(AppointmentRequest $request, Appointment $appointment): JsonResponse
    {
        $this->authorize('update', $appointment);

        $appointment->update($request->validated());

        return (new AppointmentResource($appointment))->response();
    }

public function cancel(Appointment $appointment): JsonResponse
{
    $this->authorize('cancel', $appointment);

    $appointment->update(['status' => 'cancelled']);
    $appointment->load('patient.tutor');

    $this->notificarCancelacion($appointment);

    return (new AppointmentResource($appointment))->response();
}

private function notificarCancelacion(Appointment $appointment): void
{
    $tutor = $appointment->patient->tutor;

    if (!$tutor || !$tutor->phone) {
        return;
    }

    $fecha = $appointment->appointment_date->format('d/m/Y H:i');
    $mensaje = "Hola {$tutor->name}, tu cita para {$appointment->patient->first_name} programada para el {$fecha} ha sido cancelada. - Clínica Dental Infantil";

    try {
        $this->twilio->sendSms($tutor->phone, $mensaje);
    } catch (\Exception $e) {
        \Log::error('Error enviando SMS de cancelación: ' . $e->getMessage());
    }
}

    public function destroy(Appointment $appointment): JsonResponse
    {
        $this->authorize('delete', $appointment);

        $appointment->delete();

        return response()->json(null, 204);
    }
}