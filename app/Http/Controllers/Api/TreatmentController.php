<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\TreatmentRequest;
use App\Models\Treatment;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

class TreatmentController extends Controller
{
    public function index(Request $request): JsonResponse
    {
        $this->authorize('viewAny', Treatment::class);

        $query = Treatment::query();

        if ($request->filled('search')) {
            $query->where('name', 'like', '%' . $request->input('search') . '%');
        }

        $treatments = $query->paginate(10);

        return response()->json($treatments);
    }

    public function store(TreatmentRequest $request): JsonResponse
    {
        $this->authorize('create', Treatment::class);

        $treatment = Treatment::create($request->validated());

        return response()->json($treatment, 201);
    }

    public function show(Treatment $treatment): JsonResponse
    {
        $this->authorize('view', $treatment);

        return response()->json($treatment);
    }

    public function update(TreatmentRequest $request, Treatment $treatment): JsonResponse
    {
        $this->authorize('update', $treatment);

        $treatment->update($request->validated());

        return response()->json($treatment);
    }

    public function destroy(Treatment $treatment): JsonResponse
    {
        $this->authorize('delete', $treatment);

        $treatment->delete();

        return response()->json(null, 204);
    }
}