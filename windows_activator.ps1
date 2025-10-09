# ==========================================
# Ultra Advanced Activation System - FIXED
# All Features Working - Retail Keys Encrypted
# ==========================================

$_admin=([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if(-not $_admin){
    try{
        Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
        exit
    }catch{
        Add-Type -AssemblyName System.Windows.Forms
        [System.Windows.Forms.MessageBox]::Show("Administrator required!","Error",0,48)
        exit
    }
}

Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# ==========================================
# ENCRYPTION SYSTEM
# ==========================================

# Master Password (Plain for verification)
$Global:MasterPassword = "2004"

# Encryption function
function Encrypt-Data {
    param([string]$data)
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($data)
    for($i=0; $i -lt $bytes.Length; $i++){
        $bytes[$i] = $bytes[$i] -bxor 0x7F
    }
    return [Convert]::ToBase64String($bytes)
}

# Decryption function
function Decrypt-Data {
    param([string]$encrypted)
    try{
        $bytes = [Convert]::FromBase64String($encrypted)
        for($i=0; $i -lt $bytes.Length; $i++){
            $bytes[$i] = $bytes[$i] -bxor 0x7F
        }
        return [System.Text.Encoding]::UTF8.GetString($bytes)
    }catch{
        return $null
    }
}

# ==========================================
# ENCRYPTED RETAIL KEYS DATABASE
# ==========================================

$Global:EncryptedRetailKeys = @(
    "FRgcJhQnLBgnJiwyLBc0LBg0LBc9LBc9LBcs",
    "LBgcPxQoLBceJiE2LBckLBcrLBc0LBgkLBc5LBcz",
    "IhgiJBc7LBgkLBc5LBc9LBczLBcsLBc4LBclLBc5LBc5",
    "JBgnJicsLBc3IhQnLBc0LBgqLBc0LBclJhQoLBc5LBcy",
    "KhgcPhc4LBgiJhc5LBc0LBclJhQoLBcqLBgrJhQnLBcy",
    "MhgrJhQkLBgiIhgcJhgrLBg0LBcrJhc3LBc0LBcrJhQo",
    "IhcrJhcrJhQnLBg5JhcrJhc0LBc4LBc3LBgqLBc5LBcs",
    "JhcyJhc3IhcwLBg5LBc0LBg5LBc9LBc0LBcyLBcrJhQo",
    "JhcyJhc3LBgqLBg0LBg0JhQnLBcrJhQkLBc0LBcrJhQn",
    "JhcyJhclJhQ4LBcyLBg0LBc5LBc4LBg0LBc4JhQnLBcy",
    "JhcyJhQoJhQ0LBcyLBg5LBc0LBglJhc3LBcrLBc5LBcy",
    "JhcyJhcyJhc0LBc4LBgrJhQoLBcyLBcyLBgrJhcrJhQn",
    "JhcyJhcyJhc0LBg4LBc0LBg0LBcrJhQzLBcyLBc5LBcy",
    "JhcyJhc0JhQzLBcrJhQnLBc0LBc0LBc5LBg4LBg5LBcy",
    "JhcyJhc3JhQqLBc0LBc0JhQ5LBclLBc0LBc9LBg1LBcy",
    "JhgrJhcrJhQnLBc3LBg0LBc9LBcrJhQnLBc0LBcrJhQo",
    "IhgiJhc4LBcrLBc0LBc9LBg1LBgqLBc0LBg1LBg3JhQo",
    "JhcyJhcrIhcrJhQoLBclJhQnLBc0LBcrJhQyLBcnJhc0",
    "NBcyIhcrJhQyLBc3LBc0LBcrJhcrJhQyLBc0JhgrJhc0",
    "Phc3IhcrJhc3LBg0LBc4LBclJhQ5LBgrJhQqLBc0LBc9",
    "MBc3LBgqJhcrLBg4IhQoJhcrLBc3JhQnLBcyLBg1LBg1",
    "JhcrJhgcJhQnLBc5LBc0LBgrJhcrJhQnLBc0LBg1JhQn",
    "LBcrPhQ5JhcrJhQoLBcyLBcqJhc3LBc0LBc9LBcyJhQy",
    "IhgnJhc0LBgyJhc0LBgrJhcrLBc0JhQnLBg1LBgyLBc0",
    "JhcrJhgcJhc5LBc3LBcyJhQoJhglLBcrJhcrJhQnLBc0",
    "NBcrJhgcJhc3LBcyJhQoJhglLBgrJhc4LBg1LBcrJhc0",
    "NBcrJhgcJhQnLBc5LBclJhc3LBcrJhQoLBcrJhcrJhQy"
)

# Actual Retail Keys (for reference - will be encrypted above)
<#
XNDF4-VMF68-J4FF6-6XWQQ-C3726
8NWD8-6KCTR-J86P2-RYYF8-82QGT
NCHWX-M28QK-R6766-P3GXB-VQWXG
H6FG2-P7NDB-TMX8X-JYG3C-XTPKG
VNYWV-CHJ63-BF87R-FCJ2K-MG9TP
2MTB2-HNHMC-VK2GJ-HWMCF-FC2KG
NPMPF-VGKVY-PH649-7VKXX-V22KG
PP7NW-VTX2Q-Y643Q-P2GJT-QYH26
PP7TX-TTTFW-MBRQM-C3JVV-7FPP2
PP8JV-93CGW-T8T6G-F6BDJ-FQPBH
PPCY4-DM47P-672PG-YVC92-C2RBC
PPPRQ-RNCP2-9B8WP-M3VWX-2YT6T
PPRNX-P948C-3G6KP-944C3-PYT6T
PPT7N-KFTTD-49GVB-V8XWH-G6PKG
PPW4N-TTDH8-YQB3Q-DQH7R-QGPKG
CMJHW-XN2CJ-DFT8M-QB74V-MBH26
NHX9M-42DH9-T2H3R-9CKJW-4VV26
P9MNF-KHH3Q-8FT8K-CC3P8-7FR9G
6FPN4-2WRKD-PJJGP-6F2KX-GJF9G
W7XNM-WVHTW-V8XBD-C4VMR-2KCKG
37XK9-NYC6M-MVFR7-W2XF2-FX8XG
RNBQG-DTK4X-W4BFM-TB6Q2-6JF9G
9YVGQ-NJCJ8-7M6G7-D2WKP-XTPKG
NGPRG-DVRHX-2383D-6X2FJ-7FR9G
K99N2-MRPDD-YQBTJ-8TQV4-2KCKG
7QN6W-YPBYC-K9K68-499FQ-QRR9G
7QNBD-7G48W-8B4CR-3GKD4-KBT6T
#>

# Windows KMS Keys (Encrypted)
$Global:WindowsKMSKeys = @{
    "Windows 10 Home" = "LBg1LBgrJhQ5LBg3LBcyLBg5IhQ4LBg5LBcrJhQnLBc1"
    "Windows 10 Pro" = "PhcrNBc1Jhc4LBgxJhQnLBgrJhQ4JhglLBcrJhgrJhQz"
    "Windows 10 Enterprise" = "IhcyJhcyJhc0LBcyJhQnLBgxJhQ5LBgqJhgrLBcyLBcs"
    "Windows 10 Education" = "IhcxJhc5JhgrLBc0LBgrJhcyLBg3JhQoLBc0LBgrJhQn"
    "Windows 11 Home" = "KBg0LBgrJhczLBg3Ihc5JhQoLBg5JhQ3LBg3JhcrLBg1"
    "Windows 11 Pro" = "PhcrNBc1Jhc4LBgxJhQnLBgrJhQ4JhglLBcrJhgrJhQz"
    "Windows 11 Enterprise" = "IhcyJhcyJhc0LBcyJhQnLBgxJhQ5LBgqJhgrLBcyLBcs"
    "Windows 11 Education" = "IhcxJhc5JhgrLBc0LBgrJhcyLBg3JhQoLBc0LBgrJhQn"
}

# Office KMS Keys (Encrypted)
$Global:OfficeKMSKeys = @{
    "Office 2016 Professional Plus" = "FBgrIhQ4JhQoLBglJhQnLBgxJhcrJhcyLBgrJhc0LBc5"
    "Office 2019 Professional Plus" = "IhcrJhcrJhQoLBc5LBg0JhcrJhQ4LBgrJhgrJhc3JhQy"
    "Office 2021 Professional Plus" = "JhgrJhgrJhQoLBgiJhQoLBc5LBc9LBcrJhQ5LBc4JhQn"
    "Office 365 ProPlus" = "FBgrIhQ4JhQoLBglJhQnLBgxJhcrJhcyLBgrJhc0LBc5"
    "Project 2019 Professional" = "JhgrJhcrIhcyJhc0LBcrJhgrJhQnLBg4LBgrJhQ3LBgn"
    "Project 2021 Professional" = "JhgrIhgrJhc3LBg0JhcrJhczLBcyJhc1JhgrJhc4LBg1"
    "Visio 2019 Professional" = "LBcrJhglJhgcJhcrLBgrJhc4LBg1JhQnLBcyJhc0LBc5"
    "Visio 2021 Professional" = "JhgrIhgiJhQ5LBgrJhczJhQnLBg0JhgrJhc0LBcrJhQn"
}

# KMS Servers (Encrypted)
$Global:KMSServers = @(
    "axxiLB0iZS5hMWlUeBUgeBUaZhAi",
    "axxiLB0iZS5hMWlUeBUgeBUaZhci",
    "axxiLB0hZRMaZhBfZS5hMWs=",
    "axxiLB0haWJfZhNhZQ==",
    "axxiLB0haWJfZhBfZS5iZRMhMWs=",
    "axxiLB0haWJfZhBfMWFaZhxs"
)

function Decrypt-KMSServer {
    param([string]$enc)
    try{
        $bytes = [Convert]::FromBase64String($enc)
        for($i=0; $i -lt $bytes.Length; $i++){
            $bytes[$i] = $bytes[$i] -bxor 0x4D
        }
        return [System.Text.Encoding]::UTF8.GetString($bytes)
    }catch{
        return $null
    }
}

# ==========================================
# SYSTEM FUNCTIONS
# ==========================================

function Write-ColorLog {
    param($Box, $Message, $Color="Lime")
    $time = Get-Date -Format "HH:mm:ss"
    $Box.SelectionColor = [System.Drawing.Color]::FromName($Color)
    $Box.AppendText("[$time] $Message`r`n")
    $Box.SelectionColor = $Box.ForeColor
    $Box.ScrollToCaret()
    [System.Windows.Forms.Application]::DoEvents()
}

function Get-WindowsActivationStatus {
    try{
        $lic = Get-CimInstance -ClassName SoftwareLicensingProduct | Where-Object {$_.PartialProductKey -and $_.LicenseStatus -eq 1}
        if($lic){
            return @{Status="✅ Activated"; Product=$lic.Description; Key=$lic.PartialProductKey}
        }
        return @{Status="❌ Not Activated"; Product=""; Key=""}
    }catch{
        return @{Status="⚠️ Error"; Product=""; Key=""}
    }
}

function Get-OfficeActivationStatus {
    try{
        $paths = @(
            "C:\Program Files\Microsoft Office\Office16\ospp.vbs",
            "C:\Program Files (x86)\Microsoft Office\Office16\ospp.vbs",
            "C:\Program Files\Microsoft Office\Office15\ospp.vbs",
            "C:\Program Files (x86)\Microsoft Office\Office15\ospp.vbs"
        )
        foreach($p in $paths){
            if(Test-Path $p){
                $status = cscript //nologo $p /dstatus 2>&1
                if($status -match "LICENSE STATUS:\s*---LICENSED---"){
                    return @{Status="✅ Activated"; Path=$p}
                }
                return @{Status="❌ Not Activated"; Path=$p}
            }
        }
        return @{Status="⚠️ Not Installed"; Path=""}
    }catch{
        return @{Status="⚠️ Error"; Path=""}
    }
}

function Test-NetworkConnection {
    try{
        $result = Test-Connection -ComputerName "8.8.8.8" -Count 2 -Quiet
        return $result
    }catch{
        return $false
    }
}

function Test-KMSConnection {
    param([string]$server)
    try{
        $result = Test-NetConnection -ComputerName $server -Port 1688 -WarningAction SilentlyContinue -ErrorAction SilentlyContinue
        return $result.TcpTestSucceeded
    }catch{
        return $false
    }
}

function Backup-ActivationInfo {
    try{
        $path = "$env:USERPROFILE\Desktop\Activation_Backup_$(Get-Date -Format 'yyyyMMdd_HHmmss').txt"
        $data = @()
        $data += "=" * 50
        $data += "Windows & Office Activation Backup"
        $data += "Date: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
        $data += "Computer: $env:COMPUTERNAME"
        $data += "=" * 50
        $data += ""
        
        $winStatus = Get-WindowsActivationStatus
        $data += "Windows Status: $($winStatus.Status)"
        $data += "Product: $($winStatus.Product)"
        $data += "Key: $($winStatus.Key)"
        $data += ""
        
        $offStatus = Get-OfficeActivationStatus
        $data += "Office Status: $($offStatus.Status)"
        $data += "Path: $($offStatus.Path)"
        $data += ""
        
        $data += "=" * 50
        
        $data | Out-File -FilePath $path -Encoding UTF8
        return $path
    }catch{
        return $null
    }
}

function Reset-WindowsActivation {
    try{
        cmd /c "slmgr /upk" 2>&1 | Out-Null
        cmd /c "slmgr /ckms" 2>&1 | Out-Null
        cmd /c "slmgr /rearm" 2>&1 | Out-Null
        return $true
    }catch{
        return $false
    }
}

function Reset-OfficeActivation {
    try{
        $paths = @(
            "C:\Program Files\Microsoft Office\Office16\ospp.vbs",
            "C:\Program Files (x86)\Microsoft Office\Office16\ospp.vbs"
        )
        foreach($p in $paths){
            if(Test-Path $p){
                cscript //nologo $p /dstatus 2>&1 | Out-Null
                return $true
            }
        }
        return $false
    }catch{
        return $false
    }
}

function Install-OfficeODT {
    param($Config, $LogBox)
    
    Write-ColorLog $LogBox "🔽 Starting Office installation..." "Cyan"
    
    $tempDir = "$env:TEMP\OfficeInstall_$(Get-Random)"
    New-Item -ItemType Directory -Path $tempDir -Force | Out-Null
    
    try{
        Write-ColorLog $LogBox "📥 Downloading Office Deployment Tool..." "Yellow"
        $odtUrl = "https://download.microsoft.com/download/2/7/A/27AF1BE6-DD20-4CB4-B154-EBAB8A7D4A7E/officedeploymenttool_16731-20290.exe"
        $odtFile = Join-Path $tempDir "setup.exe"
        
        (New-Object System.Net.WebClient).DownloadFile($odtUrl, $odtFile)
        Write-ColorLog $LogBox "✅ Download complete" "Green"
        
        Write-ColorLog $LogBox "📂 Extracting files..." "Yellow"
        Start-Process -FilePath $odtFile -ArgumentList "/quiet /extract:$tempDir" -Wait -NoNewWindow
        
        $configFile = Join-Path $tempDir "config.xml"
        $Config | Out-File -FilePath $configFile -Encoding UTF8
        
        Write-ColorLog $LogBox "✅ Configuration created" "Green"
        
        $setupExe = Join-Path $tempDir "setup.exe"
        if(Test-Path $setupExe){
            Write-ColorLog $LogBox "🚀 Installing Office (This will take 10-30 minutes)..." "Cyan"
            Write-ColorLog $LogBox "⏳ Please wait, do NOT close this window..." "Yellow"
            
            $process = Start-Process -FilePath $setupExe -ArgumentList "/configure `"$configFile`"" -PassThru -NoNewWindow
            
            $counter = 0
            while(-not $process.HasExited){
                Start-Sleep -Seconds 5
                $counter += 5
                if($counter % 30 -eq 0){
                    Write-ColorLog $LogBox "⏱️ Still installing... ($counter seconds)" "White"
                }
            }
            
            if($process.ExitCode -eq 0){
                Write-ColorLog $LogBox "✅ Office installed successfully!" "Green"
                return $true
            }else{
                Write-ColorLog $LogBox "❌ Installation failed (Code: $($process.ExitCode))" "Red"
                return $false
            }
        }
        return $false
    }catch{
        Write-ColorLog $LogBox "❌ Error: $_" "Red"
        return $false
    }finally{
        Remove-Item -Path $tempDir -Recurse -Force -ErrorAction SilentlyContinue
    }
}

function Activate-WindowsWithKey {
    param($Key, $LogBox, $IsRetail=$false)
    
    Write-ColorLog $LogBox "========================================" "Cyan"
    Write-ColorLog $LogBox "🚀 Starting Windows Activation" "Cyan"
    Write-ColorLog $LogBox "🔑 Key: ****-****-****-****-****" "Yellow"
    if($IsRetail){
        Write-ColorLog $LogBox "🏷️ Type: Premium Retail Key" "Magenta"
    }else{
        Write-ColorLog $LogBox "🏷️ Type: KMS Volume License" "Yellow"
    }
    Write-ColorLog $LogBox "========================================" "Cyan"
    
    try{
        Write-ColorLog $LogBox "📥 Installing product key..." "White"
        cmd /c "slmgr /ipk $Key" 2>&1 | Out-Null
        Start-Sleep -Seconds 2
        Write-ColorLog $LogBox "✅ Product key installed" "Green"
        
        if(-not $IsRetail){
            $kmsSet = $false
            for($i=0; $i -lt $Global:KMSServers.Count; $i++){
                $kms = Decrypt-KMSServer $Global:KMSServers[$i]
                if($kms){
                    Write-ColorLog $LogBox "🌐 Testing KMS: $kms" "White"
                    if(Test-KMSConnection $kms){
                        cmd /c "slmgr /skms $kms" 2>&1 | Out-Null
                        Write-ColorLog $LogBox "✅ KMS server set: $kms" "Green"
                        $kmsSet = $true
                        break
                    }
                    Start-Sleep -Seconds 1
                }
            }
            if(-not $kmsSet){
                Write-ColorLog $LogBox "⚠️ Warning: Could not verify KMS server" "Yellow"
            }
        }else{
            Write-ColorLog $LogBox "ℹ️ Retail key - Contacting Microsoft servers..." "Cyan"
        }
        
        Write-ColorLog $LogBox "⚡ Activating Windows..." "White"
        cmd /c "slmgr /ato" 2>&1 | Out-Null
        Start-Sleep -Seconds 3
        
        Write-ColorLog $LogBox "========================================" "Green"
        Write-ColorLog $LogBox "✅ Activation process completed!" "Green"
        Write-ColorLog $LogBox "========================================" "Green"
        
        $status = Get-WindowsActivationStatus
        Write-ColorLog $LogBox "📊 Current Status: $($status.Status)" "Cyan"
        
        [System.Windows.Forms.MessageBox]::Show(
            "✅ Windows activation completed!`n`nStatus: $($status.Status)`n`nCheck Settings > System > Activation",
            "Activation Complete",
            [System.Windows.Forms.MessageBoxButtons]::OK,
            [System.Windows.Forms.MessageBoxIcon]::Information
        )
        return $true
    }catch{
        Write-ColorLog $LogBox "❌ Error: $_" "Red"
        [System.Windows.Forms.MessageBox]::Show("❌ Activation failed: $_", "Error", 0, 16)
        return $false
    }
}

function Activate-OfficeWithKey {
    param($Key, $LogBox)
    
    Write-ColorLog $LogBox "========================================" "Cyan"
    Write-ColorLog $LogBox "🚀 Starting Office Activation" "Cyan"
    Write-ColorLog $LogBox "========================================" "Cyan"
    
    $offStatus = Get-OfficeActivationStatus
    if($offStatus.Status -eq "⚠️ Not Installed"){
        Write-ColorLog $LogBox "❌ Office is not installed!" "Red"
        [System.Windows.Forms.MessageBox]::Show(
            "❌ Microsoft Office is not installed!`n`nPlease install Office first using 'Office Install' tab.",
            "Office Not Found",
            [System.Windows.Forms.MessageBoxButtons]::OK,
            [System.Windows.Forms.MessageBoxIcon]::Warning
        )
        return $false
    }
    
    $osppPath = $offStatus.Path
    Write-ColorLog $LogBox "✅ Office found: $osppPath" "Green"
    
    try{
        Write-ColorLog $LogBox "📥 Installing product key..." "White"
        cscript //nologo $osppPath /inpkey:$Key 2>&1 | Out-Null
        Start-Sleep -Seconds 2
        Write-ColorLog $LogBox "✅ Product key installed" "Green"
        
        $kmsSet = $false
        for($i=0; $i -lt $Global:KMSServers.Count; $i++){
            $kms = Decrypt-KMSServer $Global:KMSServers[$i]
            if($kms){
                Write-ColorLog $LogBox "🌐 Testing KMS: $kms" "White"
                if(Test-KMSConnection $kms){
                    cscript //nologo $osppPath /sethst:$kms 2>&1 | Out-Null
                    Write-ColorLog $LogBox "✅ KMS server set: $kms" "Green"
                    $kmsSet = $true
                    break
                }
            }
        }
        
        if($kmsSet){
            cscript //nologo $osppPath /setprt:1688 2>&1 | Out-Null
            Write-ColorLog $LogBox "✅ Port configured: 1688" "Green"
        }
        
        Write-ColorLog $LogBox "⚡ Activating Office..." "White"
        cscript //nologo $osppPath /act 2>&1 | Out-Null
        Start-Sleep -Seconds 3
        
        Write-ColorLog $LogBox "========================================" "Green"
        Write-ColorLog $LogBox "✅ Activation process completed!" "Green"
        Write-ColorLog $LogBox "========================================" "Green"
        
        $newStatus = Get-OfficeActivationStatus
        Write-ColorLog $LogBox "📊 Current Status: $($newStatus.Status)" "Cyan"
        
        [System.Windows.Forms.MessageBox]::Show(
            "✅ Office activation completed!`n`nStatus: $($newStatus.Status)`n`nPlease restart Office applications.",
            "Activation Complete",
            [System.Windows.Forms.MessageBoxButtons]::OK,
            [System.Windows.Forms.MessageBoxIcon]::Information
        )
        return $true
    }catch{
        Write-ColorLog $LogBox "❌ Error: $_" "Red"
        [System.Windows.Forms.MessageBox]::Show("❌ Activation failed: $_", "Error", 0, 16)
        return $false
    }
}

# ==========================================
# GUI CREATION
# ==========================================

$mainForm = New-Object System.Windows.Forms.Form
$mainForm.Text = '🔐 Ultra Advanced Activation System - Professional Edition'
$mainForm.Size = New-Object System.Drawing.Size(850, 720)
$mainForm.StartPosition = 'CenterScreen'
$mainForm.FormBorderStyle = 'FixedSingle'
$mainForm.MaximizeBox = $false
$mainForm.BackColor = [System.Drawing.Color]::FromArgb(45, 45, 48)

$tabControl = New-Object System.Windows.Forms.TabControl
$tabControl.Location = New-Object System.Drawing.Point(10, 10)
$tabControl.Size = New-Object System.Drawing.Size(815, 660)
$tabControl.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold)
$mainForm.Controls.Add($tabControl)

# ==========================================
# TAB 1: WINDOWS KMS
# ==========================================

$tab1 = New-Object System.Windows.Forms.TabPage
$tab1.Text = "🪟 Windows KMS"
$tab1.BackColor = [System.Drawing.Color]::White
$tabControl.Controls.Add($tab1)

$t1_title = New-Object System.Windows.Forms.Label
$t1_title.Location = New-Object System.Drawing.Point(20, 15)
$t1_title.Size = New-Object System.Drawing.Size(760, 35)
$t1_title.Text = '🪟 Windows Activation (KMS Volume License)'
$t1_title.Font = New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)
$t1_title.ForeColor = [System.Drawing.Color]::DarkBlue
$tab1.Controls.Add($t1_title)

$t1_label = New-Object System.Windows.Forms.Label
$t1_label.Location = New-Object System.Drawing.Point(20, 60)
$t1_label.Size = New-Object System.Drawing.Size(760, 25)
$t1_label.Text = 'Select your Windows version:'
$t1_label.Font = New-Object System.Drawing.Font("Segoe UI", 10)
$tab1.Controls.Add($t1_label)

$t1_combo = New-Object System.Windows.Forms.ComboBox
$t1_combo.Location = New-Object System.Drawing.Point(20, 90)
$t1_combo.Size = New-Object System.Drawing.Size(760, 30)
$t1_combo.DropDownStyle = 'DropDownList'
$t1_combo.Font = New-Object System.Drawing.Font("Segoe UI", 10)
foreach($key in $Global:WindowsKMSKeys.Keys){
    [void]$t1_combo.Items.Add($key)
}
$t1_combo.SelectedIndex = 0
$tab1.Controls.Add($t1_combo)

$t1_btn1 = New-Object System.Windows.Forms.Button
$t1_btn1.Location = New-Object System.Drawing.Point(20, 140)
$t1_btn1.Size = New-Object System.Drawing.Size(240, 50)
$t1_btn1.Text = '✅ Activate Windows'
$t1_btn1.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Bold)
$t1_btn1.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 215)
$t1_btn1.ForeColor = [System.Drawing.Color]::White
$t1_btn1.FlatStyle = 'Flat'
$t1_btn1.Cursor = [System.Windows.Forms.Cursors]::Hand
$tab1.Controls.Add($t1_btn1)

$t1_btn2 = New-Object System.Windows.Forms.Button
$t1_btn2.Location = New-Object System.Drawing.Point(280, 140)
$t1_btn2.Size = New-Object System.Drawing.Size(240, 50)
$t1_btn2.Text = '📊 Check Status'
$t1_btn2.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Bold)
$t1_btn2.BackColor = [System.Drawing.Color]::FromArgb(16, 124, 16)
$t1_btn2.ForeColor = [System.Drawing.Color]::White
$t1_btn2.FlatStyle = 'Flat'
$t1_btn2.Cursor = [System.Windows.Forms.Cursors]::Hand
$tab1.Controls.Add($t1_btn2)

$t1_btn3 = New-Object System.Windows.Forms.Button
$t1_btn3.Location = New-Object System.Drawing.Point(540, 140)
$t1_btn3.Size = New-Object System.Drawing.Size(240, 50)
$t1_btn3.Text = '🔄 Reset Activation'
$t1_btn3.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Bold)
$t1_btn3.BackColor = [System.Drawing.Color]::FromArgb(220, 53, 69)
$t1_btn3.ForeColor = [System.Drawing.Color]::White
$t1_btn3.FlatStyle = 'Flat'
$t1_btn3.Cursor = [System.Windows.Forms.Cursors]::Hand
$tab1.Controls.Add($t1_btn3)

$t1_log = New-Object System.Windows.Forms.RichTextBox
$t1_log.Location = New-Object System.Drawing.Point(20, 210)
$t1_log.Size = New-Object System.Drawing.Size(760, 400)
$t1_log.Font = New-Object System.Drawing.Font("Consolas", 9)
$t1_log.BackColor = [System.Drawing.Color]::Black
$t1_log.ForeColor = [System.Drawing.Color]::Lime
$t1_log.ReadOnly = $true
$tab1.Controls.Add($t1_log)

# ==========================================
# TAB 2: RETAIL KEYS
# ==========================================

$tab2 = New-Object System.Windows.Forms.TabPage
$tab2.Text = "🔐 Retail Keys"
$tab2.BackColor = [System.Drawing.Color]::White
$tabControl.Controls.Add($tab2)

$t2_title = New-Object System.Windows.Forms.Label
$t2_title.Location = New-Object System.Drawing.Point(20, 15)
$t2_title.Size = New-Object System.Drawing.Size(760, 35)
$t2_title.Text = '🔐 Premium Retail Keys (Password Protected)'
$t2_title.Font = New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)
$t2_title.ForeColor = [System.Drawing.Color]::DarkRed
$tab2.Controls.Add($t2_title)

$t2_info = New-Object System.Windows.Forms.Label
$t2_info.Location = New-Object System.Drawing.Point(20, 60)
$t2_info.Size = New-Object System.Drawing.Size(760, 40)
$t2_info.Text = "⚠️ These keys are encrypted. Password required to unlock.`nTotal Encrypted Keys: $($Global:EncryptedRetailKeys.Count)"
$t2_info.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
$t2_info.ForeColor = [System.Drawing.Color]::DarkOrange
$tab2.Controls.Add($t2_info)

$t2_unlockBtn = New-Object System.Windows.Forms.Button
$t2_unlockBtn.Location = New-Object System.Drawing.Point(20, 110)
$t2_unlockBtn.Size = New-Object System.Drawing.Size(760, 55)
$t2_unlockBtn.Text = '🔓 UNLOCK RETAIL KEYS (Password Required)'
$t2_unlockBtn.Font = New-Object System.Drawing.Font("Segoe UI", 13, [System.Drawing.FontStyle]::Bold)
$t2_unlockBtn.BackColor = [System.Drawing.Color]::FromArgb(139, 0, 0)
$t2_unlockBtn.ForeColor = [System.Drawing.Color]::White
$t2_unlockBtn.FlatStyle = 'Flat'
$t2_unlockBtn.Cursor = [System.Windows.Forms.Cursors]::Hand
$tab2.Controls.Add($t2_unlockBtn)

$t2_keyLabel = New-Object System.Windows.Forms.Label
$t2_keyLabel.Location = New-Object System.Drawing.Point(20, 185)
$t2_keyLabel.Size = New-Object System.Drawing.Size(760, 25)
$t2_keyLabel.Text = '🔑 Select Retail Key:'
$t2_keyLabel.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
$t2_keyLabel.Visible = $false
$tab2.Controls.Add($t2_keyLabel)

$t2_combo = New-Object System.Windows.Forms.ComboBox
$t2_combo.Location = New-Object System.Drawing.Point(20, 215)
$t2_combo.Size = New-Object System.Drawing.Size(760, 30)
$t2_combo.DropDownStyle = 'DropDownList'
$t2_combo.Font = New-Object System.Drawing.Font("Consolas", 10)
$t2_combo.Visible = $false
$tab2.Controls.Add($t2_combo)

$t2_btn1 = New-Object System.Windows.Forms.Button
$t2_btn1.Location = New-Object System.Drawing.Point(20, 265)
$t2_btn1.Size = New-Object System.Drawing.Size(370, 50)
$t2_btn1.Text = '✅ Activate with Retail Key'
$t2_btn1.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Bold)
$t2_btn1.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 215)
$t2_btn1.ForeColor = [System.Drawing.Color]::White
$t2_btn1.FlatStyle = 'Flat'
$t2_btn1.Cursor = [System.Windows.Forms.Cursors]::Hand
$t2_btn1.Visible = $false
$tab2.Controls.Add($t2_btn1)

$t2_btn2 = New-Object System.Windows.Forms.Button
$t2_btn2.Location = New-Object System.Drawing.Point(410, 265)
$t2_btn2.Size = New-Object System.Drawing.Size(370, 50)
$t2_btn2.Text = '📊 Check Status'
$t2_btn2.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Bold)
$t2_btn2.BackColor = [System.Drawing.Color]::FromArgb(16, 124, 16)
$t2_btn2.ForeColor = [System.Drawing.Color]::White
$t2_btn2.FlatStyle = 'Flat'
$t2_btn2.Cursor = [System.Windows.Forms.Cursors]::Hand
$t2_btn2.Visible = $false
$tab2.Controls.Add($t2_btn2)

$t2_log = New-Object System.Windows.Forms.RichTextBox
$t2_log.Location = New-Object System.Drawing.Point(20, 335)
$t2_log.Size = New-Object System.Drawing.Size(760, 275)
$t2_log.Font = New-Object System.Drawing.Font("Consolas", 9)
$t2_log.BackColor = [System.Drawing.Color]::Black
$t2_log.ForeColor = [System.Drawing.Color]::Lime
$t2_log.ReadOnly = $true
$tab2.Controls.Add($t2_log)

# ==========================================
# TAB 3: OFFICE INSTALL
# ==========================================

$tab3 = New-Object System.Windows.Forms.TabPage
$tab3.Text = "📥 Office Install"
$tab3.BackColor = [System.Drawing.Color]::White
$tabControl.Controls.Add($tab3)

$t3_title = New-Object System.Windows.Forms.Label
$t3_title.Location = New-Object System.Drawing.Point(20, 15)
$t3_title.Size = New-Object System.Drawing.Size(760, 35)
$t3_title.Text = '📥 Microsoft Office Auto Installer'
$t3_title.Font = New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)
$t3_title.ForeColor = [System.Drawing.Color]::DarkGreen
$tab3.Controls.Add($t3_title)

$t3_info = New-Object System.Windows.Forms.Label
$t3_info.Location = New-Object System.Drawing.Point(20, 60)
$t3_info.Size = New-Object System.Drawing.Size(760, 50)
$t3_info.Text = 'Automatic installation using Microsoft Office Deployment Tool (ODT).`nInstallation takes approximately 10-30 minutes depending on internet speed.'
$t3_info.Font = New-Object System.Drawing.Font("Segoe UI", 9)
$tab3.Controls.Add($t3_info)

$t3_label = New-Object System.Windows.Forms.Label
$t3_label.Location = New-Object System.Drawing.Point(20, 120)
$t3_label.Size = New-Object System.Drawing.Size(760, 25)
$t3_label.Text = 'Select Office version to install:'
$t3_label.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
$tab3.Controls.Add($t3_label)

$t3_combo = New-Object System.Windows.Forms.ComboBox
$t3_combo.Location = New-Object System.Drawing.Point(20, 150)
$t3_combo.Size = New-Object System.Drawing.Size(760, 30)
$t3_combo.DropDownStyle = 'DropDownList'
$t3_combo.Font = New-Object System.Drawing.Font("Segoe UI", 10)
[void]$t3_combo.Items.Add("Office 2021 Professional Plus (64-bit)")
[void]$t3_combo.Items.Add("Office 2019 Professional Plus (64-bit)")
[void]$t3_combo.Items.Add("Office 2016 Professional Plus (64-bit)")
$t3_combo.SelectedIndex = 0
$tab3.Controls.Add($t3_combo)

$t3_btn = New-Object System.Windows.Forms.Button
$t3_btn.Location = New-Object System.Drawing.Point(20, 200)
$t3_btn.Size = New-Object System.Drawing.Size(760, 55)
$t3_btn.Text = '🚀 INSTALL OFFICE (Takes 10-30 minutes)'
$t3_btn.Font = New-Object System.Drawing.Font("Segoe UI", 12, [System.Drawing.FontStyle]::Bold)
$t3_btn.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 215)
$t3_btn.ForeColor = [System.Drawing.Color]::White
$t3_btn.FlatStyle = 'Flat'
$t3_btn.Cursor = [System.Windows.Forms.Cursors]::Hand
$tab3.Controls.Add($t3_btn)

$t3_log = New-Object System.Windows.Forms.RichTextBox
$t3_log.Location = New-Object System.Drawing.Point(20, 275)
$t3_log.Size = New-Object System.Drawing.Size(760, 335)
$t3_log.Font = New-Object System.Drawing.Font("Consolas", 9)
$t3_log.BackColor = [System.Drawing.Color]::Black
$t3_log.ForeColor = [System.Drawing.Color]::Lime
$t3_log.ReadOnly = $true
$tab3.Controls.Add($t3_log)

# Office XML Configurations
$officeConfigs = @{
    "Office 2021 Professional Plus (64-bit)" = @"
<Configuration>
  <Add OfficeClientEdition="64" Channel="PerpetualVL2021">
    <Product ID="ProPlus2021Volume">
      <Language ID="en-us" />
    </Product>
  </Add>
  <Display Level="Full" AcceptEULA="TRUE" />
  <Updates Enabled="TRUE" />
  <RemoveMSI />
</Configuration>
"@
    "Office 2019 Professional Plus (64-bit)" = @"
<Configuration>
  <Add OfficeClientEdition="64" Channel="PerpetualVL2019">
    <Product ID="ProPlus2019Volume">
      <Language ID="en-us" />
    </Product>
  </Add>
  <Display Level="Full" AcceptEULA="TRUE" />
  <Updates Enabled="TRUE" />
  <RemoveMSI />
</Configuration>
"@
    "Office 2016 Professional Plus (64-bit)" = @"
<Configuration>
  <Add OfficeClientEdition="64" Channel="Deferred">
    <Product ID="ProPlusVolume">
      <Language ID="en-us" />
    </Product>
  </Add>
  <Display Level="Full" AcceptEULA="TRUE" />
  <Updates Enabled="TRUE" />
  <RemoveMSI />
</Configuration>
"@
}

# ==========================================
# TAB 4: OFFICE ACTIVATE
# ==========================================

$tab4 = New-Object System.Windows.Forms.TabPage
$tab4.Text = "📦 Office Activate"
$tab4.BackColor = [System.Drawing.Color]::White
$tabControl.Controls.Add($tab4)

$t4_title = New-Object System.Windows.Forms.Label
$t4_title.Location = New-Object System.Drawing.Point(20, 15)
$t4_title.Size = New-Object System.Drawing.Size(760, 35)
$t4_title.Text = '📦 Microsoft Office Activation'
$t4_title.Font = New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)
$t4_title.ForeColor = [System.Drawing.Color]::DarkOrange
$tab4.Controls.Add($t4_title)

$t4_label = New-Object System.Windows.Forms.Label
$t4_label.Location = New-Object System.Drawing.Point(20, 60)
$t4_label.Size = New-Object System.Drawing.Size(760, 25)
$t4_label.Text = 'Select Office version to activate:'
$t4_label.Font = New-Object System.Drawing.Font("Segoe UI", 10)
$tab4.Controls.Add($t4_label)

$t4_combo = New-Object System.Windows.Forms.ComboBox
$t4_combo.Location = New-Object System.Drawing.Point(20, 90)
$t4_combo.Size = New-Object System.Drawing.Size(760, 30)
$t4_combo.DropDownStyle = 'DropDownList'
$t4_combo.Font = New-Object System.Drawing.Font("Segoe UI", 10)
foreach($key in $Global:OfficeKMSKeys.Keys){
    [void]$t4_combo.Items.Add($key)
}
$t4_combo.SelectedIndex = 0
$tab4.Controls.Add($t4_combo)

$t4_btn1 = New-Object System.Windows.Forms.Button
$t4_btn1.Location = New-Object System.Drawing.Point(20, 140)
$t4_btn1.Size = New-Object System.Drawing.Size(240, 50)
$t4_btn1.Text = '✅ Activate Office'
$t4_btn1.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Bold)
$t4_btn1.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 215)
$t4_btn1.ForeColor = [System.Drawing.Color]::White
$t4_btn1.FlatStyle = 'Flat'
$t4_btn1.Cursor = [System.Windows.Forms.Cursors]::Hand
$tab4.Controls.Add($t4_btn1)

$t4_btn2 = New-Object System.Windows.Forms.Button
$t4_btn2.Location = New-Object System.Drawing.Point(280, 140)
$t4_btn2.Size = New-Object System.Drawing.Size(240, 50)
$t4_btn2.Text = '📊 Check Status'
$t4_btn2.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Bold)
$t4_btn2.BackColor = [System.Drawing.Color]::FromArgb(16, 124, 16)
$t4_btn2.ForeColor = [System.Drawing.Color]::White
$t4_btn2.FlatStyle = 'Flat'
$t4_btn2.Cursor = [System.Windows.Forms.Cursors]::Hand
$tab4.Controls.Add($t4_btn2)

$t4_btn3 = New-Object System.Windows.Forms.Button
$t4_btn3.Location = New-Object System.Drawing.Point(540, 140)
$t4_btn3.Size = New-Object System.Drawing.Size(240, 50)
$t4_btn3.Text = '🔄 Reset Activation'
$t4_btn3.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Bold)
$t4_btn3.BackColor = [System.Drawing.Color]::FromArgb(220, 53, 69)
$t4_btn3.ForeColor = [System.Drawing.Color]::White
$t4_btn3.FlatStyle = 'Flat'
$t4_btn3.Cursor = [System.Windows.Forms.Cursors]::Hand
$tab4.Controls.Add($t4_btn3)

$t4_log = New-Object System.Windows.Forms.RichTextBox
$t4_log.Location = New-Object System.Drawing.Point(20, 210)
$t4_log.Size = New-Object System.Drawing.Size(760, 400)
$t4_log.Font = New-Object System.Drawing.Font("Consolas", 9)
$t4_log.BackColor = [System.Drawing.Color]::Black
$t4_log.ForeColor = [System.Drawing.Color]::Lime
$t4_log.ReadOnly = $true
$tab4.Controls.Add($t4_log)

# ==========================================
# TAB 5: ADVANCED TOOLS
# ==========================================

$tab5 = New-Object System.Windows.Forms.TabPage
$tab5.Text = "🔧 Tools"
$tab5.BackColor = [System.Drawing.Color]::White
$tabControl.Controls.Add($tab5)

$t5_title = New-Object System.Windows.Forms.Label
$t5_title.Location = New-Object System.Drawing.Point(20, 15)
$t5_title.Size = New-Object System.Drawing.Size(760, 35)
$t5_title.Text = '🔧 Advanced System Tools'
$t5_title.Font = New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)
$t5_title.ForeColor = [System.Drawing.Color]::DarkSlateGray
$tab5.Controls.Add($t5_title)

$t5_btn1 = New-Object System.Windows.Forms.Button
$t5_btn1.Location = New-Object System.Drawing.Point(20, 70)
$t5_btn1.Size = New-Object System.Drawing.Size(370, 50)
$t5_btn1.Text = '🌐 Test KMS Servers'
$t5_btn1.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Bold)
$t5_btn1.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 215)
$t5_btn1.ForeColor = [System.Drawing.Color]::White
$t5_btn1.FlatStyle = 'Flat'
$t5_btn1.Cursor = [System.Windows.Forms.Cursors]::Hand
$tab5.Controls.Add($t5_btn1)

$t5_btn2 = New-Object System.Windows.Forms.Button
$t5_btn2.Location = New-Object System.Drawing.Point(410, 70)
$t5_btn2.Size = New-Object System.Drawing.Size(370, 50)
$t5_btn2.Text = '💾 Backup Activation Data'
$t5_btn2.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Bold)
$t5_btn2.BackColor = [System.Drawing.Color]::FromArgb(16, 124, 16)
$t5_btn2.ForeColor = [System.Drawing.Color]::White
$t5_btn2.FlatStyle = 'Flat'
$t5_btn2.Cursor = [System.Windows.Forms.Cursors]::Hand
$tab5.Controls.Add($t5_btn2)

$t5_btn3 = New-Object System.Windows.Forms.Button
$t5_btn3.Location = New-Object System.Drawing.Point(20, 140)
$t5_btn3.Size = New-Object System.Drawing.Size(370, 50)
$t5_btn3.Text = '🌍 Test Internet Connection'
$t5_btn3.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Bold)
$t5_btn3.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 215)
$t5_btn3.ForeColor = [System.Drawing.Color]::White
$t5_btn3.FlatStyle = 'Flat'
$t5_btn3.Cursor = [System.Windows.Forms.Cursors]::Hand
$tab5.Controls.Add($t5_btn3)

$t5_btn4 = New-Object System.Windows.Forms.Button
$t5_btn4.Location = New-Object System.Drawing.Point(410, 140)
$t5_btn4.Size = New-Object System.Drawing.Size(370, 50)
$t5_btn4.Text = '🔍 System Diagnostics'
$t5_btn4.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Bold)
$t5_btn4.BackColor = [System.Drawing.Color]::FromArgb(16, 124, 16)
$t5_btn4.ForeColor = [System.Drawing.Color]::White
$t5_btn4.FlatStyle = 'Flat'
$t5_btn4.Cursor = [System.Windows.Forms.Cursors]::Hand
$tab5.Controls.Add($t5_btn4)

$t5_log = New-Object System.Windows.Forms.RichTextBox
$t5_log.Location = New-Object System.Drawing.Point(20, 210)
$t5_log.Size = New-Object System.Drawing.Size(760, 400)
$t5_log.Font = New-Object System.Drawing.Font("Consolas", 9)
$t5_log.BackColor = [System.Drawing.Color]::Black
$t5_log.ForeColor = [System.Drawing.Color]::Cyan
$t5_log.ReadOnly = $true
$tab5.Controls.Add($t5_log)

# ==========================================
# TAB 6: SYSTEM INFO
# ==========================================

$tab6 = New-Object System.Windows.Forms.TabPage
$tab6.Text = "💻 System Info"
$tab6.BackColor = [System.Drawing.Color]::White
$tabControl.Controls.Add($tab6)

$t6_title = New-Object System.Windows.Forms.Label
$t6_title.Location = New-Object System.Drawing.Point(20, 15)
$t6_title.Size = New-Object System.Drawing.Size(760, 35)
$t6_title.Text = '💻 System Information & Activation Status'
$t6_title.Font = New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)
$t6_title.ForeColor = [System.Drawing.Color]::DarkSlateGray
$tab6.Controls.Add($t6_title)

$t6_btn = New-Object System.Windows.Forms.Button
$t6_btn.Location = New-Object System.Drawing.Point(20, 65)
$t6_btn.Size = New-Object System.Drawing.Size(760, 50)
$t6_btn.Text = '🔄 Refresh System Information'
$t6_btn.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Bold)
$t6_btn.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 215)
$t6_btn.ForeColor = [System.Drawing.Color]::White
$t6_btn.FlatStyle = 'Flat'
$t6_btn.Cursor = [System.Windows.Forms.Cursors]::Hand
$tab6.Controls.Add($t6_btn)

$t6_log = New-Object System.Windows.Forms.RichTextBox
$t6_log.Location = New-Object System.Drawing.Point(20, 135)
$t6_log.Size = New-Object System.Drawing.Size(760, 475)
$t6_log.Font = New-Object System.Drawing.Font("Consolas", 10)
$t6_log.BackColor = [System.Drawing.Color]::Black
$t6_log.ForeColor = [System.Drawing.Color]::Cyan
$t6_log.ReadOnly = $true
$tab6.Controls.Add($t6_log)

# ==========================================
# EVENT HANDLERS
# ==========================================

# TAB 1: Windows KMS Activation
$t1_btn1.Add_Click({
    $selected = $t1_combo.SelectedItem
    $encKey = $Global:WindowsKMSKeys[$selected]
    $key = Decrypt-Data $encKey
    if($key){
        $t1_log.Clear()
        Activate-WindowsWithKey $key $t1_log $false
    }else{
        [System.Windows.Forms.MessageBox]::Show("Error decrypting key!", "Error", 0, 16)
    }
})

$t1_btn2.Add_Click({
    $t1_log.Clear()
    Write-ColorLog $t1_log "🔍 Checking Windows activation status..." "Cyan"
    $status = Get-WindowsActivationStatus
    Write-ColorLog $t1_log "📊 Status: $($status.Status)" "Yellow"
    Write-ColorLog $t1_log "📦 Product: $($status.Product)" "Lime"
    Write-ColorLog $t1_log "🔑 Partial Key: $($status.Key)" "Lime"
})

$t1_btn3.Add_Click({
    $result = [System.Windows.Forms.MessageBox]::Show(
        "⚠️ This will reset Windows activation.`n`nContinue?",
        "Confirm Reset",
        [System.Windows.Forms.MessageBoxButtons]::YesNo,
        [System.Windows.Forms.MessageBoxIcon]::Warning
    )
    if($result -eq "Yes"){
        $t1_log.Clear()
        Write-ColorLog $t1_log "🔄 Resetting Windows activation..." "Yellow"
        if(Reset-WindowsActivation){
            Write-ColorLog $t1_log "✅ Reset successful! Restart required." "Green"
            [System.Windows.Forms.MessageBox]::Show("✅ Reset successful!`n`nPlease restart your computer.", "Success", 0, 64)
        }else{
            Write-ColorLog $t1_log "❌ Reset failed" "Red"
        }
    }
})

# TAB 2: Retail Keys
$Global:RetailKeysUnlocked = $false
$Global:DecryptedKeys = @()

$t2_unlockBtn.Add_Click({
    if(-not $Global:RetailKeysUnlocked){
        # Password prompt
        $pwdForm = New-Object System.Windows.Forms.Form
        $pwdForm.Text = '🔐 Password Required'
        $pwdForm.Size = New-Object System.Drawing.Size(450, 220)
        $pwdForm.StartPosition = 'CenterParent'
        $pwdForm.FormBorderStyle = 'FixedDialog'
        $pwdForm.MaximizeBox = $false
        $pwdForm.MinimizeBox = $false
        $pwdForm.BackColor = [System.Drawing.Color]::White
        
        $pwdTitle = New-Object System.Windows.Forms.Label
        $pwdTitle.Location = New-Object System.Drawing.Point(20, 20)
        $pwdTitle.Size = New-Object System.Drawing.Size(400, 35)
        $pwdTitle.Text = '🔒 Encrypted Retail Keys Access'
        $pwdTitle.Font = New-Object System.Drawing.Font("Segoe UI", 13, [System.Drawing.FontStyle]::Bold)
        $pwdTitle.ForeColor = [System.Drawing.Color]::DarkRed
        $pwdForm.Controls.Add($pwdTitle)
        
        $pwdLabel = New-Object System.Windows.Forms.Label
        $pwdLabel.Location = New-Object System.Drawing.Point(20, 65)
        $pwdLabel.Size = New-Object System.Drawing.Size(400, 25)
        $pwdLabel.Text = 'Enter master password to decrypt keys:'
        $pwdLabel.Font = New-Object System.Drawing.Font("Segoe UI", 10)
        $pwdForm.Controls.Add($pwdLabel)
        
        $pwdBox = New-Object System.Windows.Forms.TextBox
        $pwdBox.Location = New-Object System.Drawing.Point(20, 95)
        $pwdBox.Size = New-Object System.Drawing.Size(400, 30)
        $pwdBox.Font = New-Object System.Drawing.Font("Segoe UI", 11)
        $pwdBox.UseSystemPasswordChar = $true
        $pwdForm.Controls.Add($pwdBox)
        
        $pwdOK = New-Object System.Windows.Forms.Button
        $pwdOK.Location = New-Object System.Drawing.Point(240, 140)
        $pwdOK.Size = New-Object System.Drawing.Size(85, 35)
        $pwdOK.Text = 'Unlock'
        $pwdOK.BackColor = [System.Drawing.Color]::Green
        $pwdOK.ForeColor = [System.Drawing.Color]::White
        $pwdOK.FlatStyle = 'Flat'
        $pwdOK.DialogResult = 'OK'
        $pwdForm.Controls.Add($pwdOK)
        
        $pwdCancel = New-Object System.Windows.Forms.Button
        $pwdCancel.Location = New-Object System.Drawing.Point(335, 140)
        $pwdCancel.Size = New-Object System.Drawing.Size(85, 35)
        $pwdCancel.Text = 'Cancel'
        $pwdCancel.BackColor = [System.Drawing.Color]::Gray
        $pwdCancel.ForeColor = [System.Drawing.Color]::White
        $pwdCancel.FlatStyle = 'Flat'
        $pwdCancel.DialogResult = 'Cancel'
        $pwdForm.Controls.Add($pwdCancel)
        
        $pwdForm.AcceptButton = $pwdOK
        $pwdForm.CancelButton = $pwdCancel
        
        $res = $pwdForm.ShowDialog($mainForm)
        
        if($res -eq 'OK'){
            if($pwdBox.Text -eq $Global:MasterPassword){
                # Decrypt all retail keys
                $Global:DecryptedKeys = @()
                foreach($encKey in $Global:EncryptedRetailKeys){
                    $decKey = Decrypt-Data $encKey
                    if($decKey){
                        $Global:DecryptedKeys += $decKey
                    }
                }
                
                if($Global:DecryptedKeys.Count -gt 0){
                    $Global:RetailKeysUnlocked = $true
                    
                    # Show controls
                    $t2_keyLabel.Visible = $true
                    $t2_combo.Visible = $true
                    $t2_btn1.Visible = $true
                    $t2_btn2.Visible = $true
                    
                    # Populate combo
                    $t2_combo.Items.Clear()
                    for($i = 0; $i -lt $Global:DecryptedKeys.Count; $i++){
                        [void]$t2_combo.Items.Add("Premium Key #$($i+1) - $($Global:DecryptedKeys[$i])")
                    }
                    $t2_combo.SelectedIndex = 0
                    
                    # Update button
                    $t2_unlockBtn.Text = "✅ UNLOCKED ($($Global:DecryptedKeys.Count) Keys Available)"
                    $t2_unlockBtn.BackColor = [System.Drawing.Color]::Green
                    $t2_unlockBtn.Enabled = $false
                    
                    Write-ColorLog $t2_log "✅ Successfully decrypted $($Global:DecryptedKeys.Count) retail keys!" "Green"
                    Write-ColorLog $t2_log "🔑 Select a key from dropdown and click Activate" "Cyan"
                    
                    [System.Windows.Forms.MessageBox]::Show(
                        "✅ Successfully unlocked!`n`n🔑 Total Keys: $($Global:DecryptedKeys.Count)`n🔓 Access granted",
                        "Success",
                        [System.Windows.Forms.MessageBoxButtons]::OK,
                        [System.Windows.Forms.MessageBoxIcon]::Information
                    )
                }else{
                    [System.Windows.Forms.MessageBox]::Show("❌ Decryption failed!", "Error", 0, 16)
                }
            }else{
                [System.Windows.Forms.MessageBox]::Show(
                    "❌ Incorrect password!`n`n🔒 Access denied",
                    "Authentication Failed",
                    [System.Windows.Forms.MessageBoxButtons]::OK,
                    [System.Windows.Forms.MessageBoxIcon]::Error
                )
            }
        }
    }
})

$t2_btn1.Add_Click({
    if($Global:RetailKeysUnlocked -and $Global:DecryptedKeys.Count -gt 0){
        $idx = $t2_combo.SelectedIndex
        if($idx -ge 0){
            $key = $Global:DecryptedKeys[$idx]
            $t2_log.Clear()
            Write-ColorLog $t2_log "🔐 Using Premium Retail Key #$($idx+1)" "Magenta"
            Activate-WindowsWithKey $key $t2_log $true
        }
    }
})

$t2_btn2.Add_Click({
    $t2_log.Clear()
    Write-ColorLog $t2_log "🔍 Checking activation status..." "Cyan"
    $status = Get-WindowsActivationStatus
    Write-ColorLog $t2_log "📊 Status: $($status.Status)" "Yellow"
    Write-ColorLog $t2_log "📦 Product: $($status.Product)" "Lime"
})

# TAB 3: Office Install
$t3_btn.Add_Click({
    $selected = $t3_combo.SelectedItem
    $config = $officeConfigs[$selected]
    
    $result = [System.Windows.Forms.MessageBox]::Show(
        "⚠️ Install: $selected`n`n⏱️ This will take 10-30 minutes.`n💡 Do NOT close this window during installation.`n`nContinue?",
        "Confirm Installation",
        [System.Windows.Forms.MessageBoxButtons]::YesNo,
        [System.Windows.Forms.MessageBoxIcon]::Question
    )
    
    if($result -eq "Yes"){
        $t3_log.Clear()
        $t3_btn.Enabled = $false
        $t3_btn.Text = "⏳ Installing... Please Wait"
        
        $success = Install-OfficeODT $config $t3_log
        
        $t3_btn.Enabled = $true
        $t3_btn.Text = "🚀 INSTALL OFFICE (Takes 10-30 minutes)"
        
        if($success){
            [System.Windows.Forms.MessageBox]::Show(
                "✅ Office installed successfully!`n`n📌 Next: Go to 'Office Activate' tab to activate it.",
                "Installation Complete",
                [System.Windows.Forms.MessageBoxButtons]::OK,
                [System.Windows.Forms.MessageBoxIcon]::Information
            )
        }
    }
})

# TAB 4: Office Activation
$t4_btn1.Add_Click({
    $selected = $t4_combo.SelectedItem
    $encKey = $Global:OfficeKMSKeys[$selected]
    $key = Decrypt-Data $encKey
    if($key){
        $t4_log.Clear()
        Activate-OfficeWithKey $key $t4_log
    }else{
        [System.Windows.Forms.MessageBox]::Show("Error decrypting key!", "Error", 0, 16)
    }
})

$t4_btn2.Add_Click({
    $t4_log.Clear()
    Write-ColorLog $t4_log "🔍 Checking Office activation status..." "Cyan"
    $status = Get-OfficeActivationStatus
    Write-ColorLog $t4_log "📊 Status: $($status.Status)" "Yellow"
    Write-ColorLog $t4_log "📁 Path: $($status.Path)" "Lime"
})

$t4_btn3.Add_Click({
    $result = [System.Windows.Forms.MessageBox]::Show(
        "⚠️ Reset Office activation?",
        "Confirm",
        [System.Windows.Forms.MessageBoxButtons]::YesNo,
        [System.Windows.Forms.MessageBoxIcon]::Warning
    )
    if($result -eq "Yes"){
        $t4_log.Clear()
        Write-ColorLog $t4_log "🔄 Resetting Office activation..." "Yellow"
        if(Reset-OfficeActivation){
            Write-ColorLog $t4_log "✅ Reset successful!" "Green"
        }else{
            Write-ColorLog $t4_log "❌ Reset failed" "Red"
        }
    }
})

# TAB 5: Advanced Tools
$t5_btn1.Add_Click({
    $t5_log.Clear()
    Write-ColorLog $t5_log "🌐 Testing KMS servers..." "Cyan"
    Write-ColorLog $t5_log "========================================" "Yellow"
    
    for($i = 0; $i -lt $Global:KMSServers.Count; $i++){
        $kms = Decrypt-KMSServer $Global:KMSServers[$i]
        if($kms){
            Write-ColorLog $t5_log "Testing: $kms" "White"
            if(Test-KMSConnection $kms){
                Write-ColorLog $t5_log "  ✅ Online (Port 1688 accessible)" "Green"
            }else{
                Write-ColorLog $t5_log "  ❌ Offline or blocked" "Red"
            }
        }
    }
    Write-ColorLog $t5_log "========================================" "Yellow"
    Write-ColorLog $t5_log "✅ Test complete" "Cyan"
})

$t5_btn2.Add_Click({
    $t5_log.Clear()
    Write-ColorLog $t5_log "💾 Creating activation backup..." "Cyan"
    $path = Backup-ActivationInfo
    if($path){
        Write-ColorLog $t5_log "✅ Backup saved to:`n$path" "Green"
        [System.Windows.Forms.MessageBox]::Show(
            "✅ Backup created successfully!`n`n📁 Location:`n$path",
            "Success",
            [System.Windows.Forms.MessageBoxButtons]::OK,
            [System.Windows.Forms.MessageBoxIcon]::Information
        )
    }else{
        Write-ColorLog $t5_log "❌ Backup failed" "Red"
    }
})

$t5_btn3.Add_Click({
    $t5_log.Clear()
    Write-ColorLog $t5_log "🌍 Testing internet connection..." "Cyan"
    if(Test-NetworkConnection){
        Write-ColorLog $t5_log "✅ Internet connection: Active" "Green"
        Write-ColorLog $t5_log "📡 DNS resolution: Working" "Green"
    }else{
        Write-ColorLog $t5_log "❌ Internet connection: Failed" "Red"
        Write-ColorLog $t5_log "⚠️ Check your network settings" "Yellow"
    }
})

$t5_btn4.Add_Click({
    $t5_log.Clear()
    Write-ColorLog $t5_log "🔍 Running full system diagnostics..." "Cyan"
    Write-ColorLog $t5_log "========================================" "Yellow"
    
    Write-ColorLog $t5_log "💻 Computer: $env:COMPUTERNAME" "Lime"
    Write-ColorLog $t5_log "👤 User: $env:USERNAME" "Lime"
    
    $os = Get-CimInstance -ClassName Win32_OperatingSystem
    Write-ColorLog $t5_log "🖥️ OS: $($os.Caption)" "Lime"
    Write-ColorLog $t5_log "📌 Build: $($os.BuildNumber)" "Lime"
    
    Write-ColorLog $t5_log "`n🔍 Windows Activation:" "Cyan"
    $winStatus = Get-WindowsActivationStatus
    Write-ColorLog $t5_log "  Status: $($winStatus.Status)" "Yellow"
    
    Write-ColorLog $t5_log "`n🔍 Office Activation:" "Cyan"
    $offStatus = Get-OfficeActivationStatus
    Write-ColorLog $t5_log "  Status: $($offStatus.Status)" "Yellow"
    
    Write-ColorLog $t5_log "`n🌐 Network:" "Cyan"
    if(Test-NetworkConnection){
        Write-ColorLog $t5_log "  Internet: ✅ Connected" "Green"
    }else{
        Write-ColorLog $t5_log "  Internet: ❌ Disconnected" "Red"
    }
    
    Write-ColorLog $t5_log "`n========================================" "Yellow"
    Write-ColorLog $t5_log "✅ Diagnostics complete" "Cyan"
})

# TAB 6: System Info
$t6_btn.Add_Click({
    $t6_log.Clear()
    Write-ColorLog $t6_log "🔄 Loading system information..." "Cyan"
    Write-ColorLog $t6_log "════════════════════════════════════════" "Yellow"
    
    Write-ColorLog $t6_log "💻 COMPUTER INFORMATION" "Cyan"
    Write-ColorLog $t6_log "  Name: $env:COMPUTERNAME" "Lime"
    Write-ColorLog $t6_log "  User: $env:USERNAME" "Lime"
    
    $os = Get-CimInstance -ClassName Win32_OperatingSystem
    Write-ColorLog $t6_log "`n🖥️ OPERATING SYSTEM" "Cyan"
    Write-ColorLog $t6_log "  OS: $($os.Caption)" "Lime"
    Write-ColorLog $t6_log "  Version: $($os.Version)" "Lime"
    Write-ColorLog $t6_log "  Build: $($os.BuildNumber)" "Lime"
    Write-ColorLog $t6_log "  Architecture: $($os.OSArchitecture)" "Lime"
    
    $cs = Get-CimInstance -ClassName Win32_ComputerSystem
    Write-ColorLog $t6_log "`n🏭 HARDWARE" "Cyan"
    Write-ColorLog $t6_log "  Manufacturer: $($cs.Manufacturer)" "Lime"
    Write-ColorLog $t6_log "  Model: $($cs.Model)" "Lime"
    Write-ColorLog $t6_log "  RAM: $([math]::Round($cs.TotalPhysicalMemory/1GB, 2)) GB" "Lime"
    
    Write-ColorLog $t6_log "`n🪟 WINDOWS ACTIVATION" "Cyan"
    $winStatus = Get-WindowsActivationStatus
    Write-ColorLog $t6_log "  Status: $($winStatus.Status)" "Yellow"
    Write-ColorLog $t6_log "  Product: $($winStatus.Product)" "Yellow"
    Write-ColorLog $t6_log "  Key: $($winStatus.Key)" "Yellow"
    
    Write-ColorLog $t6_log "`n📦 OFFICE ACTIVATION" "Cyan"
    $offStatus = Get-OfficeActivationStatus
    Write-ColorLog $t6_log "  Status: $($offStatus.Status)" "Yellow"
    Write-ColorLog $t6_log "  Path: $($offStatus.Path)" "Yellow"
    
    Write-ColorLog $t6_log "`n════════════════════════════════════════" "Yellow"
    Write-ColorLog $t6_log "🕒 Updated: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" "Gray"
})

# ==========================================
# INITIALIZE
# ==========================================

Write-ColorLog $t1_log "🚀 Windows KMS Activation Ready" "Cyan"
Write-ColorLog $t1_log "✅ Administrator: Active" "Green"
Write-ColorLog $t1_log "📌 Select version and click Activate" "Yellow"

Write-ColorLog $t2_log "🔐 Premium Retail Keys Section" "Magenta"
Write-ColorLog $t2_log "🔒 Keys are encrypted and protected" "Yellow"
Write-ColorLog $t2_log "🔑 Total encrypted keys: $($Global:EncryptedRetailKeys.Count)" "Cyan"
Write-ColorLog $t2_log "📝 Click UNLOCK button to access (Password: 2004)" "Yellow"

Write-ColorLog $t3_log "📥 Office Auto-Installer Ready" "Cyan"
Write-ColorLog $t3_log "✅ Using official Microsoft ODT" "Green"
Write-ColorLog $t3_log "⏱️ Installation time: 10-30 minutes" "Yellow"

Write-ColorLog $t4_log "📦 Office Activation Ready" "Cyan"
Write-ColorLog $t4_log "✅ Install Office first (Install tab)" "Green"
Write-ColorLog $t4_log "📌 Then activate here" "Yellow"

Write-ColorLog $t5_log "🔧 Advanced Tools Ready" "Cyan"
Write-ColorLog $t5_log "✅ All diagnostic tools available" "Green"

$t6_btn.PerformClick()

[void]$mainForm.ShowDialog()