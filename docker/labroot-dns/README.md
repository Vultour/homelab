# DNS docker container

## Usage
`docker build -t labroot-dns .`

`docker run --rm -ti -p 53:53/tcp -p 53:53/udp labroot-dns`
