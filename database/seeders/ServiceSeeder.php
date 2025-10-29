<?php

declare(strict_types=1);

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Service;
use Illuminate\Support\Str;

class ServiceSeeder extends Seeder
{
    public function run(): void
    {
        $services = [
            'IT Essentials',
            'IT Productivity Suites',
            'Digital Transformation & Enabler',
            'Cyber Security Solution',
            'Telecommunication Solutions',
            'Power & Utilities',
            'Public Safety',
            'Defence Tactical Solutions',
            'Deployment Operation Services',
            'DevSecOps',
        ];

        foreach ($services as $name) {
            Service::create([
                'name' => $name,
                'slug' => Str::slug($name),
            ]);
        }
    }
}
