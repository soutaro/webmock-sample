require 'bundler'
Bundler.require

require 'webmock'
require 'faraday'
include WebMock::API

WebMock.enable!

client = Faraday.new(url: 'http://www.example.com')

stub_request(:any, "www.example.com").to_return(
  body: 'success!',
  status: 200
)

res = client.get '/'
pp "status: #{res.status}, body: #{res.body}"
