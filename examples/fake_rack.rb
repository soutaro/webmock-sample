require 'sinatra/base'

class FakeRack < Sinatra::Base
  post '/hello' do
    json_response 201, 'hello.json'
  end

  private

    def json_response(response_code, file_name)
      content_type :json
      status response_code
      File.open(File.dirname(__FILE__) + '/json/' + file_name, 'rb').read
    end
end
