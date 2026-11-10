---
title: Schema
published: true
---

<{ :toc }>

Like tests in Postman or Bruno, an endpoint can say what its response should be, with [status:](/docs/endpoint#checking-responses) and `schema:`. Define a schema with `schema:`, its name and its fields below it, indented, then give its name to the endpoints below it:

`````md
schema: User
  id: Integer
  email: String | nil
  tags: Array[String]

endpoint: as: user status: 200 schema: User
```sh
curl {base_url}/users/1
```
`````

A schema is a [LowType](https://github.com/low-rb/lowtype) type. Raindown reads `User` as `Schema[id: Integer, email: String | nil, tags: Array[String]]`, a hash with named keys, where a key whose type allows `nil` may be missing, and keys it doesn't name are allowed. Raindown reads the type without running it, so only types, values, `|` and `[]` on `Array`, `Hash`, `Schema`, `Enum` and `Status` are allowed.

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

A small schema can be written in the endpoint itself, with `Schema[]`, nested like `Schema[address: Schema[city: String]]`, and in lists, like `Array[Schema[id: Integer]]`. Write schemas with `Schema[]`, not `{}`, which reads as a variable:

`````md
endpoint: schema: Schema[id: Integer, email: String | nil]
`````

### Where schemas go

- **The name can be quoted**, like `schema: 'User'`, or not.
- **In a Raindown file**, write `schema: User` bare. Its fields end at the first line that isn't indented, and it shows in bold with its fields below it.
- **In a Markdown file**, write it in a comment, which is left out of the HTML, ending at `-->`:

  ```md
  <!-- schema: User
    id: Integer
  -->
  ```
- **Shared schemas** go in `.raindown/schemas.rd`, written bare the same way, and every file's endpoints can name them. A file's own schema with the same name wins.

### Checking

Raindown checks every response in the file, whether it's just run or was already there, by the status in the comment above it, so checking needs no requests. Responses fetched before Raindown kept statuses only have their schema checked. Failures are listed with where they are, like `api.md:3: id: expected Integer, received "1"`:

- **`--html` fails.** It lists failures and exits with `1` after writing the HTML, so CI can check that your docs still match your API.
- **Watching lists them** each time the file is written back.
- **The terminal UI shows them** after running an endpoint.

To check a live API in CI, empty the response blocks first, then run with `-x`.
