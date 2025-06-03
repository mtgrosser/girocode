require 'bigdecimal'
require 'iban-tools'
require 'rqrcode'

require_relative 'girocode/version'
require_relative 'girocode/bic'
require_relative 'girocode/code'

module Girocode
  def self.new(**attrs)
    Girocode::Code.new(**attrs)
  end
end
