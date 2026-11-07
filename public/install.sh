#!/bin/sh
# Installs or updates the standalone raindown binary on macOS and Linux, to ~/.local/bin, where the Obsidian plugin
# looks for it. Run it again to update:
#   curl -fsSL https://raindown.dev/install.sh | sh
# Everything's in main, so a download that's cut off runs nothing.
set -eu

RELEASES="${RAINDOWN_RELEASES:-https://github.com/rainpour/raindown/releases/latest/download}"
FOLDER="${RAINDOWN_FOLDER:-$HOME/.local/bin}"

fail() {
  echo "raindown: $1" >&2
  exit 1
}

system_name() {
  case "$(uname -s)" in
    Darwin) echo macos ;;
    Linux)
      if ldd --version 2>&1 | grep -qi musl; then echo linux-musl; else echo linux; fi
      ;;
    *) fail "there's no binary for $(uname -s). See https://raindown.dev/docs/install" ;;
  esac
}

cpu_name() {
  case "$(uname -m)" in
    x86_64 | amd64) echo x86_64 ;;
    arm64 | aarch64) echo arm64 ;;
    *) fail "there's no binary for $(uname -m). See https://raindown.dev/docs/install" ;;
  esac
}

sha256() {
  if command -v sha256sum > /dev/null; then
    sha256sum "$1" | cut -d ' ' -f 1
  else
    shasum -a 256 "$1" | cut -d ' ' -f 1
  fi
}

main() {
  command -v curl > /dev/null || fail 'curl is needed to download Raindown'
  name="raindown-$(system_name)-$(cpu_name)"
  temporary="$(mktemp -d "${TMPDIR:-/tmp}/raindown.XXXXXX")"
  trap 'rm -rf "$temporary"' EXIT

  echo "Downloading $name..."
  curl -fsSL -o "$temporary/SHA256SUMS" "$RELEASES/SHA256SUMS" || fail "couldn't download the checksums"
  curl -fsSL -o "$temporary/$name" "$RELEASES/$name" || fail "couldn't download $name"

  expected="$(grep " \*\{0,1\}$name\$" "$temporary/SHA256SUMS" | cut -d ' ' -f 1)"
  [ -n "$expected" ] || fail "the release doesn't list a checksum for $name"
  [ "$(sha256 "$temporary/$name")" = "$expected" ] || fail "$name didn't match its checksum, so it wasn't installed"

  # Moved into place in the same folder, so a running raindown is never written over.
  mkdir -p "$FOLDER"
  cp "$temporary/$name" "$FOLDER/.raindown.new"
  chmod 755 "$FOLDER/.raindown.new"
  mv "$FOLDER/.raindown.new" "$FOLDER/raindown"

  echo "Installed Raindown $("$FOLDER/raindown" --version) to $FOLDER/raindown"
  case ":$PATH:" in
    *":$FOLDER:"*) ;;
    *) echo "To run it from a terminal, add $FOLDER to your PATH. The Obsidian plugin finds it without that." ;;
  esac
}

main
