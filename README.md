[![Gem Version](https://badge.fury.io/rb/girocode.svg)](http://badge.fury.io/rb/girocode) [![Build Status](https://travis-ci.org/mtgrosser/girocode.svg)](https://travis-ci.org/mtgrosser/girocode)
# Girocode - create EPC QR codes for SEPA bank transfers

Pure Ruby library to generate QR codes in SVG, PNG, HTML or ASCII format

![Girocode](https://raw.githubusercontent.com/mtgrosser/girocode/master/test/demo.png)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'girocode'
```

## Usage

```ruby
code = Girocode.new(iban: 'DE02100500000054540402',
                    name: 'Beispiel AG',
                    currency: 'EUR', amount: 123.45,
                    reference: 'RE 2019/05/445 744507')
code.to_svg
code.to_png
code.to_html
code.to_ascii

# in your console
puts code.to_ansi
```
