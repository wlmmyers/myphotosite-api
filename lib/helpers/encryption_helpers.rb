require 'openssl'

module EncryptionHelpers

  private

  # Convert binary string to string of hex digits
  def hex(bin_string)
    bin_string.unpack('H*').first
  end

  # Convert string of hex digits to binary
  def bin(hex_string)
    [hex_string].pack('H*')
  end

  # data is a string, key is a string of hex digits (32 bytes == 256 bits)
  # Ex:
  #   data = "Hello world!"
  #   hex_key = "a8eb62640d5871eb3a68a0f12fa37646e358572517f5b556909ca4097ebb2058"
  #
  # We prepend the IV to the encrypted data
  def encrypt(data, hex_key = ENV['CRYPT_KEY'])
    cipher = OpenSSL::Cipher::AES.new(256, :CBC)
    cipher.encrypt
    iv = cipher.random_iv
    cipher.key = bin(hex_key)
    encrypted = cipher.update(data) + cipher.final
    hex(iv) + hex(encrypted)
  end

  # data is a string of hex digits, key is a string of hex digits (32 bytes == 256 bits)
  # Ex:
  #   data = "197bff0f97aa4cdbd22385a9f6cfd138299d418a059be5f74470fe647583efb6"
  #   hex_key = "a8eb62640d5871eb3a68a0f12fa37646e358572517f5b556909ca4097ebb2058"
  #
  # We assume the encrypted data includes a 16-byte IV
  def decrypt(data, hex_key = ENV['CRYPT_KEY'])
    return if data.empty?
    decipher = OpenSSL::Cipher::AES.new(256, :CBC)
    decipher.decrypt
    iv = bin(data[0..31])
    encrypted = bin(data[32..-1])
    decipher.key = bin(hex_key)
    decipher.iv = iv
    decipher.update(encrypted) + decipher.final
  end
end
