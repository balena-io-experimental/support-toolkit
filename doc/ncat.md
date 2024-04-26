# [ncat](https://nmap.org/ncat/guide/index.html)

Ncat allows you to experiment with network communication.

## Simple web server

Ncat includes a simple web server. To run it, follow these steps:

Start the toolkit interactively, publishing the web server externally on port 8080:
```bash
   balena run --rm -it -p 8080:80 kb2ma/support-toolkit
```

Then start the web server:
```bash
   cd src/ncat
   ncat --lua-exec httpd.lua --listen 80 --keep-open
```

Then you can fetch the page from a URL like `http://<host-ip>:8080/index.html`, for example from the host OS terminal:

```bash
   curl http://127.0.0.1:8080/index.html                                                                          
   <html>
     <body>
        Hello World!
     </body>
   </html>

```

See the section *Turn Netcat into a simple web server* on the Neat Tricks [page](https://nmap.org/ncat/guide/ncat-tricks.html) for more details on how this works.
