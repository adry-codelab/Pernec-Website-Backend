<?php

declare(strict_types=1);

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\ServiceController;
use App\Http\Controllers\Api\ContactController;

Route::get('/services', [ServiceController::class, 'index']);
Route::post('/contact', [ContactController::class, 'store']);
