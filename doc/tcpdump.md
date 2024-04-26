# [tcpdump](https://www.tcpdump.org/)

Print/Write network packets. You can display output immediately on the terminal, or save it to a file to view with Wireshark on a workstation.

## Output to Terminal

When running support-toolkit, must use parameter `net=host` to see host level packets.
```bash
   balena run --rm -it --net=host kb2ma/support-toolkit
```

Run tcpdump on the expected network interface, like `eth0`, or `any` for all interfaces. Be sure to exclude ssh traffic on port 22222.
```bash
   tcpdump -U -s 0 -i any not port 22222

   tcpdump: data link type LINUX_SLL2
   tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
   listening on any, link-type LINUX_SLL2 (Linux cooked v2), snapshot length 262144 bytes
   00:16:04.905275 eth0  In  IP ec2-52-21-201-98.compute-1.amazonaws.com.443 > 192.168.1.127.56954: Flags [P.], seq 2838842328:283
   00:16:04.905441 eth0  Out IP 192.168.1.127.56954 > ec2-52-21-201-98.compute-1.amazonaws.com.443: Flags [.], ack 43, win 501, o0
   00:16:04.905854 eth0  Out IP 192.168.1.127.56954 > ec2-52-21-201-98.compute-1.amazonaws.com.443: Flags [P.], seq 1:44, ack 43,3
   00:16:04.936980 eth0  In  IP ec2-52-21-201-98.compute-1.amazonaws.com.443 > 192.168.1.127.56954: Flags [.], ack 44, win 484, o0
   00:16:04.946071 lo    In  IP 10.114.102.1.57592 > 10.114.102.1.53: 60786+ PTR? 98.201.21.52.in-addr.arpa. (43)
   00:16:04.946573 eth0  Out IP 192.168.1.127.21708 > dns.google.53: 2895+ PTR? 98.201.21.52.in-addr.arpa. (43)
   00:16:04.946671 eth0  Out IP 192.168.1.127.21708 > 192.168.1.1.53: 2895+ PTR? 98.201.21.52.in-addr.arpa. (43)
```

## Save to File

Create a volume in which to store the output, and then reference it when running the toolkit.
```bash
   balena volume create supkit
   balena run --rm -it --net=host \
      -v supkit:/data kb2ma/support-toolkit
```

Within the toolkit container, run `tcpdump` on the expected network interface, like `eth0`, or `any` for all interfaces. Be sure to exclude ssh traffic on port 22222. Capture the output to a file in the volume.
```bash
   tcpdump -U -s 0 -i any not port 22222 -w /data/dumpfile.cap
```

After exiting the container, you can find the capture file in `/mnt/data/docker/volumes/supkit/_data`. If you use `balena ssh` to run this command on a device, use `balena tunnel` and `scp` to collect the file, like in the example below.

First open a new terminal, and enter this command.
```bash
   balena tunnel <uuid> -p 22222

   [Info]    Opening a tunnel to <uuid>...
   [Info]     - tunnelling localhost:22222 to <uuid>:22222
   [Info]    Waiting for connections...
```

Then in another terminal:
```bash
   scp -P 22222 <balena_user_slugname>@localhost:/mnt/data/docker/volumes/supkit/_data/dumpfile.cap .
```
After collecting the file, close those two terminals.

Finally, from the ssh terminal, remove the volume from the customer device.
```bash
   balena volume rm supkit
```
