# ttools-sitesync-silverstripe
Terminal Tools Sitesync module for SilverStripe


## Prerequisites

Make sure you've got the latest version (`onedir` branch) of [ttools](https://github.com/titledk/ttools-core)
and [ttools sitesync](https://github.com/titledk/ttools-sitesync-core) installed


## Installation

	git submodule add https://github.com/titledk/ttools-sitesync-silverstripe.git ttools/sitesync-silverstripe
	git submodule add https://github.com/silverstripe/sspak.git ttools/thirdparty/sspak


You can now add menu items like this:

    Menu:
      Heading1:
        Title: Sitesync examples
        Item1:
          Title: Overwrite Local Site with Database & Assets from Live Site
          Command: "ttools/sitesync-core/local/sync-environments.sh Live Local"
        Item2:
          Title: Push Database & Assets to Dev Site
          Command: "ttools/sitesync-core/local/sync-environments.sh Local Dev"
        Item3:
          Title: Overwrite Dev Site with Database & Assets from Live Site
          Command: "ttools/sitesync-core/local/sync-environments.sh Live Dev"      
        
