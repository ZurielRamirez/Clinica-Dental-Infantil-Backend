<?php

namespace App\Policies;

use App\Models\Patient;
use App\Models\User;

class PatientPolicy
{
    public function viewAny(User $user): bool
    {
        return $user->hasRole('admin') || $user->hasRole('dentist') || $user->hasRole('tutor');
    }

    public function view(User $user, Patient $patient): bool
    {
        if ($user->hasRole('admin') || $user->hasRole('dentist')) {
            return true;
        }

        return $user->hasRole('tutor') && $patient->tutor_id === $user->id;
    }

    public function create(User $user): bool
    {
        return $user->hasRole('admin') || $user->hasRole('tutor');
    }

    public function update(User $user, Patient $patient): bool
    {
        if ($user->hasRole('admin')) {
            return true;
        }

        return $user->hasRole('tutor') && $patient->tutor_id === $user->id;
    }

    public function delete(User $user, Patient $patient): bool
    {
        return $user->hasRole('admin');
    }
}