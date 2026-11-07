---
title: Install
published: true
---

Raindown is a small program that runs on your computer. Copy the command for your computer, paste it into a terminal, and press Return. It takes about a minute, and running it again updates Raindown.

<div class="install-systems">
<section class="install-system" data-system="unix">

## macOS and Linux

Open **Terminal**, which you can find by pressing Cmd+Space on a Mac and typing `Terminal`, then run:

```sh
curl -fsSL https://raindown.dev/install.sh | sh
```

This puts Raindown in `~/.local/bin`, after checking the download against the release's checksums.

</section>
<section class="install-system" data-system="windows">

## Windows

Open **PowerShell**, which you can find by pressing the Windows key and typing `PowerShell`, then run:

```powershell
irm https://raindown.dev/install.ps1 | iex
```

This puts Raindown in `%LOCALAPPDATA%\Programs\raindown`, after checking the download against the release's checksums, and adds it to your `PATH`. To update it, close Obsidian first, as Windows can't replace a program that's running.

</section>
</div>

## Next

- **In Obsidian**, select **Check again**, or run **Raindown: Find Raindown** from the command palette.
- **In a terminal**, run `raindown` in a folder of Markdown files. See the [CLI](/docs/cli).

## Other ways to install

Read the scripts first if you like: [install.sh](/install.sh) and [install.ps1](/install.ps1). You can also [download a binary yourself, or install the gem](/docs/cli#installation).
