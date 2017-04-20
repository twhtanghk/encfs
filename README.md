# encfs
Secure remote storage using sshfs and encfs

# start container
1. save local copy of docker-compose.yml and .env
2. customize .env to define ENCFS_PASS (encryption password) and SSHFS_PASS (root password)
3. docker-compose -f docker-compose.yml up -d
4. run client container (e.g. debian:jessie with sshfs installed) and commnd sshfs encfs_encfs_1:/data /mnt
5. create /mnt/file and check encypted file under host directory ./raw
