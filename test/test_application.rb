require_relative 'test_helper'

class TestApp < Knoxframeworx::Application
end

class KnoxframeworxTest < Test::Unit::TestCase
  include Rack::Test::Methods
  
  def app
    TestApp.new
  end
  
  def test_request
    get '/'

    assert last_response.ok?
    body = last_response.body
    assert body["The Visual Page?"]
  end
  
end