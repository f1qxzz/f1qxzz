$ErrorActionPreference = "Stop"

$repoPath = "D:\PROJECT\f1qxzz-profile"
Set-Location $repoPath

git config user.name "f1qxzz"
git config user.email "fiqqganz07@gmail.com"

$logFile = Join-Path $repoPath "activity-log.md"
if (-not (Test-Path $logFile)) {
  New-Item -Path $logFile -ItemType File | Out-Null
}

$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss K"
Add-Content -Path $logFile -Value "- $timestamp | heartbeat"

# Keep log compact.
$lines = Get-Content -Path $logFile
if ($lines.Count -gt 500) {
  $lines | Select-Object -Last 500 | Set-Content -Path $logFile
}

git add activity-log.md 

$hasChanges = git status --porcelain activity-log.md
if ($hasChanges) {
  git commit -m "chore: heartbeat update"
  git push origin main
}
