<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Patient;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use App\Http\Requests\PatientRequest;

class PatientController extends Controller
{
    public function index(Request $request): JsonResponse
    {
        $this->authorize('viewAny', Patient::class);

        $user = $request->user();

        $query = Patient::query();

        if ($user->hasRole('tutor')) {
            $query->where('tutor_id', $user->id);
        }

        if ($request->filled('search')) {
            $search = $request->input('search');
            $query->where(function ($q) use ($search) {
                $q->where('first_name', 'like', "%{$search}%")
                  ->orWhere('last_name', 'like', "%{$search}%");
            });
        }

        $patients = $query->paginate(10);

        return response()->json($patients);
    }
    public function store(PatientRequest $request): JsonResponse
    {
    $this->authorize('create', Patient::class);

    $data = $request->validated();

    if ($request->user()->hasRole('tutor')) {
        $data['tutor_id'] = $request->user()->id;
    }

    $patient = Patient::create($data);

    return response()->json($patient, 201);
    }
    public function show(Patient $patient): JsonResponse
    {
        $this->authorize('view', $patient);

        return response()->json($patient);
    }
    public function update(PatientRequest $request, Patient $patient): JsonResponse
{
    $this->authorize('update', $patient);

    $data = $request->validated();

    if ($request->user()->hasRole('tutor')) {
        unset($data['tutor_id']);
    }

    $patient->update($data);

    return response()->json($patient);
}
public function destroy(Patient $patient): JsonResponse
{
    $this->authorize('delete', $patient);

    $patient->delete();

    return response()->json(null, 204);
}
}