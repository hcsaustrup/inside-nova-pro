# Building Applications

## Go

You can easily build binaries for the Nova from your PC, as long as you specify the correct operating system, architecture and ARM processor model:

```bash
GOOS=linux GOARCH=arm GOARM=7 go build -ldflags="-s -w"
```

