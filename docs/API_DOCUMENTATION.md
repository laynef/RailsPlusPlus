# API Documentation

## Features

You have the ability to test all your api routes that delcared in `config/routes.rb`.
Within the namespace :api.

These docs are set like Swagger however do not require any extra configuration.

## Implementation

The javascript for all your routes are generated with the `config/initializers/api_documentation_js.rb`

The generate js file method is in this initializer.

Rack Cors is setup as well in your initializer for cors in path `config/initializers/cors.rb`
