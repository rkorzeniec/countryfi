# Countify
Track and hack your travel experiences, quantify your travels and keep on top of the countries yet to see.
https://countrify.net

## App
Rails app, handling BE and FE.

## DB
The database used is MySQL 8, running on localhost, default port 3306.

## Caching
The app uses memcached as its caching mechanism, running on localhost as the app, on the default port.

## CI
Some github actions are implemented in the taste of CI.
Github actions run i.e. linting, testing.

## Deployment
App is deployed using capistrano.

## Server
App is hosted on a small Virtual Private Server provided by Hetzner.

## DevOps
Ansible script is used to provision servers.

## Countries
Country data is seeded from https://github.com/mledoze/countries
