# [tcpdump](https://www.tcpdump.org/)

Print/Write network packets

Before running support-toolkit, create a volume in which to store the output.
```bash
# balena volume create supkit
supkit
```

When running support-toolkit, must use parameter `net=host` to see host level packets, and must specify volume.
```bash
# balena run \
    --rm \
    --name supkit \
    --net=host \
    -v supkit:/dump \
    -it \
    kb2ma/support-toolkit \
    bash
```

Run tcpdump on the expected network interface, for example `eth0` in the command below.
```bash
# tcpdump -U -s 0 -i eth0 not port 22222 -w /dump/dumpfile.cap
```

After exiting the container, you can find the dump file in `/mnt/data/docker/volumes/supkit/_data/dumpfile`. If this is a customer device, remove the volume.
```bash
# balena volume rm supkit
```