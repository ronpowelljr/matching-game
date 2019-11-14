Add-Type -AssemblyName System.web
$raw_password = [System.Web.Security.Membership]::GeneratePassword(42, 10)
$password = ConvertTo-SecureString $raw_password -AsPlainText -Force
Set-LocalUser -Name "circleci" -Password $password
$username = "circleci"
$cred = New-Object System.Management.Automation.PSCredential -ArgumentList $username, $password
Start-Job -Name build -Credential $cred -ScriptBlock { 
   Set-Location C:\Users\circleci\project\MatchingGame\bin\Release\netcoreapp3.0\win-x64\publish\MatchingGame.exe
   npm run build:dev
}
Receive-Job -Wait -Name build