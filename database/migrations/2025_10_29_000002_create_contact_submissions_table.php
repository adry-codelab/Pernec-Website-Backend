<?php

declare(strict_types=1);

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('contact_submissions', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->string('name', 100);
            $table->string('email', 150);
            $table->string('phone', 20)->nullable();
            $table->unsignedBigInteger('service_id');
            $table->string('subject', 200);
            $table->text('message');
            $table->timestamps();

            $table->foreign('service_id')->references('id')->on('services');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('contact_submissions');
    }
};
