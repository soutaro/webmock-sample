require 'bundler'
Bundler.require

require 'webmock'
require 'faraday'
include WebMock::API

WebMock.enable!

client = Faraday.new(url: 'http://www.example.com')

stub_request(:post, "www.example.com").with(
  body: { message: 'Hello' }
).to_return(
  body: 'success!',
  status: 201
)

res = client.post '/', { message: 'Hello' }
pp "status: #{res.status}, body: #{res.body}"
