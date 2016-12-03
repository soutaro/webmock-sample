require 'bundler'
Bundler.require

require 'webmock'
require 'faraday'
require 'faraday_middleware'
require_relative 'fake_rack'
include WebMock::API

WebMock.enable!

client = Faraday.new(url: 'http://www.example.com') do |conn|
           conn.request  :json
           conn.response :json
           conn.adapter  Faraday.default_adapter
         end

stub_request(:any, /www.example.com/).to_rack(FakeRack)

res = client.post '/hello'

pp "status: #{res.status}, body: #{res.body}"
