<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class PatientRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        $isUpdate = $this->isMethod('PATCH');

        $rules = [
            'first_name' => [$isUpdate ? 'sometimes' : 'required', 'string', 'max:255'],
            'last_name' => [$isUpdate ? 'sometimes' : 'required', 'string', 'max:255'],
            'birth_date' => [$isUpdate ? 'sometimes' : 'required', 'date', 'before:today'],
            'allergies' => ['nullable', 'string'],
            'medical_notes' => ['nullable', 'string'],
        ];

        if ($this->user()->hasRole('admin')) {
            $rules['tutor_id'] = [$isUpdate ? 'sometimes' : 'required', 'exists:users,id'];
        }

        return $rules;
    }
}