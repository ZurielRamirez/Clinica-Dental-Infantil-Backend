<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class AppointmentRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        $isUpdate = $this->isMethod('PATCH');

        return [
            'patient_id' => [$isUpdate ? 'sometimes' : 'required', 'exists:patients,id'],
            'dentist_id' => [$isUpdate ? 'sometimes' : 'required', 'exists:users,id'],
            'appointment_date' => [$isUpdate ? 'sometimes' : 'required', 'date', 'after:now'],
            'status' => ['sometimes', Rule::in(['pending', 'confirmed', 'completed', 'cancelled'])],
            'notes' => ['nullable', 'string'],
        ];
    }
}
