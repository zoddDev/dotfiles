shopt -s nocasematch
case "$1" in
    "all" ) ./setup-scripts/general-packages.sh && ./setup-scripts/git-packages.sh && ./setup-scripts/wifi-packages.sh && ./setup-scripts/themes.sh $2 ;; # $2 is theme name
    "general" ) ./setup-scripts/general-packages.sh ;; 
    "git" ) ./setup-scripts/git-packages.sh ;; 
    "wifi" ) ./setup-scripts/wifi-packages.sh ;;
    "theme" ) ./setup-scripts/themes.sh $2 ;; # $2 is theme name

    *) echo "[ERROR]: no config with name \"$1\" found" && exit 1 ;;
esac

