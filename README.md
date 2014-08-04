This is a Dockerfile setup for pyTivo

To run the latest pyTivo version by lucasnz:

```
docker run -p 9032:9032 -h unraid --name="pytivo" -v /path/to/media/:/media -v /path/to/config:/config -v /etc/localtime:/etc/localtime:ro -i -t pinion/pytivo

```

After install go to:

http://server:9032/ and setup your Media as normal. 

NOTE: I had a bit of an issue where I had to set my beacon to the IP of my TiVo. YMMV