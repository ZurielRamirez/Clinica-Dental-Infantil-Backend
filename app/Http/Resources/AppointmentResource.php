<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class AppointmentResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'appointment_date' => $this->appointment_date->format('Y-m-d H:i:s'),
            'status' => $this->status,
            'notes' => $this->notes,
            'patient' => $this->whenLoaded('patient', function () {
                return [
                    'id' => $this->patient->id,
                    'first_name' => $this->patient->first_name,
                    'last_name' => $this->patient->last_name,
                ];
            }),
            'dentist' => $this->whenLoaded('dentist', function () {
                return [
                    'id' => $this->dentist->id,
                    'name' => $this->dentist->name,
                ];
            }),
            'treatments' => $this->whenLoaded('treatments', function () {
                return $this->treatments->map(function ($treatment) {
                    return [
                        'id' => $treatment->id,
                        'name' => $treatment->name,
                        'cost' => $treatment->pivot->cost,
                    ];
                });
            }),
        ];
    }
}