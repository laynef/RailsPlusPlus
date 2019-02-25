# Global Controller

## Implementation

The Global Controller uses inheritance to test defaults
for all the functionality need to complete your resources.
Restrict routes through your resource decalration.

This supports all schemas and only handles resources for a single model.

## Default Resources

All resource methods are made by default.

### Index Method

Index get default will return a limit of 25 and offset of 0 and page of 1.
Index uses offset to create pages.

Pagination:

```plain-text
First page = ?page=1&limit=25&offset=0
Second page = ?page=2&limit=25&offset=0
Etc...
```

Associations:

You can grab the associated tables with include with comma separation.
They will be formatted in the Global Controller. Provide a lowercase singluar model name.

```plain-text
?include=(1st-model-name),(2nd-model-name)
```

Custom Wheres:

You grab a custom where with key:value pairs set based on JSON formatting.
Options are separated by commas and key:values are separated by semi-colons.

```plain-text
?where=(key:value),(key:value)
```

Order:

You grab by the order of any key in the model with key:value pairs that are
comma separated. The value can only be `DESC` or `ASC`.

```plain-text
?order=(key:value),(key:value)
```

## Show Method

Returns the row by id of a model in a single object returned.

## Store Method

This handles your create with any keys you allow with `$fillable` in your model.
Returning a single object of the row created.

## Update Method

This handles your create with any keys you allow with `$fillable` in your model.
Returning a single object of the row updated.

## Destroy Method

Returns no content and deletes by id of a model.

## Overwriting Default Resources (For custom methods)

Just declare the resource method name in the parent controller
and it will over write the default in Global Controller.

Changes in the Global Controller will change all of the controllers.
