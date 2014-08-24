# Configuration

Gtdlint offers multiple ways to resolve preferences:

1. Command-line flags (`gtdlint -i`, `gtdlint -p`)
2. Dotfiles (`.gtdlintignore`, `.gtdlintrc.yml`)
3. Built-in defaults (`DEFAULT_IGNORES`, `DEFAULT_GTD_PATTERN`)

Any command-line flags that are present override the same settings in dotfiles and built-in defaults.

# Command-line flags

Run `gtdlint -h` or `gtdlint --help` for a full list, or refer to the source code for `bin/gtdlint`.

```
$ bin/gtdlint -h
Usage: gtdlint [options] [<files>|-]
    -i, --ignore pattern             Ignore file names matching Ruby regex pattern
    -p, --gtd-pattern pattern        Custom GTD pattern
    -h, --help                       Print usage info
    -v, --version                    Print version info
```

# Dotfiles

Gtdlint automatically applies any `.gtdlintignore` and/or `.gtdlintrc.yml` configuration files in the same directory as a file being scanned, or a parent directory (`../.gtdlintignore`, `../.gtdlintrc.yml`), up to `$HOME/.gtdlintignore`, `$HOME/.gtdlintrc.yml`, if any such files exist.

## `.gtdlintignore`

Samples:

* [examples/.gtdlintignore](https://github.com/mcandre/gtdlint/blob/master/examples/.gtdlintignore)

A `.gtdlintignore` may contain Ruby regex patterns of files and/or folders to exclude from scanning, one pattern per line.

## `.gtdlintrc.yml`

Samples:

* [spanish/.gtdlintrc.yml](https://github.com/mcandre/gtdlint/blob/master/examples/spanish/.gtdlintrc.yml)

`.gtdlintrc.yml` may contain a number of keys:

* `gtd_pattern` is a shell-quoted string for a `grep` pattern.
* `before_lines` is an optional integer for showing n lines before each matching line.
* `after_lines` is an optional integer for showing n lines after each matching line.

# Built-in defaults

* `gtd_pattern`: `"\'todo\\|to do\\|to-do\\|hack\'"`.
* `before_lines`: `0`
* `after_lines`: `0`
