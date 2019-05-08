# Girocode

Create QR codes for SEPA bank transfers.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'girocode'
```

## Usage

```ruby
code = Girocode.new(iban: 'DE02100500000054540402', name: 'Beispiel AG', currency: 'EUR', amount: 123.45, reference: 'RE 2019/05/445 744507')

code.to_svg
code.to_png
code.to_html

# in your console
puts code.to_ansi
```
