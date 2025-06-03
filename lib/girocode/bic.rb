# derived from bank-contact/bic by Kevin

module Girocode
  class BIC
    REGEX = /\A([A-Z]{4})([A-Z]{2})([A-Z0-9]{2})([A-Z0-9]{3})?\z/.freeze
    
    def self.valid?(code)
      new(code).valid?
    end

    def initialize(code)
      @code = code.to_s.gsub(/\s+/, '').upcase
    end

    def bank_code
      @code[0..3]
    end

    def country_code
      @code[4..5]
    end

    def location_code
      @code[6..7]
    end

    def branch_code
      @code[8..10]
    end

    def to_s(formatted = false)
      formatted ? to_formatted_str : @code
    end
    
    def to_formatted_str
      "#{bank_code} #{country_code} #{location_code} #{branch_code}".strip
    end

    def test?
      location_code[1] == '0'
    end

    def passive?
      location_code[1] == '1'
    end

    def reverse_billing?
      location_code[1] == '2'
    end

    def valid?
      valid_format? && valid_location_code? && valid_branch_code?
    end

    def valid_format?
      REGEX.match?(@code)
    end

    def valid_location_code?
      !location_code.start_with?('0', '1') && !location_code.end_with?('O')
    end

    def valid_branch_code?
      branch_code.empty? || branch_code == 'XXX' || !branch_code.start_with?('X')
    end
  end
end
