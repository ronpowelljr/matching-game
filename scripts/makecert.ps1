# Set up a self-signed certificate to be able to code sign on CircleCI on Windows

$params = @{
  Subject = "CN=CircleCI Test With Root"
  KeyUsage = "DigitalSignature"
  KeyAlgorithm = 'RSA'
  KeySpec           = "Signature"
  FriendlyName =  "CircleCI Test3"
  CertStoreLocation = "Cert:\CurrentUser\My" # Note that this method lets you create a private key in CurrentUser\My
  KeyExportPolicy = 'Exportable'
  Type = "Custom"
  TextExtension=@("2.5.29.37={text}1.3.6.1.5.5.7.3.3", "2.5.29.19={text}")
}

$cert = New-SelfSignedCertificate @params
Export-Certificate -Cert $cert -File C:\ucert.cer
Import-Certificate -File C:\ucert.cer -CertStoreLocation Cert:\LocalMachine\Root

Get-ChildItem cert:\CurrentUser\My -CodeSigning

$root_cert | Select-Object *
$cert| Select-Object *
Set-AuthenticodeSignature -FilePath C:\testapp\bin\Release\netcoreapp3.0\win-x64\publish\MatchingGame.exe  -Certificate $cert | Select-Object *
