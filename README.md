[![Gem Version](https://badge.fury.io/rb/girocode.svg)](http://badge.fury.io/rb/girocode) [![build](https://github.com/mtgrosser/girocode/actions/workflows/build.yml/badge.svg)](https://github.com/mtgrosser/girocode/actions/workflows/build.yml)
# Girocode - create EPC QR codes for SEPA bank transfers

Pure Ruby library to generate EPC QR codes in SVG, PNG, HTML or ASCII format

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

## Supported attributes

Codes can be generated with the following attributes:

| Attribute            | Description                           | required           | exclusive | max size |
|----------------------|---------------------------------------|--------------------|-----------|----------|
| `bic`                | Bank Identifier Code                  |                    |           | 11       |
| `name`               | Name of beneficiary                   | ✓                  |           | 70       |
| `iban`               | IBAN                                  | ✓                  |           | 34       |
| `currency`           | ISO-4217 currency code                | if `amount` given  |           | 3        |
| `amount`             | Money amount                          |                    |           | 12       |
| `purpose`            | SEPA purpose code                     |                    |           | 4        |
| `creditor_reference` | ISO-11649 creditor reference          |                    | ✓         | 35       |
| `reference`          | Unstructured reference ("remittance") |                    | ✓         | 140      |
| `bto_info`           | Beneficiary to originator info        |                    |           | 70       |

## QR code generation options

All `to_<format>` methods forward options to `RQRCode`. You can therefore supply all supported options to the respective generator, e.g.

```ruby
code.to_svg(fill: :white, color: :blue, module_size: 20)
```

Check the [RQRCode docs](https://github.com/whomwah/rqrcode) for all available options.

## Limitations

Codes are generated as EPC-QR Version 2 in UTF-8 format only.

## Specification

European Payments Council: Quick Response Code

[Guidelines to enable data capture for the initiation of a SEPA credit transfer](https://www.europeanpaymentscouncil.eu/sites/default/files/kb/file/2024-03/EPC069-12%20v3.1%20Quick%20Response%20Code%20-%20Guidelines%20to%20Enable%20the%20Data%20Capture%20for%20the%20Initiation%20of%20an%20SCT.pdf)
