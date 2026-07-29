<?php

namespace App\Services;

use Twilio\Rest\Client;

class TwilioService
{
    protected Client $client;

    public function __construct()
    {
        $this->client = new Client(
            config('services.twilio.sid'),
            config('services.twilio.auth_token')
        );
    }

    public function sendSms(string $to, string $message): void
    {
        $this->client->messages->create($to, [
            'from' => config('services.twilio.sms_from'),
            'body' => $message,
        ]);
    }

    public function sendWhatsApp(string $to, string $message): void
    {
        $this->client->messages->create('whatsapp:' . $to, [
            'from' => config('services.twilio.whatsapp_from'),
            'body' => $message,
        ]);
    }
}
