# Windows 10 版本的 Cursor ID 更新脚本

# 配置文件路径
$STORAGE_FILE = "$env:APPDATA\Cursor\User\globalStorage\storage.json"

# 生成随机 ID 的函数
function Generate-RandomId {
    $randomBytes = New-Object byte[] 32
    $rng = [System.Security.Cryptography.RNGCryptoServiceProvider]::new()
    $rng.GetBytes($randomBytes)
    $rng.Dispose()
    return [System.BitConverter]::ToString($randomBytes) -replace '-',''
}

# 获取新 ID（如果提供参数则使用参数，否则生成随机 ID）
$NEW_ID = if ($args[0]) { $args[0] } else { Generate-RandomId }

# 创建备份的函数
function Backup-File {
    if (Test-Path $STORAGE_FILE) {
        $backupPath = "${STORAGE_FILE}.backup_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
        Copy-Item $STORAGE_FILE $backupPath
        Write-Host "已创建备份文件"
    }
}

# 确保目录存在
$directory = Split-Path $STORAGE_FILE -Parent
if (-not (Test-Path $directory)) {
    New-Item -ItemType Directory -Path $directory -Force | Out-Null
}

# 创建备份
Backup-File

# 如果文件不存在，创建新的 JSON
if (-not (Test-Path $STORAGE_FILE)) {
    "{}" | Set-Content $STORAGE_FILE
}

# 更新 machineId
$content = Get-Content $STORAGE_FILE -Raw
if ($content) {
    $pattern = '"telemetry\.machineId"\s*:\s*"[^"]*"'
    $replacement = """telemetry.machineId"": ""$NEW_ID"""
    $content = $content -replace $pattern, $replacement
    $content | Set-Content $STORAGE_FILE -NoNewline
}

Write-Host "已成功修改 machineId 为: $NEW_ID"