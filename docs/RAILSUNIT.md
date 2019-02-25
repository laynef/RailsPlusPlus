# Php Unit

## Features

Unit tests are built for all resources built for the controller generated
based on all the Global Controller functionality. All querystrings are tested as well in
the `index` method.

## To-Dos

Add your create params that are defined in your `$fillable` for
the model in `$create_fillable_params`.Add your update params
that are defined in your `$fillable` for the model in `$update_fillable_params`.
Define your custom request headers in `$request_headers`.

```php
    public $create_fillable_params = [
        // TODO: Add store request body
    ];

    public $update_fillable_params = [
        // TODO: Add update request body
    ];

    public $request_headers = [
        'Content-Type' => 'application/json',
        'Accept' => 'application/json',
        // TODO: Custom headers here
    ];
```

After that migrate your database and run `phpunit`.