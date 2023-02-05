#!/usr/bin/zsh

source ~/.zshrc

WORKING_DIR="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"
cd $WORKING_DIR

rofi_theme_selector () {
    AVAILABLE_THEMES=$(cat ./available-themes)
    NUMBER_OF_THEMES=$(($(printf `cat ./available-themes` | wc -l) + 1))
    echo -e $AVAILABLE_THEMES | rofi -font "Iosevka Bold 11" -show drun -show-icons -width 20 -l $NUMBER_OF_THEMES -dmenu -i
}

change_theme () {
    current_theme=$(cat ~/.config/current_theme)
    chosen=$1
    [ $chosen = $current_theme ] && notify-send -i ./resources/white-brush.png "[WARNING]: You are already using this theme!" && return 1
    killall -9 after-theme-swap

    cd $DOTFILES && $DOTFILES/setup-scripts/rices.sh $chosen
    cd $WORKING_DIR
    ./after-theme-swap.sh
}

POSITIONAL=()
while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
    -r|--rofi)
      chosen=$(rofi_theme_selector)
      shift # past argument
      ;;
    -t|--theme)
      chosen="$2"
      shift # past argument
      shift # past value
      ;;
    *)    # unknown option
      POSITIONAL+=("$1") # save it in an array for later
      shift # past argument
      ;;
  esac
done

if [ -z $chosen ];
then
    echo "[ERROR]: unvalid theme"
else
    change_theme $chosen
fi

