<?php

namespace App\Http\Controllers\Api;

use App\Http\Resources\UserResource;
use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class UserController extends Controller
{
    public function index(): JsonResponse
    {
        $users = User::with('roles')->paginate(10);

        return UserResource::collection($users)->response();
    }

    public function toggleActive(Request $request, User $user): JsonResponse
    {
        if ($user->id === $request->user()->id) {
            abort(403, 'No puedes desactivar tu propia cuenta.');
        }

        $user->update(['active' => !$user->active]);

        return (new UserResource($user->load('roles')))->response();
    }
}
