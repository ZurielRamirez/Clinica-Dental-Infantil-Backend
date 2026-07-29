<?php

namespace App\Policies;

use App\Models\Appointment;
use App\Models\User;

class AppointmentPolicy
{
    public function viewAny(User $user): bool
    {
        return $user->hasRole('admin') || $user->hasRole('dentist') || $user->hasRole('tutor');
    }

    public function view(User $user, Appointment $appointment): bool
    {
        if ($user->hasRole('admin')) {
            return true;
        }

        if ($user->hasRole('dentist')) {
            return $appointment->dentist_id === $user->id;
        }

        return $user->hasRole('tutor') && $appointment->patient->tutor_id === $user->id;
    }

    public function create(User $user): bool
    {
        return $user->hasRole('admin') || $user->hasRole('tutor');
    }

    public function update(User $user, Appointment $appointment): bool
    {
        if ($user->hasRole('admin')) {
            return true;
        }

        return $user->hasRole('dentist') && $appointment->dentist_id === $user->id;
    }

    public function delete(User $user, Appointment $appointment): bool
    {
        return $user->hasRole('admin');
    }

    public function cancel(User $user, Appointment $appointment): bool
    {
        if ($user->hasRole('admin') || $user->hasRole('dentist')) {
            return true;
        }

        if (!$user->hasRole('tutor') || $appointment->patient->tutor_id !== $user->id) {
            return false;
        }

        return now()->diffInHours($appointment->appointment_date, false) >= 24;
    }
    
}