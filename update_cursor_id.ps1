# Windows 10 �汾�� Cursor ID ���½ű�

# �����ļ�·��
$STORAGE_FILE = "$env:APPDATA\Cursor\User\globalStorage\storage.json"

# ������� ID �ĺ���
function Generate-RandomId {
    $randomBytes = New-Object byte[] 32
    $rng = [System.Security.Cryptography.RNGCryptoServiceProvider]::new()
    $rng.GetBytes($randomBytes)
    $rng.Dispose()
    return [System.BitConverter]::ToString($randomBytes) -replace '-',''
}

# ��ȡ�� ID������ṩ������ʹ�ò���������������� ID��
$NEW_ID = if ($args[0]) { $args[0] } else { Generate-RandomId }

# �������ݵĺ���
function Backup-File {
    if (Test-Path $STORAGE_FILE) {
        $backupPath = "${STORAGE_FILE}.backup_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
        Copy-Item $STORAGE_FILE $backupPath
        Write-Host "�Ѵ��������ļ�"
    }
}

# ȷ��Ŀ¼����
$directory = Split-Path $STORAGE_FILE -Parent
if (-not (Test-Path $directory)) {
    New-Item -ItemType Directory -Path $directory -Force | Out-Null
}

# ��������
Backup-File

# ����ļ������ڣ������µ� JSON
if (-not (Test-Path $STORAGE_FILE)) {
    "{}" | Set-Content $STORAGE_FILE
}

# ���� machineId
$content = Get-Content $STORAGE_FILE -Raw
if ($content) {
    $pattern = '"telemetry\.machineId"\s*:\s*"[^"]*"'
    $replacement = """telemetry.machineId"": ""$NEW_ID"""
    $content = $content -replace $pattern, $replacement
    $content | Set-Content $STORAGE_FILE -NoNewline
}

Write-Host "�ѳɹ��޸� machineId Ϊ: $NEW_ID"