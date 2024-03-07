# [ncat](https://nmap.org/ncat/guide/index.html)

Ncat allows you to experiment with network communication.

## Simple web server

Ncat includes a simple web server. To run it, follow these steps:

Start the toolkit interactively, including making the web server available locally on port 8080:
```bash
# balena run --rm --name supkit -it -p 127.0.0.1:8080:8080 kb2ma/support-toolkit
```

Then start the web server:
```bash
# cd src/ncat
# ncat --lua-exec httpd.lua --listen 8080 --keep-open
```

Then you can fetch the page from the device at the URL http://localhost:8080/index.html.

See the section *Turn Netcat into a simple web server* on the Neat Tricks [page](https://nmap.org/ncat/guide/ncat-tricks.html) for more details on how this works.
