# [lshw](https://ezix.org/project/wiki/HardwareLiSter)

Hardware lister; show the components on a device

Include `--privileged` flag to `balena run` to see all resources.

Include `-short` flag to `lshw` for more compact output. For example:

```bash
   balena run --rm --privileged kb2ma/support-toolkit -c "lshw -short"
```

