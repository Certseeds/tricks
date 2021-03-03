$script = {
    $appList = "7zip", "potplayer", 
    "adoptopenjdk-lts-hotspot" # at least now it is 11
    , "nodejs", "nvm", "github", 
    "neatdownloadmanager", "gpg4win", "jetbrains-toolbox", "sudo", "cmake",
    "dismplusplus", "wox", "everything","aria2","mysql","oh-my-posh";
    $scoop_bucket_list = "extras", "java", "dorado https://github.com/chawyehsu/dorado";
    #Main-function
    function main {
        #starting helper function
        update_scoop
        search
        install
    }

    function add_bucket {
        foreach ($item in $scoop_bucket_list) {
            scoop bucket add $item;
        }
    }

    #Helpers
    function update_scoop {
        scoop update
        scoop update *
    }
    function install {
        foreach ($item in $appList) {
            scoop install $item
        }
        scoop config aria2-enabled false
    }
    function search {
        foreach ($item in $appList) {
            scoop install $item
        }
    }
    function mysql_setting{
        Set-Location ~
        Set-Location ./scoop
        Set-Location ./persist
        Set-Location ./mysql
        Set-Location ./data
        sudo rm -rf ./*
        mysqld --initialize
        sudo mysqld.exe --install
        sudo net start mysql
    }
    function oh_my_pose {
        sudo Install-Module DirColors
        sudo Install-Module PSReadLine
        Import-Module oh-my-posh
        # !Dont Forget C:\Users\nanoseeds\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
    }
    #Entry point
    main
}
#netsh winhttp set proxy 127.0.0.1:1080
Invoke-Command $script
