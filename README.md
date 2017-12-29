## code-pages
A database of legacy Microsoft and ISO 8859 code pages for Ruby.

## Installation

`gem install code-pages`

or put it in your Gemfile:

```ruby
gem 'code-pages'
```

### What is this Thing?

Before the advent of the Unicode standard, Microsoft and other companies developed their own encoding systems to accommodate the world's many languages and writing systems. Like Unicode, each of these systems map a series of integers to characters. A group of these characters is called a code page, and a number of legacy systems still use them to represent text. Fortunately the Unicode Consortium maintains a set of data files mapping the characters used in each code page to their Unicode equivalents, making it possible to convert text from the various code page encodings to UTF-8.

### Usage

Individual code pages can be accessed directly via the `CodePages` constant:

```ruby
CodePages[37]  # => #<CodePages::CodePage:0x00007fcd1c374dd0 @id=37 ... >
```

Once you have a code page, a mapping of code page characters to Unicode characters can be obtained via the `#unicode_mapping` method:

```ruby
CodePages[37].unicode_mapping  # => { 0=>0, 1=>1, 2=>2, 3=>3, 4=>156, 5=>9, ... }
```

You can also convert text encoded with the code page to UTF-8 and vice-versa:

```ruby
CodePages[37].to_utf8('abc')    # => '/ÂÄ'
CodePages[37].from_utf8('/ÂÄ')  # => 'abc'
```

## Updating Code Pages

The library comes with a rake task for downloading and updating the code pages from the Unicode Consortium's website. Run `bundle exec rake import` to update. To add additional code pages, edit resources/code_page_manifest.yml and run the rake task.

## License

Licensed under the MIT license. See LICENSE for details.

## Authors

* Cameron C. Dutro: http://github.com/camertron
