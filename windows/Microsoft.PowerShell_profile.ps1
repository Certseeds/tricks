# in C:\Users\nanoseeds\Documents\WindowsPowerShell\
Import-Module DirColors
Import-Module posh-git
Import-Module oh-my-posh
if (!(Test-Path -Path ${PROFILE} )) {
    New-Item -Type File -Path ${PROFILE} -Force 
}
Set-Theme ys