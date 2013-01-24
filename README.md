## subl 

The subl repo contains a chef-solo based installer for Sublime Text 2. This is for sharing my own personal module and keybinding preferences between OSX and ubuntu desktops.  The installed modules and keybindings are shared between linux and OSX therefor updates can be made on either platfrom and then shared by pushing back up to github.

## Bootstrap
The bootstrap script assumes you have a system ruby (>1.8.7) and will installs rvm (Ruby Version Manager) if it is not already present to upgrade you to the latest ruby for your system.  Bootstrap also install rubygems from source and the chef gem.  This script only need be run once to configure rvm, ruby and chef appropriately. 

```
> ./bootstrap.r
```
## Installation 

The installer will bootstrap chef-solo if necessary and the run 'chef-solo -c solo.rb -j install.json' from the kitchen directory

```
> ./install.rb
```
Note the message below message is a harmless bug in the current ohai gem and can safely be ignored. 

```
sh: 1: Permission denied"
```


## Installation 
# Packages
* PackageControl
* Alignment
* AdvancedNewFile
* SublimeREPL (+pry gem for ruby)
* JSFormat
* StackOverflowSearch
* ActionScript3
* sublemacspro
* Vagrant

## Push
In the event that you add new packages or keybindings the push recipe will tar up the current state of sublime on either platform and push it to github

```
> ./push.rb
```

## Keybindings

OSX and linux keybindings are shared.  The keybindings are linux defaults with overrides largely definded by sublemacspro (i.e. very emacs like).  User overrides are tabulated below. 

Keybinding    | Command       | Keybinding    | Command           
------------  | ------------- | ------------  | ----------------  
super+d       | Select word   | super+i       | toggle overwrite  
super+l       | Select line   | cntrl+shift+w | close all tabs    
super+shift+b | Bash shell    | super+shift+r | ruby interpreter shell
ctrl+tab      | Next tab      | 

OSX Specific

Keybinding    | Command       
------------  | -------------------  
super+shift+. | toggle hidden files 

## Authors

* Sean Kelly sean.alexander.kelly@gmail.com

## License

Licensed under the Apache License, Version 2.0: http://www.apache.org/licenses/LICENSE-2.0
