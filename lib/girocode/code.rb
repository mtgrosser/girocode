module Girocode
  class Error < StandardError; end
  
  class Code
    ATTRIBUTES = %i[bic name iban currency amount purpose creditor_reference reference bto_info]
    attr_reader *ATTRIBUTES
    
    MAX_PAYLOAD_BYTES = 331
    AMOUNT_RANGE = BigDecimal('0.01')..BigDecimal('999999999.99')
    
    def initialize(**attrs)
      if keys = attrs.keys - ATTRIBUTES and not keys.empty?
        raise ArgumentError, "Illegal attributes #{keys.inspect}"
      end
      attrs.each { |attr, value| send("#{attr}=", value) }
      raise ArgumentError, "iban is required" unless iban?
      raise ArgumentError, "name is required" unless name?
      raise ArgumentError, 'currency is required for amount' if amount && !currency?
      raise ArgumentError, "either creditor reference or reference may be set" if creditor_reference? && reference?
      raise ArgumentError, "payload too long" if payload.bytesize > MAX_PAYLOAD_BYTES
    end
    
    def bic=(value)
      if value.nil?
        @bic = nil
      else
        bic = Bank::BIC.new(value)
        raise ArgumentError, "Invalid BIC #{value.inspect}" unless bic.valid?
        @bic = bic.to_s
      end
    end
    
    def name=(value)
      value = value.strip
      raise ArgumentError, 'name is required' unless value
      raise ArgumentError, 'name too long' if value.size > 70
      raise ArgumentError, 'Illegal name' if value.include?("\n") || value.include?("\r")
      @name = value
    end
    
    def iban=(value)
      iban = Bank::IBAN.new(value)
      raise ArgumentError, "Invalid IBAN #{value.inspect}" unless iban.valid?
      @iban = iban.to_s
    end
    
    def currency=(value)
      value = value.to_s.upcase
      raise ArgumentError, "Invalid currency" unless value.match?(/\A[A-Z]{3}\z/)
      @currency = value
    end
    
    def amount=(value)
      raise ArgumentError, 'amount is required' unless value
      value = BigDecimal(value, Float::DIG + 1)
      raise ArgumentError, "invalid amount #{value.inspect}" unless AMOUNT_RANGE.cover?(value)
      @amount = value
    end
    
    def purpose=(value)
      unless value.nil?
        raise ArgumentError, "invalid purpose #{value.inspect}" unless value.match?(/\A[A-z0-9]{0,4}\z/)
      end
      @purpose = value
    end
    
    def creditor_reference=(value)
      unless value.nil?
        raise ArgumentError, "invalid creditor reference #{value.inspect}" if value.include?("\n") || value.include?("\r") || value.size > 35
      end
      @creditor_reference = value
    end
    
    def reference=(value)
      unless value.nil?
        raise ArgumentError, "invalid reference #{value.inspect}" if value.include?("\n") || value.include?("\r") || value.size > 140
      end
      @reference = value
    end
    
    def bto_info=(value)
      unless value.nil?
        raise ArgumentError, "invalid bto_info #{value.inspect}" if value.include?("\n") || value.include?("\r") || value.size > 70
      end
      @bto_info = value
    end
    
    ATTRIBUTES.each do |attr|
      define_method("#{attr}?") do
        value = instance_variable_get("@#{attr}")
        value.respond_to?(:empty?) ? !value.empty? : !!value
      end
    end
    
    def payload
      ['BCD', '002', '1', 'SCT',
       bic, name, iban,formatted_amount, purpose,
       creditor_reference || reference, bto_info].map(&:to_s).join("\n")
    end
    
    def to_qrcode
      RQRCode::QRCode.new(payload, level: :m, mode: :byte_8bit)
    end
    
    def to_ascii
      to_qrcode.to_s
    end
    
    %i[png svg html ansi].each do |format|
      define_method("to_#{format}") { |*args| to_qrcode.public_send("as_#{format}", *args) }
    end
    
    private
    
    def formatted_amount
      "#{currency}#{amount.round(2).to_s('F')}" if currency? && amount
    end
  end
end
