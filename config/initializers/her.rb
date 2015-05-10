require_relative '../../lib/middleware/itunes_results_parser'

Her::API.setup url: 'https://itunes.apple.com' do |c|
  # Request
  c.use Faraday::Request::UrlEncoded

  # Response
  c.use Middleware::ITunesResultsParser

  # Adapter
  c.use Faraday::Adapter::NetHttp
end