# luzifer-docker / codimd

This container contains a CodiMD server.

## Usage

```bash
## Build container (optional)
$ docker build -t luzifer/codimd .

## Execute CodiMD
$ docker run -d -p 3000:3000 luzifer/codimd
```

- Within `/config` you can supply your own config to override the defaults
- Mount `/data` to persist the sqlite database
- Mount `/codimd/public/uploads` to persist images pasted into the editor
