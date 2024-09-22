# docker-samba-multi-share
Samba Container with multiple seperated (also credentialy seperated) network drives in a single docker container

The Dockerfile creates mutliple user accounts for smb and adds the smb.conf that you will have to edit first.

# Build and Run: 

## Cloning the Repository: 
```bash
git clone "<<repository pull link>>"
```
## Customizing your samba Configuration:
```bash
cd compose && sudo vim smb.conf
```
edit the last block. Here you can add as many Networkshares as you need:
```yaml
...


[Share1]
    path=/mnt/share1
    public=no
    valid users=userA
    write list=userA
    read only=no

[Share2]
    path=/mnt/share2
    public=no
    valid users=userB
    write list=userB2
    read only=no
```

create the directories where you want to mount the shares on your harddrive (in the example its mounted in /mnt/shareX)
Example: 

```bash
sudo mkdir /mnt/shareA && sudo mkdir /mnt/shareB
```

Edit your docker-compose.yml to customize for your users and volume mapping: 

```bash
cd compose && sudo vim docker-compose.yml
```

edit the following section as you wish:

```yaml
  volumes:
     - /opt/samba/smb.conf:/etc/samba/smb.conf
      #MAKE SURE YOU NAME THE DIRECTORY LINKS CORRECTLY. 
     - /mnt/shareA:/mnt/shareA  #<-- your share mounts here
     - /mnt/shareB:/mnt/shareB  #<-- your share mounts here 
   environment:
     - user_count=2 
     - user1=userA
     - password1=<<PW>>
     - user2=userB
     - password2=<<PW>>
```

## Create your Image in:

```bash
cd image && docker image build -t samba .
```
## Run your Container via Docker-compose:

```bash
cd compose && docker-compose up -d --force-recreate
```

DONE!
