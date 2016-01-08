# gtdlint - search for TO-DO items to complete in large projects

`gtdlint` searches your projects for code comments indicating TODOs, FIXMEs, and other changes that need to be made.

# EXAMPLES

```
$ gtdlint examples/
examples/.gitignore:1:# TODO: gitignore bin/
examples/hello.c:1:// TODO: Add copyright
examples/hello.c:6:  // TODO: Add proper line ending
examples/hello.c:9:  putc(10, stdout); // hack
examples/spanish/phrases.txt:1:PTE: Agregar más frases.
examples/spec/int_spec.rb:3:    pending('mathematical revolution')

$ cat examples/hello.c | bin/gtdlint
stdin:1:// TODO: Add copyright
stdin:6:  // TODO: Add proper line ending
stdin:9:  putc(10, stdout); // hack

$ gtdlint -i .gitignore '*.c' examples/
examples/spanish/phrases.txt:1:PTE: Agregar más frases.
examples/spec/int_spec.rb:3:    pending('mathematical revolution')

$ gtdlint -p pte examples/spanish/
examples/spanish/phrases.txt:1:PTE: Agregar más frases.

$ gtdlint -h
Usage: gtdlint [options] [<files>|-]
    -i, --ignore pattern             Ignore file pattern (fnmatch)
    -p, --gtd-pattern pattern        Custom GTD pattern
    -B, --lines-before n             Also show n lines before matching line
    -A, --lines-after n              Also show n lines after matching line
    -h, --help                       Print usage info
    -v, --version                    Print version info
```

gtdlint can be combined with other programs. For example, check your most recent git commit for leftover TODOs:

```
$ git diff HEAD~1 | gtdlint
```

# HOMEPAGE

https://github.com/mcandre/gtdlint

# RUBYGEMS

https://rubygems.org/gems/gtdlint

# ABOUT

Gtdlint is a command line program for finding TODO tasks in a project, such as `// TODO` code comments. By default, gtdlint is case-insensitve, and looks for:

* `todo`
* `pending`
* `hack`

gtdlint can be customized with a `-p` command line flag and/or a `.gtdlintrc.yml` configuration file. For example, gtdlint can be configured to look for `pte`/`hack` in Spanish projects.

gtdlint is a shell wrapper around the traditional GNU [grep](http://www.gnu.org/software/grep/) backend, presenting a frontend similar to modern linters like [Reek](https://github.com/troessner/reek/wiki) and [JSHint](http://jshint.com/).

* Recursive file scanning, like `jshint .`
* Optional ignore patterns, like `.gitignore`
* Configuration via per-project and per-user [dotfiles](https://github.com/mcandre/gtdlint/blob/master/CONFIGURE.md#dotfiles)
* Install via a standard programming language package manager

# REQUIREMENTS

* [Ruby](https://www.ruby-lang.org/) 2.3+
* [grep](http://www.gnu.org/software/grep/) (often built-in, or provided by [git](http://git-scm.com/))

E.g., Windows users can `chocolatey install git`.

# INSTALL

Install via [RubyGems](http://rubygems.org/):

```
$ gem install gtdlint
```

# CONFIGURE

See [CONFIGURE.md](https://github.com/mcandre/gtdlint/blob/master/CONFIGURE.md) for details.

# LICENSE

FreeBSD

# DEVELOPMENT

## Testing

Keep the interface working:

```
$ cucumber
```

## Linting

Keep the code tidy:

```
$ rake lint
```

## Git Hooks

See `hooks/`.
