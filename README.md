This is a Dockerfile setup for pyTivo

To run the latest pyTivo version by lucasnz:

```
docker run -p 9032:9032 -d -h unraid --name="pytivo" -v /path/to/media/:/media -v /path/to/config:/config -v /etc/localtime:/etc/localtime:ro pinion/docker-pytivo

```

After install go to http://server:9032/ and click "settings"
* Select "Global Server Settings"
* No need to set paths for ffmpeg, tivodecode and tdcat, they will be found automatically
* Set the beacon to the IP address of your Tivo
* Set your tivo_username and tivo_password if you want to Push files to your TiVo (see note below)
* Set your tivo_mak if you want tivodecode to automatically convert the .tivo file to .mpg
* Set the togo_path to /media or whatever is appropriate for your system
* Click "Save Changes"
* Select "MyMovies"
* Set the path to /media or whatever is appropriate for your system
* Click "Save Changes"
* Click "Restart pyTivo"
* After about 10 seconds, return to the pyTivo home page and you should see your Tivo in the list.

For additional help on the settings, see: http://pytivo.sourceforge.net/wiki/index.php/Configure_pyTivo
Not sure how to find your Tivo Mak? See http://lmgtfy.com/?q=what+is+my+tivo+mak

Notes:
* Pulling movies from the Tivo and converting them to .mpg works great
* Pushing movies to the Tivo doesn't work; however, from the Tivo Now Playing List you should see "MyMovies", and can transfer movies from there
