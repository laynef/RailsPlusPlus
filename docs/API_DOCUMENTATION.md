# API Documentation

## Features

You have the ability to test all your api routes that delcared in `routes/api.php`.
These docs are set like Swagger however do not require any extra configuration.

## Implementation

The javascript for all your routes are generated with the function:

```php
$docs = new DocumentationController();
$docs->generate_js_file();
```

Use this function at the bottom of your route file in `routes/api.php`.
