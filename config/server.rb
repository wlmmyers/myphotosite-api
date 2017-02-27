require_relative '../lib/helpers/halt_helpers'
require_relative '../lib/helpers/encryption_helpers'

class PhotositeServerBase < Hobbit::Base
  include HaltHelpers
  include EncryptionHelpers

  def params
    @params ||= request.params.recursive_symbolize_keys!
  end
end
