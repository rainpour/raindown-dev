---
title: Endpoints
published: true
---

<{ :toc }>

Put an `endpoint:` directive above a curl snippet and Raindown writes the response in a code block below it, typed by its content type, followed by the date it was fetched, its status and how long it took:

````md
<!-- endpoint: -->

```sh
curl https://httpbin.org/uuid
```

```json
{
  "uuid": "4c9d6a2e-…"
}
```
<!-- raindown:fetched 2026-10-14 · 200 · 142 ms -->
<!-- :endpoint -->
````

In a [Raindown file](/docs/raindown-files) you can write `endpoint:` bare, which ends after the curl snippet and response, so there's no `<!-- :endpoint -->`. In `<{ endpoint: }>` it only renders, so it never runs.

## Running requests

Endpoints only run when you pass `-x` (or `--execute`), and then only the ones whose response block is missing or empty. Without it, Raindown never sends a request, so opening a file is safe:

```shell
raindown api.md -x
raindown watch api.md -x
```

In the [terminal UI](/docs/cli#terminal-ui), select an endpoint and press `x`, or click its `[Run]` button, to run just that one, replacing its response.

## Refreshing responses

To refresh a response, empty its code block and run Raindown with `-x`, and its fetched date, status and time are updated too.

They're in an HTML comment, so they're hidden on the page, but anyone reading the file or the HTML source, people or agents, can tell how fresh the example is and whether it worked.

## Variables

Like Postman or Bruno, a snippet can use variables, like `{base_url}` and `{token}`. Values come from, in order, with later ones winning:

1. The file's front matter.
2. The project's environment.
3. Earlier responses, named with [`as:`](#chaining-requests).

`{env.NAME}` is the environment variable `NAME`, so secrets stay out of your files:

```sh
curl -H 'Authorization: Bearer {env.API_TOKEN}' {base_url}/me
```

Placeholders without a value, like the braces in a JSON body, are left as they are. Each word of the snippet is filled in after it's split, so a value can't add curl options.

### Environments

Environments go in `.raindown/environments.yml`, and an environment's values can read environment variables too:

```yaml
local:
  base_url: http://localhost:3000
staging:
  base_url: https://staging.example.com
  token: '{env.STAGING_TOKEN}'
```

The first environment is used unless you pass `--env` or set `RAINDOWN_ENV`:

```shell
raindown api.md -x --env staging
RAINDOWN_ENV=staging raindown watch -x
```

### Secrets

Put secrets in `.raindown/environments.local.yml`, which adds to and overrides `environments.yml`, environment by environment:

```yaml
staging:
  token: sk-live-…
```

`raindown init` creates a `.raindown/.gitignore` that leaves it out of git. If your project's `.raindown` folder came before that, add `environments.local.yml` to a `.gitignore` yourself.

Values from `environments.local.yml` and `{env.NAME}` are secret: when a response or an error echoes one, Raindown writes its placeholder, like `{token}`, instead of the value. A later request that reads that response, like `{me.token}`, still gets the real value. Values shorter than four characters aren't hidden, as they'd match anywhere in a response.

## Chaining requests

Name an endpoint with `as:` and later snippets in the file can read its response. JSON is read by path, like `{login.token}` or `{users.0.id}`, and any response as a whole, like `{login}`:

`````md
<!-- endpoint: as: login -->

```sh
curl -d 'user=ada' {base_url}/login
```
<!-- :endpoint -->

<!-- endpoint: -->

```sh
curl -H 'Authorization: Bearer {login.token}' {base_url}/me
```
<!-- :endpoint -->
`````

With `-x`, endpoints run from the top of the file down, so a login runs before the requests that use its token. Responses are read from the file, so running one endpoint on its own, like from the terminal UI, still uses the responses above it.

## Checking responses

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

See [Schema](/docs/schema) directive.

## Running files you trust

> [!WARNING]
> Be careful which files and folders you run Raindown on with `-x`. It runs every endpoint in the files it opens or watches, including files added to a watched folder later, so only use it on files you've read or trust, as you would before running `make` in a repo.

Requests go out from your machine, so a snippet can reach anything it can, like servers running on it at `localhost` and services on your private network. With [variables](#variables), it can also send your environment variables, like API keys, wherever its URL points.

Raindown guards against the worst of it:

- **Files can't run themselves.** Only `-x`, or running an endpoint in the terminal UI, sends requests. Reading a file, rendering it without `-x`, and the [VS Code preview](/docs/extensions) never do.
- **Cloud metadata is refused.** Link-local addresses (`169.254.0.0/16` and `fe80::/10`), like the cloud metadata service at `169.254.169.254` that can give out a server's credentials, are refused however they're written, like `2852039166` or `[::ffff:169.254.169.254]`.
- **Hosts are checked before they're requested.** Raindown looks up each host itself and pins curl to the address it checked, with `--resolve`, so a name can't point somewhere else by the time curl connects.
- **Redirects aren't followed.** `-L` is rejected, so a public URL can't redirect to an address that would be refused.
- **Secrets aren't written back.** A response or error that echoes a [secret](#secrets) is written with its placeholder.

Behind a proxy, set with `https_proxy` or `ALL_PROXY`, the proxy looks names up rather than curl, so Raindown only checks hosts written as IPs and leaves names to the proxy.

## Limits

The snippet runs with the `curl` binary but not through a shell, so pipes, redirects and `$VARIABLES` aren't supported, but [variables](#variables) are.

Curl is limited to HTTP requests, values can't read files (`-d @body.json`), and options like `-o`, `-F`, `-K` or `-L` are rejected. Raindown also runs curl without your `~/.curlrc`.
