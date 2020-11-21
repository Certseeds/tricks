$script = {
    $appList = "7zip", "potplayer","openjdk11","nodejs","nvm","github","neatdownloadmanager","gpg4win","jetbrains-toolbox","sudo";
    $scoop_bucket_list = "extras","java";
    #Main-function
    function main {
        #starting helper function
        update_scoop
        search
        install
    }

    function add_bucket{
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
    }
    function search {
        foreach ($item in $appList) {
            scoop install $item
        }
    }
    #Entry point
    main
}
#netsh winhttp set proxy 127.0.0.1:1080
Invoke-Command $script