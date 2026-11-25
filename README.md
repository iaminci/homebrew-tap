# iaminci/homebrew-tap

Homebrew formulae for [Opsly MD](https://github.com/iaminci/opsly-md) tools.

## Install

```bash
brew install iaminci/tap/opslymd
```

Or tap first, then install by name:

```bash
brew tap iaminci/tap
brew install opslymd
```

## Formulae

| Formula | Description |
|---------|-------------|
| `opslymd` | Render Markdown in the terminal, like `cat` but formatted ([source](https://github.com/iaminci/opslymd-cli)) |

## Releasing a new version

After tagging `vX.Y.Z` in `opslymd-cli`:

```bash
brew bump-formula-pr --no-fork --write-only --url https://github.com/iaminci/opslymd-cli/archive/refs/tags/vX.Y.Z.tar.gz iaminci/tap/opslymd
```

or edit `url` and `sha256` in `Formula/opslymd.rb` by hand, then commit and push.
