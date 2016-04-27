# Geben Helm Projectile

[![MELPA](http://melpa.org/packages/geben-helm-projectile-badge.svg)](http://melpa.org/#/geben-helm-projectile)

This is a small plugin that allows opening of geben debug files using
the helm-projectile interface (much nicer than manually browsing to
the files).

## Installation
To install, clone the repository via:

```
cd ~/.emacs.d
git clone https://github.com/ahungry/geben-helm-projectile.git
```

Then, make sure to add the following to your ~/.emacs:

### Using require

```lisp
(add-to-list 'load-path "~/.emacs.d/geben-helm-projectile/")
(require 'geben-helm-projectile)
```

### Using geben-helm-projectile.el

During an interactive geben debug session, simply use:

```lisp
M-x geben-helm-projectile/open-file
```
to open the file prompt for the current repository.

## License
GPLv3
