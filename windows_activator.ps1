# Self-elevation: Check if running as Administrator, if not, restart as Admin
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    try {
        Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
        exit
    }
    catch {
        [System.Windows.Forms.MessageBox]::Show(
            "This script requires Administrator privileges. Please run as Administrator.",
            "Administrator Required",
            [System.Windows.Forms.MessageBoxButtons]::OK,
            [System.Windows.Forms.MessageBoxIcon]::Warning
        )
        exit
    }
}

# Set execution policy for current process
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Windows product keys
$ProductKeys = @{
    "Windows 10 Enterprise" = "NPPR9-FWDCX-D2C8J-H872K-2YT43"
    "Windows 11 Pro" = "W269N-WFGWX-YVC9B-4J6C9-T83GX"
    "Windows 11 Home" = "YTMG3-N6DKC-DKB77-7M9GH-8HVX7"
    "Windows 11 Enterprise" = "NPPR9-FWDCX-D2C8J-H872K-2YT43"
    "Windows 11 Rites Paid Key" = "ENCRYPTED"
}

# Password for protected key
$ProtectedPassword = "2004"

# Encrypted Rites key (Base64 encoded and reversed)
$EncryptedRitesKey = "NjI3Qy1RUVdYNi02RkZKNC04Nk1WRi00RkROWA=="

# Function to decrypt the Rites key
function Get-RitesKey {
    param($pwd)
    if ($pwd -eq $ProtectedPassword) {
        $decoded = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($EncryptedRitesKey))
        $key = -join ($decoded.ToCharArray() | ForEach-Object { $_ })
        return ($key -split '-' | ForEach-Object { $_ }) -join '-'
    }
    return $null
}

# Create the main form
$form = New-Object System.Windows.Forms.Form
$form.Text = 'Windows Activation Tool'
$form.Size = New-Object System.Drawing.Size(500, 350)
$form.StartPosition = 'CenterScreen'
$form.FormBorderStyle = 'FixedDialog'
$form.MaximizeBox = $false

# Title Label
$titleLabel = New-Object System.Windows.Forms.Label
$titleLabel.Location = New-Object System.Drawing.Point(20, 20)
$titleLabel.Size = New-Object System.Drawing.Size(450, 30)
$titleLabel.Text = 'Windows Activation Tool'
$titleLabel.Font = New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)
$titleLabel.ForeColor = [System.Drawing.Color]::DarkBlue
$form.Controls.Add($titleLabel)

# Instruction Label
$instructionLabel = New-Object System.Windows.Forms.Label
$instructionLabel.Location = New-Object System.Drawing.Point(20, 60)
$instructionLabel.Size = New-Object System.Drawing.Size(450, 40)
$instructionLabel.Text = 'Select your Windows version and click Activate:'
$instructionLabel.Font = New-Object System.Drawing.Font("Segoe UI", 10)
$form.Controls.Add($instructionLabel)

# ComboBox for Windows versions
$comboBox = New-Object System.Windows.Forms.ComboBox
$comboBox.Location = New-Object System.Drawing.Point(20, 110)
$comboBox.Size = New-Object System.Drawing.Size(450, 30)
$comboBox.DropDownStyle = 'DropDownList'
$comboBox.Font = New-Object System.Drawing.Font("Segoe UI", 10)
foreach ($key in $ProductKeys.Keys) {
    [void]$comboBox.Items.Add($key)
}
$comboBox.SelectedIndex = 0
$form.Controls.Add($comboBox)

# Activate Button
$activateButton = New-Object System.Windows.Forms.Button
$activateButton.Location = New-Object System.Drawing.Point(20, 160)
$activateButton.Size = New-Object System.Drawing.Size(450, 40)
$activateButton.Text = 'Activate Windows'
$activateButton.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Bold)
$activateButton.BackColor = [System.Drawing.Color]::Green
$activateButton.ForeColor = [System.Drawing.Color]::White
$activateButton.FlatStyle = 'Flat'
$form.Controls.Add($activateButton)

# Status TextBox
$statusBox = New-Object System.Windows.Forms.TextBox
$statusBox.Location = New-Object System.Drawing.Point(20, 220)
$statusBox.Size = New-Object System.Drawing.Size(450, 70)
$statusBox.Multiline = $true
$statusBox.ScrollBars = 'Vertical'
$statusBox.ReadOnly = $true
$statusBox.Font = New-Object System.Drawing.Font("Consolas", 9)
$statusBox.BackColor = [System.Drawing.Color]::Black
$statusBox.ForeColor = [System.Drawing.Color]::Lime
$form.Controls.Add($statusBox)

# Activate button click event
$activateButton.Add_Click({
    $selectedVersion = $comboBox.SelectedItem
    $productKey = $ProductKeys[$selectedVersion]
    
    # Check if password protected key is selected
    if ($selectedVersion -eq "Windows 11 Rites Paid Key") {
        # Create password dialog
        $passwordForm = New-Object System.Windows.Forms.Form
        $passwordForm.Text = 'Password Required'
        $passwordForm.Size = New-Object System.Drawing.Size(350, 180)
        $passwordForm.StartPosition = 'CenterScreen'
        $passwordForm.FormBorderStyle = 'FixedDialog'
        $passwordForm.MaximizeBox = $false
        $passwordForm.MinimizeBox = $false
        
        $pwdLabel = New-Object System.Windows.Forms.Label
        $pwdLabel.Location = New-Object System.Drawing.Point(20, 20)
        $pwdLabel.Size = New-Object System.Drawing.Size(300, 30)
        $pwdLabel.Text = 'Enter password to use this key:'
        $pwdLabel.Font = New-Object System.Drawing.Font("Segoe UI", 10)
        $passwordForm.Controls.Add($pwdLabel)
        
        $pwdTextBox = New-Object System.Windows.Forms.TextBox
        $pwdTextBox.Location = New-Object System.Drawing.Point(20, 60)
        $pwdTextBox.Size = New-Object System.Drawing.Size(300, 30)
        $pwdTextBox.Font = New-Object System.Drawing.Font("Segoe UI", 10)
        $pwdTextBox.UseSystemPasswordChar = $true
        $passwordForm.Controls.Add($pwdTextBox)
        
        $okButton = New-Object System.Windows.Forms.Button
        $okButton.Location = New-Object System.Drawing.Point(170, 100)
        $okButton.Size = New-Object System.Drawing.Size(75, 30)
        $okButton.Text = 'OK'
        $okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
        $passwordForm.Controls.Add($okButton)
        
        $cancelButton = New-Object System.Windows.Forms.Button
        $cancelButton.Location = New-Object System.Drawing.Point(250, 100)
        $cancelButton.Size = New-Object System.Drawing.Size(75, 30)
        $cancelButton.Text = 'Cancel'
        $cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
        $passwordForm.Controls.Add($cancelButton)
        
        $passwordForm.AcceptButton = $okButton
        $passwordForm.CancelButton = $cancelButton
        
        $result = $passwordForm.ShowDialog()
        
        if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
            # Decrypt the Rites key
            $decryptedKey = Get-RitesKey -pwd $pwdTextBox.Text
            if ($null -eq $decryptedKey) {
                [System.Windows.Forms.MessageBox]::Show(
                    "Incorrect password! Access denied.",
                    "Authentication Failed",
                    [System.Windows.Forms.MessageBoxButtons]::OK,
                    [System.Windows.Forms.MessageBoxIcon]::Error
                )
                return
            }
            $productKey = $decryptedKey
        }
        else {
            return
        }
    }
    
    $statusBox.Clear()
    $statusBox.AppendText("Starting activation for: $selectedVersion`r`n")
    $statusBox.AppendText("Product Key: ****-****-****-****-****`r`n")
    $statusBox.AppendText("----------------------------------------`r`n")
    
    try {
        # Install product key
        $statusBox.AppendText("Installing product key...`r`n")
        $result1 = cmd /c "slmgr /ipk $productKey" 2>&1
        Start-Sleep -Seconds 2
        
        # Set KMS server (skip for paid key)
        if ($selectedVersion -ne "Windows 11 Rites Paid Key") {
            $statusBox.AppendText("Setting KMS server...`r`n")
            $result2 = cmd /c "slmgr /skms kms8.msguides.com" 2>&1
            Start-Sleep -Seconds 2
        }
        
        # Activate Windows
        $statusBox.AppendText("Activating Windows...`r`n")
        $result3 = cmd /c "slmgr /ato" 2>&1
        Start-Sleep -Seconds 2
        
        $statusBox.AppendText("----------------------------------------`r`n")
        $statusBox.AppendText("Activation completed!`r`n")
        $statusBox.AppendText("Please check Windows activation status.`r`n")
        
        [System.Windows.Forms.MessageBox]::Show(
            "Windows activation process completed!`n`nPlease restart your computer and check activation status in Settings > System > Activation.",
            "Activation Complete",
            [System.Windows.Forms.MessageBoxButtons]::OK,
            [System.Windows.Forms.MessageBoxIcon]::Information
        )
    }
    catch {
        $statusBox.AppendText("Error: $_`r`n")
        [System.Windows.Forms.MessageBox]::Show(
            "An error occurred during activation. Please run this script as Administrator.",
            "Error",
            [System.Windows.Forms.MessageBoxButtons]::OK,
            [System.Windows.Forms.MessageBoxIcon]::Error
        )
    }
})

# Show the form
[void]$form.ShowDialog()
