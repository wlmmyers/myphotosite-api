require "dotenv"
require "logger"
require 'rack'
require 'rack/parser'
require 'rack/protection'
require 'hobbit'
require 'rest-client'

Dotenv.load

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

require_relative "config/db"

DB.with_server(:default) do
  require_relative "config/server"

  # Load application files.
  Dir["./lib/ext/*.rb"].each           { |file| require file }
  Dir["./lib/**/*.rb"].each            { |file| require file }
  Dir["./presenters/**/*.rb"].each     { |file| require file }
  Dir["./models/**/*.rb"].each         { |file| require file }
  Dir["./routes/**/*.rb"].each         { |file| require file }
end

class Photosite < PhotositeServerBase
  map('/') { run API.new }
end

def development?
  ENV['RACK_ENV'] == 'development'
end

def test?
  ENV['RACK_ENV'] == 'test'
end

unless development? || test?
  NewRelic::Agent.manual_start
  NewRelic::Agent.after_fork(force_reconnect: true)
end
