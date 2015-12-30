## Fork update:
To run with a btsync.conf outside of the image:

    docker build -t ekinsokmen/btsync .
    docker run -v /home/btsync:/root/btsync:rw -v ~/config/btsync/:/etc/btsync:rw ekinsokmen/btsync

---

# Bittorrent Sync Docker Container

This is a simple docker file to setup a [bittorrent sync](http://labs.bittorrent.com/experiments/sync.html) server. Just

 * Create `btsync.conf`
 * Build the container
 * Run the container
 * Browse to the BTSync Web UI
 * Add a shared folder

If you pass the `-v` flag to the `docker run` command, you can share the files with the host OS. This is good for sharing with Owncloud and similar.

## Set it up

    cd btsync
    vi btsync.conf # See example at end of README
    sudo docker pull ubuntu
    sudo docker build -t mattwilliamson/btsync .
    sudo docker run -d -v /var/btsync:/var/btsync:rw mattwilliamson/btsync

----

    matt@ks208738:~/btsync$ sudo docker ps
    ID                  IMAGE                          COMMAND                CREATED             STATUS              PORTS
    80eff0864e83        mattwilliamson/btsync:latest   /usr/lib/btsync/btsy   3 seconds ago       Up 3 seconds        49154->3369/udp, 49155->8888 

Browse to `http://$myserverhostname:49155/gui/` or whatever port maps to 8888 and add your shared folder.

Sample `btsync.conf`:

    {
        "device_name": "My Server",
        "listening_port" : 3369, 
        "storage_path" : "/root/btsync",
        "check_for_updates" : false, 
        "use_upnp" : false,
        "download_limit" : 0, 
        "upload_limit" : 0, 
        "webui" :
        {
            "listen" : "0.0.0.0:8888",
            "login" : "webusername",
            "password" : "supersecr3t"
        } 
    }


