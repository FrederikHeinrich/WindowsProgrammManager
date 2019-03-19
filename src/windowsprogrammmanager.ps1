###########################################################################################################################################################
#                                                        Windows Programm Manager von FrederikHeinrich.de
###########################################################################################################################################################
param(
    [String]$aufgabe, #Definiert wenn ein Start Argument gegeben ist die Aufgabe des Programmes!
    $programms = @(), #Eine Liste die von der Text Datei ausgelesen wird!
    $datei = "programme.txt" #Die Text Datei!
)
#####################################################################
#                            Functionen
#####################################################################
function IsAdmin {#Überprüft ob das Skript als Admin ausgeführt wurde!
    try {#Versucht die Gruppe des Benutzers auszulesen
        $identity = [Security.Principal.WindowsIdentity]::GetCurrent() #Hohlt sich den Ausführer des Slriptes!
        $principal = New-Object Security.Principal.WindowsPrincipal -ArgumentList $identity #nimmt sich die Identiy.
        return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)#Gibt ein True oder Fals zurück je nachdem ob es ein Admin ist oder Nicht!
        } catch { #Falls das Skript kein User Finden konnte!
            throw "Error: '{0}'." -f $_  #Gibt den Fehler in der Console aus!
        }
}

function upgrade { #Wenn als Start argument/befehl upgrade ausgewählt wurde!
    installPackageProviders #führt die installPackageProviders Methode aus.
    foreach ($programm in $programms) { #Geht für jedes Programm die Folgenden 2 Lins durch!
        [String]"Updating " + $programm #Schreibt es in die Console!
        choco upgrade $programm -y #Startet das update via Chocolatey.
    }
    [String]"Done"#Sagt bescheid das er mit jedem Update fertig ist.
}

function install {#Wenn als Start argument/befehl install ausgewählt wurde!
    installPackageProviders #führt die installPackageProviders Methode aus.
    foreach ($programm in $programms) { #Geht für jedes Programm die Folgenden 2 Lins durch!
        [String]"Install " + $programm #Schreibt es in die Console!
        choco install $programm -y #Startet das installation via Chocolatey.
    }
    [String]"Done" #Schreib es in die Console!
}

function remove{#Wenn als Start argument/befehl remove ausgewählt wurde!
    Get-AppxPackage *xboxapp* | Remove-AppxPackage
    Get-AppxPackage *soundrecorder* | Remove-AppxPackage
    Get-AppxPackage *onenote* | Remove-AppxPackage
    Get-AppxPackage *windowscommunicationsapps* | Remove-AppxPackage
    Get-AppxPackage *people* | Remove-AppxPackage
    Get-AppxPackage *windowsmaps* | Remove-AppxPackage
    Get-AppxPackage *windowscamera* | Remove-AppxPackage
    Get-AppxPackage *zunemusic* | Remove-AppxPackage
    Get-AppxPackage *photos* | Remove-AppxPackage
    Get-AppxPackage *zunevideo* | Remove-AppxPackage
    Get-AppxPackage *windowsalarms* | Remove-AppxPackage
    Get-AppxPackage *BingWeather* | Remove-AppxPackage
    Get-AppxPackage *GetHelp* | Remove-AppxPackage
    Get-AppxPackage *Getstarted* | Remove-AppxPackage
    Get-AppxPackage *Messaging* | Remove-AppxPackage
    Get-AppxPackage *Microsoft3DViewer* | Remove-AppxPackage
    Get-AppxPackage *MicrosoftOfficeHub* | Remove-AppxPackage
    Get-AppxPackage *MicrosoftSolitaireCollection* | Remove-AppxPackage
    Get-AppxPackage *MixedReality* | Remove-AppxPackage
    Get-AppxPackage *MSPaint* | Remove-AppxPackage
    Get-AppxPackage *OneConnect* | Remove-AppxPackage
    Get-AppxPackage *Print3D* | Remove-AppxPackage
    Get-AppxPackage *Wallet* | Remove-AppxPackage
    Get-AppxPackage *Xbox* | Remove-AppxPackage
    Get-AppxPackage *XboxGameOverlay* | Remove-AppxPackage
    Get-AppxPackage *XboxGamingOverlay* | Remove-AppxPackage
    Get-AppxPackage *XboxSpeechToTextOverlay* | Remove-AppxPackage
    Get-AppxPackage *YourPhone* | Remove-AppxPackage
    Get-AppxPackage *ScreenSketch* | Remove-AppxPackage
    Get-AppxPackage *VP9VideoExtensions* | Remove-AppxPackage
    Get-AppxPackage *SkypeApp* | Remove-AppxPackage
    Get-AppxPackage *MicrosoftEdgeDevToolsClient* | Remove-AppxPackage
    Get-AppxPackage *XboxSpeechToTextOverlay* | Remove-AppxPackage
    Get-AppxPackage *MicrosoftEdge* | Remove-AppxPackage
    Get-AppxPackage *Cortana* | Remove-AppxPackage
    Get-AppxPackage *XboxGameCallableUI* | Remove-AppxPackage
    Get-AppxPackage *WindowsFeedbackHub* | Remove-AppxPackage
    Get-AppxPackage *FitbitCoach* | Remove-AppxPackage
    Get-AppxPackage *BingNews* | Remove-AppxPackage
    Get-AppxPackage *PhototasticCollage* | Remove-AppxPackage
    Get-AppxPackage *XING* | Remove-AppxPackage
    Get-AppxPackage *king.com* | Remove-AppxPackage
}


function installPackageProviders{ #Die Methode zum installeriren von Chocolatey!
    [String]"Install Package Providers..." #Schreibt es in die Console!
    Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    Install-PackageProvider chocolatey #Installiert Chocolatey via den Windows PackageProvider
    [String]"Done..." #Schreib es in die Console!
}

#####################################################################
#                            Skript Start
#####################################################################
cls #Clear
if(IsAdmin){ #Guckt mit der IsAdmin Methode nach ob es sich um eine Admin PowerShell Session handelt!

    if(Test-Path $datei){ #Überprüft ob die Text Datei vorhanden ist!
        #[String]"Datei gefunden!" # Datei gefunden!
    }else{
        "#Bitte trag hier deine Programme ein." | Set-Content $datei #Erstellt die Datei mit default content("#Bitte trag hier deine Programme ein.")
    }

    $content = Get-content "programme.txt" #Programm lädt den Inhalt der Datei!

    if($content -match "#von FrederikHeinrich.de"){}else{ #Wenn meine Domain nicht mehr in der Config ist.
        "#von FrederikHeinrich.de" | Add-Content $datei #Füght meine Promo in die Config ein!
    }

    if($content -match "#Weitere Programme unter: chocolatey.org/packages/"){}else{ #Wenn der Cocolatey link nicht drinnen ist.
        '#Weitere Programme unter: chocolatey.org/packages/ ' | Add-Content $datei #Fügt den Link in die Config ein.
    }

    $content | Foreach-Object { #Schaut sich jede Line an!
        if($_ -match "#"){ #Wenn die Line ein # enthält wirs übersprunngen und nicht installiert!
        }else{ #Wenn die Line KEIN # enthält
            $programms = $programms + $_ #Fügt das Programm der Liste hinzu!
        }
    }

    if($aufgabe){ #Guckt nach ob die aufgabe schon durch startargumente gesetzt wurde!
        if($aufgabe -match "install"){ #Startet die Installation dank des Startargumentes!
            install #Startet die Installation Methode
        }
        if($aufgabe -match "upgrade"){#Startet das Upgrade dank des Startargumentes!
            upgrade #Startet die Upgrade Methode
        }
        if($aufgabe -match "remove"){ #Startet das löschen dank der Startargumentes!
            remove #Startet die remove Methode
        }
    }else{
        [String]$programms +" gefunden!" # Gibt in der Console eine Liste aller Programme aus!
        [String]$aufgabe = Read-Host "Was möchtest du machen? (upgrade, remove, install)" #Fragt nach der Aufgabe und nimmt die antwort des Users!
        if($aufgabe -match "i"){ #Startet die Installation dank der User Eingabe!
            install #Startet die Installation Methode
        }
        if($aufgabe -match "u"){ #Startet das Upgrade dank der User Eingabe!
            upgrade #Startet die Upgrade Methode
        }
        if($aufgabe -match "r"){ #Startet das löschen dank der User Eingabe!
            remove #Startet die remove Methode
        }
    }
}else{ #Wenn es sich nicht um ein Admin hanldelt!
    [String]"Bitte Starte das Skript als Administrator!" #Gibt die Nachricht in der Console aus!
}
#####################################################################
#                            Skript ENDE
#####################################################################
###########################################################################################################################################################
#                                                        © FrederikHeinrich, 2019
###########################################################################################################################################################
# SIG # Begin signature block
# MIIFmQYJKoZIhvcNAQcCoIIFijCCBYYCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU8lYWQRrEUkl2UfONDU2w0qtP
# PxKgggMwMIIDLDCCAhSgAwIBAgIQYs4l3Yu9BJVMaSeldvVpajANBgkqhkiG9w0B
# AQsFADAeMRwwGgYDVQQDDBNGcmVkZXJpa0hlaW5yaWNoLmRlMB4XDTE5MDIyMDE0
# MDMwM1oXDTIwMDIyMDE0MjMwM1owHjEcMBoGA1UEAwwTRnJlZGVyaWtIZWlucmlj
# aC5kZTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALpL35C6Zm5Nt3vt
# xMoYu0mYwR2Dy3D1XDdPT+I1efreVSUlWfrGn/bvfugcMyFYg6tSPKjAWPzNGFfR
# ZnrDh94BzlBJo+aWrcHw9wmFdTFyHV9uhXbHTCuYVVbgZbEIGUgcMODLvvoFApGx
# 90B34OGpbrxaxGvQtPOKGZwLe0FcBih6q2M9otUABePOpBBqucQ2LNkjoOfT3RiO
# BlvxbYedWARIksSrdzQonlJl4uBGKS3vWMESRSwB33uBv1QTXw/6Druq+ZNIPA6m
# Qu/66Y6eH0pz2+DXOv0J0X1VJyFEQaGXgrZbWrHwIEiBDfZwnky23fUrOX69szUa
# WnyuB6kCAwEAAaNmMGQwDgYDVR0PAQH/BAQDAgeAMBMGA1UdJQQMMAoGCCsGAQUF
# BwMDMB4GA1UdEQQXMBWCE0ZyZWRlcmlrSGVpbnJpY2guZGUwHQYDVR0OBBYEFBEe
# uyeNQAP3vWjeozKsJXRSq5FlMA0GCSqGSIb3DQEBCwUAA4IBAQCvNQra5vBroGWV
# rQ7I21ta+aYRDmUr3BeHHxUqABoS3FmgMsSoh4g0yPJAV/1fCNmziAgtF6z2SN7p
# c/yrSYzw8aQrjKt9HIkCKb+uq6EDqNgLeSXlV67FIprYColR5fRSkGllpCsI5s7k
# URF4/6xikzNAAkcdS6Z/xkP62SpsLbuvwBRezoXq/vt9qt/hRnhTJlrIZHst/WXY
# tX44wUnZYW6D3hvaH3kuq/HqTHNk8U3b7aA9s4oSExpNxVfu+mkMSAmfGn5oggwD
# x4iwBqw3p1NUS486CJFH7D0TQFjhQQm9yXvGGxXTT3AeKo+fzHu3DHLDMQDQ5l+k
# de3cTH4HMYIB0zCCAc8CAQEwMjAeMRwwGgYDVQQDDBNGcmVkZXJpa0hlaW5yaWNo
# LmRlAhBiziXdi70ElUxpJ6V29WlqMAkGBSsOAwIaBQCgeDAYBgorBgEEAYI3AgEM
# MQowCKACgAChAoAAMBkGCSqGSIb3DQEJAzEMBgorBgEEAYI3AgEEMBwGCisGAQQB
# gjcCAQsxDjAMBgorBgEEAYI3AgEVMCMGCSqGSIb3DQEJBDEWBBT0F65q1guFBlRh
# VmVy53QXdIPxIDANBgkqhkiG9w0BAQEFAASCAQBz4JXCsM4c9TtdplMAmX2YrFY4
# ZE1WnRQY6KLeCInaH/KYxjlsFF5HbYCo1dMWLaLpSRR9L3zIXCcnAxNLRsDCd7wD
# A2pIi4Dkoe8mw46ljbw4Qx3SXHqgnwlsfwP+AJf20l20H8t8+WP72hm10Ef+YcvI
# qmQrc813702GZju/SuOJm9eTjNB7ZIItPzdxe4avnuuq8Dms6gg15xW81CWhyYFl
# 86+Mdz4K7jHJVZi8BqSN5Hxykg/LstW+gXg4eAUVejXDenofzLUEGZx0RZq4hj/e
# jx6lRh8nJapqzwQGmGiV2U2KFp3O3GN1ZkxjGjRnOoA7zx9Fjqr1UTFb1sXS
# SIG # End signature block
