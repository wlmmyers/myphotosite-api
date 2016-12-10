require "sequel"
require_relative "../lib/helpers/encryption_helpers"

include EncryptionHelpers

Sequel.extension :inflector

Sequel::Model.plugin :json_serializer
Sequel::Model.plugin :timestamps
Sequel::Model.plugin :tactical_eager_loading
Sequel::Model.plugin :validation_helpers
Sequel::Model.plugin :association_dependencies
Sequel::Model.plugin :sharding

Sequel::Model.raise_on_save_failure = false

Sequel.default_timezone = :utc

Sequel.send(:remove_const, :DATABASES)
Sequel.send(:const_set, :DATABASES, [])

DB_CONNECT_PARAM = {
  adapter:  'mysql2',
  host:     ENV['API_DB_HOST'],
  database: ENV['API_DB_NAME'],
  user:     ENV['API_DB_USER'],
  password: ENV['API_DB_PASS'],
  servers:  {}
}

DB ||= Sequel.connect(DB_CONNECT_PARAM)

DB.extension :server_block
DB.extension :null_dataset
