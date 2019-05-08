require 'bigdecimal'
require 'bank/contact'
require 'rqrcode'

require_relative 'girocode/version'
require_relative 'girocode/code'

module Girocode
  def self.new(**attrs)
    Girocode::Code.new(**attrs)
  end
end
