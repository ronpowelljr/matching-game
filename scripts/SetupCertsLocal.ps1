$params = @{
    Subject           = "CN=CircleCI Test"
    KeyUsage          = "DigitalSignature"
    KeyAlgorithm      = 'RSA'
    KeySpec           = "Signature"
    FriendlyName      = "CircleCI Test"
    CertStoreLocation = "Cert:\LocalMachine\My"
    KeyExportPolicy   = 'Exportable'
    Type              = "Custom"
    TextExtension     = @("2.5.29.37={text}1.3.6.1.5.5.7.3.3", "2.5.29.19={text}")
}
  
$cert = New-SelfSignedCertificate @params
Export-Certificate -Cert $cert -File C:\ucert.sst -Type SST
Import-Certificate -File C:\ucert.sst -CertStoreLocation Cert:\LocalMachine\Root
Import-Certificate -File C:\ucert.sst -CertStoreLocation Cert:\CurrentUser\M
