# gtdlint - search for TO-DO items to complete in large projects

# HOMEPAGE

https://github.com/mcandre/gtdlint

# RUBYGEMS

https://rubygems.org/gems/gtdlint

# ABOUT

Gtdlint is a command line program for finding TODO tasks in a project, such as `// TODO` code comments. By default, gtdlint is case-insensitve, and looks for:

* `todo`
* `to do`
* `to-do`
* `TODO`
* `TO DO`
* `TO-DO`
* `ToDo`
* `To Do`
* `To-Do`
* `hack`
* `Hack`
* `HACK`
* ...

gtdlint can be customized with a `-p` command line flag and/or a `.gtdlintrc.yml` configuration file. For example, gtdlint can be configured to look for `pte`/`hack` in Spanish projects.

gtdlint is a shell wrapper around the traditional GNU [grep](http://www.gnu.org/software/grep/) backend, presenting a frontend similar to modern linters like [Reek](https://github.com/troessner/reek/wiki) and [JSHint](http://jshint.com/).

* Recursive file search by default
* Optional ignore patterns
* Configuration via per-project and per-user [dotfiles](https://github.com/mcandre/gtdlint/blob/master/CONFIGURE.md#dotfiles)
* Install via a standard programming language package manager

# EXAMPLES

```
$ gtdlint examples/
examples/hello.c:1:// TODO: Add copyright
examples/hello.c:6:  // TODO: Add proper line ending
examples/hello.c:9:  putc(10, stdout); // hack
examples/spanish/phrases.txt:1:PTE: Agregar más frases.

$ cat examples/hello.c | bin/gtdlint
stdin:1:// TODO: Add copyright
stdin:6:  // TODO: Add proper line ending
stdin:9:  putc(10, stdout); // hack

$ gtdlint -i .c examples/
examples/spanish/phrases.txt:1:PTE: Agregar más frases.

$ gtdlint -p pte examples/spanish/
examples/spanish/phrases.txt:1:PTE: Agregar más frases.

$ gtdlint -h
Usage: gtdlint [options] [<files>|-]
    -i, --ignore pattern             Ignore file names matching Ruby regex pattern
    -w, --max-width=                 Maximum column width, either an integer or "unlimited". Default: 80
    -h, --help                       Print usage info
    -v, --version                    Print version info
```

# REQUIREMENTS

* [Ruby](https://www.ruby-lang.org/) 2+
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
