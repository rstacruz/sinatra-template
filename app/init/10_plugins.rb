require "rtopia"
require "jsfiles"
require "user_agent"

class Main
  helpers  Sinatra::ContentFor        # sinatra-content_for
  helpers  Sinatra::UserAgentHelpers  # agentsniff
  helpers  Rtopia
end
