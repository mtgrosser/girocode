require_relative 'test_helper'

class GirocodeTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Girocode::VERSION
  end

  def test_girocode
    attrs = { bic: 'BHBLDEHHXXX', name: 'Franz Mustermänn', iban: 'DE71110220330123456789', currency: :eur, amount: 12.3, purpose: 'GDDS', creditor_reference: 'RF18539007547034' }
    code = Girocode.new(attrs)
    assert_equal data(:data), code.to_ascii
  end
  
  private
  
  def data(name)
    Pathname(__dir__).join("#{name}.txt").read
  end
end
