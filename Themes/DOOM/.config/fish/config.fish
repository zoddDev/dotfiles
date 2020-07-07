set fish_greeting

# zodd aliases {

     # Doesn't need explanation.
     alias sayhello='printf "hello $USER!\n"'
     alias whoilove='printf "$USER really loves Ada!\n"'
 
     # Runs C file named: 'main.c'
     # alias crun='gcc ./main.c && ./a.out'
 
     # Go to 2TB
     alias 2tb='cd /media/2TB/Users/aa/'
 
     # Go to 250GB
     alias 250gb='cd /media/250GB/Users/JOSE/'
 
     # opens sqldeveloper
     alias sqldeveloper='~/250gb/Desktop/sqldeveloper/sqldeveloper.sh'
     # Opens eclipse
     alias eclipse='~/eclipse/java-2019-12/eclipse/eclipse'
     
     alias godot='~/software/Godot/Godot_v3.2.1-stable_x11.64'
     alias piskel='~/software/Piskel-0.14.0-64bits/piskel'
     
     # -------------------- Pops this document in order to add/edit/remove aliases --------------------
     
     # Comment/Uncomment if needed:
		 # For bash:
		 	# alias aliaschanger='vim ~/.bashrc'
	 	 # For fish:
	 	 	alias aliaschanger='vim ~/.config/fish/config.fish'
 	
 	 # ------------------------------------------------------------------------------------------------
     # i3 config file
     alias i3config='vim ~/.config/i3/config'

     # Rofi theme
     alias rofitheme='sudo vim /usr/share/rofi/themes/zodd.rasi'

     # Change prompt style in fish:
     alias fishprompt='vim ~/.config/fish/functions/fish_prompt.fish'

     # Check disks space
     alias fdisks='df --total --block-size=G | grep dev/sd --color=never'

     # Launches intellij idea
     alias idea='~/software/idea-IC-193.6494.35/bin/idea.sh'
 
	 # My ps
     alias myps='watch ps o pid,ppid,stat,comm'
    
     # spiecitify
     alias spicetify='/home/zodd/spicetify-cli/spicetify'

     # Prints my wallpapers directory
      alias mywallpapers='echo ~/.local/share/wallpapers'
    
     # Ranger configuration file
      alias rangerconf='vim ~/.config/ranger/rifle.conf'
        
     # Polybar config
      alias polyconfig='vim ~/.config/polybar/config' 
     
     # sxhkd config
      alias sxhkdconfig='vim /home/zodd/.config/sxhkd/sxhkdrc'
    
     # git-clean (clean /home/zodd/Downloads/git-downloads)    
      alias git-clean='rm -rf /home/zodd/Downloads/git-downloads/*'
    
     # choose neofetch ascii distro
      alias neofetch='neofetch --ascii_distro freebsd'
          
     # current workspace
      alias current-workspace="wmctrl -d | grep '*' | awk 'NF>1{print $NF}'"       
     # animalese
      alias animalese='java -jar ~/Dropbox/Programming/Java/Tests/Animalese/out/artifacts/Animalese_jar/Animalese.jar'
     # Update Nord Theme
      alias update-nord='rm ~/.local/share/wallpapers/nord-theme/* && cp ~/Pictures/Wallpapers/Wallpapers/nord-theme/* ~/.local/share/wallpapers/nord-theme/' 

     # mps-youtube:
        # Solution for API error:
            # Copy key: https://console.developers.google.com/apis/credentials?folder=&organizationId=&project=adept-tangent-273803
            # mpsyt set api_key [KEY]
        # Delete all content from: ~/.config/mps-youtube/

# }
 

