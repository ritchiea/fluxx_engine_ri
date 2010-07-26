# This file is used by Rack-based servers to start the application.
module Rack
  class FluxxBuilder
    def initialize app
      @app = app
    end
    def call env
      path = Utils.unescape(env["PATH_INFO"])
      if path.match('\.(css|js)$')
        `cd public/fluxx_engine && rake build`
      end
      @app.call env
    end
  end
end

use Rack::FluxxBuilder
require ::File.expand_path('../config/environment',  __FILE__)
run FluxxEngineRi::Application
