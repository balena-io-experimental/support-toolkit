# Support Toolkit
Provides tools containerized for balena device support, and available from a bash shell.

## Tools
A tool name link is to local docs on how to run it in a support context for a balena device.

| Tool | Description |
| ---- | ----------- |
| bash | Provides shell for the container |
| [lshw](doc/lshw.md) | List hardware on device |
| nano | Text editor with a command bar |
| [ncat](doc/ncat.md) | Networking tool, including simple web server |
| [tcpdump](doc/tcpdump.md) | Collect network packets for Wireshark |

## Running

A particular tool may require host networking or privileged operation. See the tool doc link above for specifics.

To run the toolkit interactively from a bash shell:
```bash
# balena run --rm --name supkit -it kb2ma/support-toolkit
```

To execute a command directly, for example `lshw`:
```bash
# balena run --rm kb2ma/support-toolkit -c "lshw -short"
```


## Development

Build with `./build-images.sh <docker-hub-repository>`

Add any howto/documentation to a file in the `doc` directory, with the name of the tool. Update the *Tools* section above to link to it as well.
