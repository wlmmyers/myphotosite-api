namespace :encryption do
  desc "Loads the needed environment"
  task :environment do
    require "dotenv"
    require_relative "../helpers/encryption_helpers"
    include EncryptionHelpers
    Dotenv.load
  end

  desc "Decrypt hex data using CRYPT_KEY (first 16 bytes is the IV)"
  task :decrypt => [:environment] do
    encrypted_data = ask "Encrypted data:"
    puts decrypt(encrypted_data)
  end

  desc "Encrypt something using CRYPT_KEY"
  task :encrypt => [:environment] do
    plaintext_data = ask "Plaintext data:"
    puts encrypt(plaintext_data)
  end
end

def ask(prompt)
  print "#{prompt} "
  $stdin.gets.chomp
end
