# homebrew-filetrace

Homebrew formulae for [Filetrace](https://github.com/OrlovEvgeny/filetrace),
which shows which files a machine sends over the network, and where they go.

## Install

```sh
brew install orlovevgeny/filetrace/filetrace
brew upgrade filetrace
```

Name the formula in full the first time. Homebrew loads formulae from a
third-party tap only once they are trusted, and installing one by its full
name trusts it; `brew trust orlovevgeny/filetrace` trusts the whole tap.

## What gets installed

The formulae install the archives of a release:

- `filetrace`, the command-line interface, and `filetrace-agent`, linked into
  Homebrew's `bin`;
- the readme, the license and the third-party notices, in
  `share/doc/filetrace`.

| Platform | Notes |
|---|---|
| macOS 15 or later, Apple silicon and Intel | macOS has no collection backend yet: the command reports diagnostics there, and collection needs Linux. |
| Linux, x86-64 and arm64 | Static binaries. The agent needs root and is not registered as a service; the [deb, rpm and apk packages](https://github.com/OrlovEvgeny/filetrace#install) install one that starts at boot. |

## Versions and lines

A Filetrace version reads `year.month.patch.build`, as in `26.11.2.3`. Its
first two numbers name the line, cut from `master` in that month; a line
then receives patches.

| Formula | Follows |
|---|---|
| `filetrace` | the newest stable or lts release |
| `filetrace@<line>`, such as `filetrace@26.11` | the releases of that line |

The command and the agent refuse to talk when their protocol versions differ,
so a command that reads agents kept on an older line belongs on that line:

```sh
brew install orlovevgeny/filetrace/filetrace@26.11
```

A line formula is keg-only, so it can sit beside `filetrace`. Put
`$(brew --prefix filetrace@26.11)/bin` first in `PATH`, or, without
`filetrace` installed, run `brew link filetrace@26.11`.

Release candidates (`-prestable`) are not published here; they are on the
[releases page](https://github.com/OrlovEvgeny/filetrace/releases).

## How the formulae are written

The `Release` workflow of Filetrace writes every formula here with
[`tools/release/formula.sh`](https://github.com/OrlovEvgeny/filetrace/blob/master/tools/release/formula.sh),
so a change made by hand lasts until the next release. Each stable or lts
release rewrites `Formula/filetrace@<line>.rb`, and `Formula/filetrace.rb`
when it is the newest release; a patch of an older line leaves `filetrace`
where it is. The archives are downloaded from
`https://filetrace.eorlov.org/dist/<tag>/` and checked against the
`SHA256SUMS` of the release.

The `Formulae` workflow of this repository runs `brew style`, `brew audit`,
`brew install` and `brew test` on every formula a commit changes, on macOS
(Apple silicon and Intel) and on Linux (x86-64).

Problems with a formula belong in the
[Filetrace issues](https://github.com/OrlovEvgeny/filetrace/issues).
