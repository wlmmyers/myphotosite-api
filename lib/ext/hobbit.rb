require_relative '../helpers/authorization_helpers'

# This API will only output json responses.
module Hobbit
  class Base
    def route_eval
      if route = find_route
        data = instance_eval(&route[:block])
        data = data.to_json(presenter_opts) unless data.is_a? String
        response.write data
      else
        response.status = 404
      end
      response.finish
    end

    def presenter_opts
      #params.merge(_current_user: current_user_object)
    end
  end

  class Response
    alias_method :_initialize, :initialize

    def initialize(body = [], status = 200, headers = {})
      headers['Content-Type'] = 'application/json; charset=utf-8'
      _initialize body, status, headers
    end
  end
end
