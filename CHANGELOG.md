# Changelog

## Version 3.1.6

* Revert changes from 3.1.5 because of regression errors.

## Version 3.1.5

* Adds support for duplicating tags, e.g. setting `twitter:image` to the value of `og:image`. *(reverted in 3.1.6)*

## Version 3.1.4

* Fixes a bug where symbol-like strings inside meta tags would raise an exception.

## Version 3.1.3

* Shortcut helpers now return the value you send to them.

## Version 3.1.2

* Add HTML safety handling.

## Version 3.1.1

* Adds support for specifying templates on all tag types.
* Add `:separator` option for building meta titles.

## Version 3.1.0

* Adds title templates.

## Version 3.0.3

* Minor fix.

## Version 3.0.2

* Add relation links.

## Version 3.0.1

* Handle nil meta values.

## Version 3.0.0

* Rewritten to simplify Open Graph (Facebook), Twitter Cards, and custom tags.
  Some features are incompatible with 2.x but are easy to rewrite.
* Add shortcut helpers for easy setting of meta tags.