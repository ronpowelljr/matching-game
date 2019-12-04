#mount the app you want to sign instead of C:\testapp
docker run -v "C:\Users\circleci\project\MatchingGame\:C:\testapp"  mcr.microsoft.com/windows/servercore:ltsc2019 powershell.exe -executionpolicy bypass C:\testapp\scripts\makecert.ps1
