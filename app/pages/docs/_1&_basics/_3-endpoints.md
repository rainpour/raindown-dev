---
title: Endpoints
published: true
---

<{ :toc }>

Put an `endpoint:` directive above a curl snippet and Raindown writes the response in a code block below it, typed by its content type, followed by the date it was fetched:

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
<!-- raindown:fetched 2026-10-14 -->
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

To refresh a response, empty its code block and run Raindown with `-x`, and its fetched date is updated too.

The date is an HTML comment, so it's hidden on the page, but anyone reading the file or the HTML source, people or agents, can tell how fresh the example is.

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

## Running files you trust

> [!WARNING]
> Be careful which files and folders you run Raindown on with `-x`. It runs every endpoint in the files it opens or watches, including files added to a watched folder later, so only use it on files you've read or trust, as you would before running `make` in a repo.

Requests go out from your machine, so a snippet can reach anything it can, like servers running on it at `localhost` and services on your private network. With [variables](#variables), it can also send your environment variables, like API keys, wherever its URL points.

Raindown guards against the worst of it:

- **Files can't run themselves.** Only `-x`, or running an endpoint in the terminal UI, sends requests. Reading a file, rendering it without `-x`, and the [VS Code preview](/docs/extensions) never do.
- **Cloud metadata is refused.** Link-local addresses (`169.254.0.0/16` and `fe80::/10`), like the cloud metadata service at `169.254.169.254` that can give out a server's credentials, are refused however they're written, like `2852039166` or `[::ffff:169.254.169.254]`.
- **Hosts are checked before they're requested.** Raindown looks up each host itself and pins curl to the address it checked, with `--resolve`, so a name can't point somewhere else by the time curl connects.
- **Redirects aren't followed.** `-L` is rejected, so a public URL can't redirect to an address that would be refused.

Behind a proxy, set with `https_proxy` or `ALL_PROXY`, the proxy looks names up rather than curl, so Raindown only checks hosts written as IPs and leaves names to the proxy.

## Limits

The snippet runs with the `curl` binary but not through a shell, so pipes, redirects and `$VARIABLES` aren't supported, but [variables](#variables) are.

Curl is limited to HTTP requests, values can't read files (`-d @body.json`), and options like `-o`, `-F`, `-K` or `-L` are rejected. Raindown also runs curl without your `~/.curlrc`.
