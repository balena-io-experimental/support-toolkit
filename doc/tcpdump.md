# [tcpdump](https://www.tcpdump.org/)

Print/Write network packets

Before running support-toolkit, create a volume in which to store the output.
```bash
# balena volume create supkit
supkit
```

When running support-toolkit, must use parameter `net=host` to see host level packets, and must specify volume.
```bash
# balena run --rm --name supkit -it \
    --net=host -v supkit:/data \
    kb2ma/support-toolkit
```

Run tcpdump on the expected network interface, for example `eth0` in the command below. Capture the output to a file in the volume.
```bash
# tcpdump -U -s 0 -i eth0 not port 22222 -w /data/dumpfile.cap
```

After exiting the container, you can find the capture file in `/mnt/data/docker/volumes/supkit/_data`. When done, remove the volume from the customer device.
```bash
# balena volume rm supkit
```