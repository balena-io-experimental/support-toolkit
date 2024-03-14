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

Run tcpdump on the expected network interface, like 'eth0', or `any` for all interfaces. Be sure to exclude ssh traffic on port 22222. Capture the output to a file in the volume.
```bash
# tcpdump -U -s 0 -i any not port 22222 -w /data/dumpfile.cap
```

After exiting the container, you can find the capture file in `/mnt/data/docker/volumes/supkit/_data`. If you use `balena ssh` to run this command on a device, use `balena tunnel` to collect the file, like in the example below.

First open a new terminal, and enter this command.
```bash
# balena tunnel <uuid> -p 22222
[Info]    Opening a tunnel to <uuid>...
[Info]     - tunnelling localhost:22222 to <uuid>:22222
[Info]    Waiting for connections...
```

Then in another terminal:
```bash
# scp -P 22222 <balena_user_slugname>@localhost:<absolutePathToFileOnDevice> <destination>
```
After collecting the file, close those two terminals.

Finally, from the ssh terminal, remove the volume from the customer device.
```bash
# balena volume rm supkit
```
