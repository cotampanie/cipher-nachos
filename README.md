# Demo

Demo can be found here https://ciphernachos.herokuapp.com

# Cipher Movies

## Goals

* Allow users to sign up and sign in (using the existing user model)
* After signing in, allow users to search the iTunes Store API for movies (only movies! not songs or apps!)
* Allow user to save a movie to their watch list

Bonus points if you have time:

* If a search returns no results, allow users to subscribe for notifications when those movies are available
* Deploy to Heroku

Helpful links:

* [iTunes API Documentation](https://www.apple.com/itunes/affiliates/resources/documentation/itunes-store-web-service-search-api.html#searching)
* Example API request: <https://itunes.apple.com/search?entity=movie&term=interstellar>

## Setup

To create and migrate your test and development databases, run the following commands from your project root:

```shell
bundle install
bin/rake db:create db:migrate db:test:prepare
```

## Starting the Server

To start the server, run the following from your project root:

```shell
bin/rails s
```

## Tests

To start the test suite, run the following command from your project root:

```shell
rspec
```
