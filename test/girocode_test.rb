require_relative 'test_helper'

class GirocodeTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil Girocode::VERSION
  end

  def test_girocode
    attrs = { bic: 'BHBLDEHHXXX', name: 'Franz Mustermänn', iban: 'DE71110220330123456789', currency: :eur, amount: 12.3, purpose: 'GDDS', creditor_reference: 'RF18539007547034' }
    code = Girocode.new(**attrs)
    spec = "BCD\n002\n1\nSCT\nBHBLDEHHXXX\nFranz Musterm\xC3\xA4nn\nDE71110220330123456789\nEUR12.3\nGDDS\nRF18539007547034"
    assert_equal spec, code.payload
  end

  def test_bic
    assert_raises ArgumentError do
      Girocode.new(bic: 'FOOBAR', name: 'Franz Mustermänn', iban: 'DE71110220330123456789', currency: :eur, amount: 12.3, purpose: 'GDDS', creditor_reference: 'RF18539007547034')
    end
  end

  def test_epc_v2
    code = Girocode.new(name: "François D'Alsace S.A.", iban: 'FR1420041010050500013M02606', currency: :eur, amount: 12.3, reference: 'Client:Marie Louise La Lune')
    spec = "BCD\n002\n1\nSCT\n\nFrançois D'Alsace S.A.\nFR1420041010050500013M02606\nEUR12.3\n\n\nClient:Marie Louise La Lune"
    assert_equal spec, code.payload
  end

  def test_only_one_reference
    assert_raises ArgumentError do
      Girocode.new(name: "François D'Alsace S.A.", iban: 'FR1420041010050500013M02606', currency: :eur, amount: 12.3, reference: 'Client:Marie Louise La Lune', creditor_reference: 'RF18539007547034')
    end
  end

end
