module Middleware
  class ITunesResultsParser < Faraday::Response::Middleware
    def on_complete(env)
      json = MultiJson.load(env[:body], symbolize_keys: true)
      env[:body] = {
          data: json[:results],
          errors: json[:errors],
          metadata: json[:metadata]
      }
    end
  end
end