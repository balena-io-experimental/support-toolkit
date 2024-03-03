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

After exiting the container, you can find the capture file in `/mnt/data/docker/volumes/supkit/_data`. If you use `balena ssh` to run this command on a device, export the capture file to ASCII via base64 encoding, like below. Scrape the output from your terminal and save it to a file.

```bash
# base64 dumpfile.cap >dumpfile.cap.b64
# cat dumpfile.cap.b64
```

Then on your workstation, decode the scraped capture file.
```bash
$ base64 -d dumpfile.cap.b64 >dumpfile.cap
```

Finally, remove the volume from the customer device.
```bash
# balena volume rm supkit
```