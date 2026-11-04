---
title: Schema
published: true
---

<{ :toc }>

Like tests in Postman or Bruno, an endpoint can say what its response should be, with `status:` and `schema:`:

`````md
<!-- endpoint: as: user status: 200 schema: Schema[id: Integer, email: String | nil, tags: Array[String]] -->

```sh
curl {base_url}/users/1
```
<!-- :endpoint -->
`````

A schema is a [LowType](https://github.com/low-rb/lowtype) type. `Schema[]` is a hash with named keys, a key whose type allows `nil` may be missing, and keys it doesn't name are allowed. Nest them, like `Schema[address: Schema[city: String]]`, and check lists, like `Array[Schema[id: Integer]]`. Write schemas with `Schema[]`, not `{}`, which reads as a variable. Raindown reads the type without running it, so only types, values, `|` and `[]` on `Array`, `Hash`, `Schema`, `Enum` and `Status` are allowed.

### Named schemas

For a bigger schema, name it with `schema:` and its fields below it, indented, then give its name to the endpoints below it:

`````md
<!-- schema: User
  id: Integer
  email: String | nil
  address:
    city: String
-->

<!-- endpoint: schema: User -->
`````

Raindown reads it as `Schema[id: Integer, email: String | nil, address: Schema[city: String]]`:

- **The name can be quoted**, like `'User'`, or not.
- **A key with no type** holds the more indented fields under it, like `address:`.
- **A name goes inside types**, like `schema: Array[User]`, and in schemas below it, like `author: User`.
- **In a Raindown file**, write `schema: User` bare. Its fields end at the first line that isn't indented, and it shows in bold with its fields below it. In comments it's left out of the HTML.
- **Shared schemas** go in `.raindown/schemas.rd`, written bare the same way, and every file's endpoints can name them. A file's own schema with the same name wins.

Raindown checks every response in the file, whether it's just run or was already there, by the status in its fetched comment, so checking needs no requests. Responses fetched before Raindown kept statuses only have their schema checked. Failures are listed with where they are, like `api.md:3: id: expected Integer, received "1"`:

- **`--html` fails.** It lists failures and exits with `1` after writing the HTML, so CI can check that your docs still match your API.
- **Watching lists them** each time the file is written back.
- **The terminal UI shows them** after running an endpoint.

To check a live API in CI, empty the response blocks first, then run with `-x`.