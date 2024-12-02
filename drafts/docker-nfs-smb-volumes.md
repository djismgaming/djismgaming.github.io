# About

docker volume create --driver local --opt type=nfs --opt o=addr=192.168.0.10,rw --opt device=:/mnt/user/media/ media-nfs

docker volume create --driver local --opt type=cifs --opt o=username=admin,password=djism3562p,file_mode=0777,dir_mode=0777,addr=192.168.0.10 --opt device=//192.168.0.10/shares/media media-smb
