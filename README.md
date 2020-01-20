# Laravel Docker Compose

[![Build Status][travis-badge]][travis-link]

A docker compose setup meant for Laravel applications. This setup will create a php container, an nginx container and a PostgresSQL container

## Usage

1) Clone this repo:
```
git clone https://github.com/jasonheecs/laravel-docker-compose.git
cd laravel-docker-compose
```
2) Run `make build`

A Laravel app will be created in your `src` folder


## Testing
Testing is done via Rspec

To run the tests:
```bash
gem install bundler
bundle install
bundle exec rspec
```

Refer to the [travis.yml](.travis.yml) file and [Travis build logs][travis-link] for details on the automated tests and expected outputs.

## Utility Commands
The `Makefile` contains a list of utility commands meant for easy manipulation of the docker containers

- `make stop`
Stops the running containers
- `make start` 
Starts the stopped containers
- `make connect`
Opens an interactive shell session within the php container
- `make rebuild`
Destroys and rebuilds the containers
- `make destroy`
Destroys the containers

## License
MIT

[travis-badge]: https://travis-ci.com/jasonheecs/laravel-docker-compose.svg?branch=master
[travis-link]: https://travis-ci.com/jasonheecs/laravel-docker-compose
