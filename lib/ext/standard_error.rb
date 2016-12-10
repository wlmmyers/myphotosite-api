class StandardError < Exception
  def self.key(symbol)
    @error_key = symbol
  end

  def self.message(message)
    @error_message = message
  end

  def self.error_key
    @error_key
  end

  def self.error_message
    @error_message
  end

  def error_key
    self.class.error_key
  end

  def message
    @error_message || super
  end
end
