tvhProxy
========

A small flask app to proxy requests between Plex Media Server and Tvheadend. This repo adds a few critical improvements and fixes to the archived upstream version at [huncrys/tvhProxy](https://github.com/huncrys/tvhProxy):

- Configuration of variables via [dotenv](https://pypi.org/project/python-dotenv/) file
- Added DeviceId to env file 
- Updated Dockerfile to python version 3.9

#### tvhProxy configuration
1. Check tvhProxy.py for configuration options and set them up them as ```KEY=VALUE``` pairs in a ```.env``` file.
2. Create a virtual enviroment: ```$ python3 -m venv .venv```
3. Activate the virtual enviroment: ```$ . .venv/bin/activate```
4. Install the requirements: ```$ pip install -r requirements.txt```
5. Finally run the app with: ```$ python tvhProxy.py```

#### systemd service configuration
A startup script for Ubuntu can be found in tvhProxy.service (change paths and user in tvhProxy.service to your setup), install with:

    $ sudo cp tvhProxy.service /etc/systemd/system/tvhProxy.service
    $ sudo systemctl daemon-reload
    $ sudo systemctl enable tvhProxy.service
    $ sudo systemctl start tvhProxy.service

#### Plex configuration
Enter the IP of the host running tvhProxy including port 5004, eg.: ```192.168.1.50:5004```, use ```http://192.168.1.50:5004/epg.xml``` for the EPG (see [Using XMLTV for guide data](https://support.plex.tv/articles/using-an-xmltv-guide/) for full instructions).

Should the proxy keep disappearing or you can't add it, it's worth trying to delete the existing configuration from the database: 
- See https://support.plex.tv/articles/201100678-repair-a-corrupt-database/ on how to access the plex config database and
- run ```delete from media_provider_resources;``` to remove any leftover config.
