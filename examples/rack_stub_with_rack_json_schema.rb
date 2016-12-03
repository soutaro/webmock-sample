require 'bundler'
Bundler.require

require 'webmock'
require 'faraday'
require 'faraday_middleware'
require 'rack-json_schema'
include WebMock::API

WebMock.enable!

client = Faraday.new(url: 'http://www.example.com') do |conn|
           conn.request  :json
           conn.response :json
           conn.adapter  Faraday.default_adapter
         end

schema_file  = File.open(File.dirname(__FILE__) + '/json/schema.json', 'rb').read
local_schema = JSON.parse(schema_file)

mock_rack = Rack::Builder.new do
              use Rack::JsonSchema::Mock, schema: local_schema
              run ->(env) { [404, {}, ["Not Found"]] }
            end

stub_request(:any, /www.example.com/).to_rack(mock_rack)

res = client.get '/users'

pp "status: #{res.status}, body: #{res.body}"
