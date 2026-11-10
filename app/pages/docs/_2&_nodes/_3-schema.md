---
title: Schema
published: true
---

<{ :toc }>

Like tests in Postman or Bruno, an [endpoint](/docs/endpoint) can say what its response should be with [status:](/docs/endpoint#checking-responses) and `schema:`

```md
schema: User
  id: Integer
  email: String | nil
  tags: Array[String]
```

The name can be quoted like `schema: 'User'`, or not.

### Endpoints

Now an `endpoint:` can validate a request against a status and schema by referencing the schema name:
`````md
endpoint: as: user status: 200 schema: User
```sh
curl {base_url}/users/1
```
`````

### Types

A schema is a [LowType](https://github.com/low-rb/lowtype) type. Raindown reads `User` as...
```
Schema[id: Integer, email: String | nil, tags: Array[String]]
```

...a hash with named keys, where a key whose type allows `nil` may be missing, and keys it doesn't name are allowed. Raindown reads the type safely without executing any code, so only types and values representing types are allowed:
- `|` - Union type
- `Enum`
- `Array[]`
- `Hash[]`
- `Schema`
- `Status`

### Nesting

A key with no type holds the more indented fields under it, like `address:`, and a schema's name goes inside types, like `Array[User]`, and in the schemas below it, like `author: User`:

`````md
schema: User
  id: Integer
  address:
    city: String

schema: Post
  title: String
  author: User

endpoint: schema: Array[Post]
`````

### Inline schemas

A small schema can be written in the endpoint itself, with `Schema[]`, nested like `Schema[address: Schema[city: String]]`, and in lists, like `Array[Schema[id: Integer]]`. Write schemas with `Schema[]`, not `{}` (which read as variables):

`````md
endpoint: schema: Schema[id: Integer, email: String | nil]
`````

### Syntax

- **In a Raindown file**, write `schema: User` bare. Its fields end at the first line that isn't indented, and it shows in bold with its fields below it.
- **In a Markdown file**, write it in a comment, which is left out of the HTML, ending at `-->`:

  ```md
  <!-- schema: User
    id: Integer
  -->
  ```

### Schemas.rd

Shared schemas go in `.raindown/schemas.rd`, written bare the same way, and every file's endpoints can name them. A file's own schema with the same name wins.

### Checking

Raindown checks every response in the file, whether it's just run or was already there, by the status in the comment above it, so checking needs no requests. Responses fetched before Raindown kept statuses only have their schema checked. Failures are listed with where they are, like `api.md:3: id: expected Integer, received "1"`:

- **`--html` fails.** It lists failures and exits with `1` after writing the HTML, so CI can check that your docs still match your API.
- **Watching lists them** each time the file is written back.
- **The terminal UI shows them** after running an endpoint.

To check a live API in CI, empty the response blocks first, then run with `-x`.
