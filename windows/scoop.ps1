$script = {
    $appList = 
    "7zip",
    "adopt11-hotspot", "adopt14-hotspot", "adopt8-hotspot", "ant", "aria2",
    "cmake", "colortool",
    "dismplusplus",
    "everything", "exiftool",
    "gh", "github", "go", "gpg4win",
    "innounp",
    "jetbrains-toolbox"
    "kotlin",
    "maven","miniconda3",
    "neatdownloadmanager", "neteasemusic", "nodejs","nvm",
    "officetoolplus",
    "pdf-xchange-editor","potplayer",
    "rufus",
    "spacesniffer","steam","sudo",
    "unxutils",
    "which";
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
    function mysql_setting {
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
    function oh_my_posh {
        sudo Install-Module DirColors
        sudo Install-Module PSReadLine
        # !Dont Forget C:\Users\nanoseeds\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
    }
    #Entry point
    main
}
#netsh winhttp set proxy 127.0.0.1:1080
Invoke-Command $script
