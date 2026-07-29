<?php

namespace App\Http\Controllers\Api;
use App\Http\Resources\UserResource;
use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\JsonResponse;

class UserController extends Controller
{
public function index(): JsonResponse
{
    $users = User::with('roles')->paginate(10);

    return UserResource::collection($users)->response();
}
}