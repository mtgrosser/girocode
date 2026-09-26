## 1.2.0

- Reject SEPA purpose codes that sit between Z and a (@SashaMIT)

## 1.1.0

- Fix `reference` / `creditor_reference` confusion (@arfl)
- Fix adherence to spec, strip rightmost LF if last element empty

## 1.0.0

- Drop bank-contact, use iban-tools (@Joerg-Seitz)
- Inline BIC validation from bank-contact
- Support Ruby 3.4
