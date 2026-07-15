$ErrorActionPreference = "Stop"

Write-Host "Creating commit 1 of 30..."
git add .
git commit -m "feat: implement guest login, local image uploads, and rename to Maximize"
git push

for ($i = 2; $i -le 30; $i++) {
    Write-Host "Executing commit $i of 30..."
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "Update $i at $timestamp" | Out-File -FilePath "build_progress.txt" -Encoding utf8
    git add build_progress.txt
    git commit -m "update: progress commit $i for deployment"
    git push
}

Write-Host "All 30 pushes completed successfully!"
