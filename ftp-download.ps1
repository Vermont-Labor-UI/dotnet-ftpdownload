 # Config
param(
  #[Parameter(Mandatory=$true)][string]$Username,
  #[Parameter(Mandatory=$true)][string]$Password,
  [Parameter(Mandatory=$true)][string]$RemoteFile,
  [Parameter(Mandatory=$true)][string]$LocalFile
 )


 # Create a FTPWebRequest
 $FTPRequest = [System.Net.FtpWebRequest]::Create($RemoteFile)
 #$FTPRequest.Credentials = New-Object System.Net.NetworkCredential($Username,$Password)
 $FTPRequest.Method = [System.Net.WebRequestMethods+Ftp]::DownloadFile
 $FTPRequest.UseBinary = $true
 $FTPRequest.KeepAlive = $false
 $FTPRequest.Timeout = 3000
 #$FTPRequest.EnableSsl = $true
 Write-Host "Getting Response"
 # Send the ftp request
 $FTPResponse = $FTPRequest.GetResponse()

if($FTPResponse -eq $null)
{
  Write-Host "FTP Response is null";
  exit 1;
}
 Write-Host "Getting Response Stream"
 # Get a download stream from the server response
 $ResponseStream = $FTPResponse.GetResponseStream()

 if($ResponseStream -eq $null)
 {
   Write-Host "Response Stream Is Null"
   exit 1;
 }
 #Write stream to local file
 
 $reader = New-Object System.IO.StreamReader $ResponseStream
 $reader.ReadToEnd() | Out-File $LocalFile
