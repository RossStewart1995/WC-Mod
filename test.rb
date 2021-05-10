ENV['APP_ENV'] = 'test'

require './server'
require 'test/unit'
require 'rack/test'
require 'json'

class ModFuncTest < Test::Unit::TestCase
    include Rack::Test::Methods

    def app
        Sinatra::Application
    end

    def test_it_mods_numbers
        get '/', :val => '302', :mod => '72'
        assert last_response.ok?
        data = {error: false, string: "302%72=14", author: "Ross Stewart", answer: 14}
        assert_equal data.to_json, last_response.body
    end

    def test_it_val_equals_zero
        get '/', :val => '0', :mod => '45'
        assert last_response.status = 400
        data = {error: true, string: "input for val is 0", author: "Ross Stewart"}
        assert_equal data.to_json, last_response.body
    end

    def test_it_mod_equals_zero
        get '/', :val => '45', :mod => '0'
        assert last_response.status = 400
        data = {error: true, string: "input for mod is 0", author: "Ross Stewart"}
        assert_equal data.to_json, last_response.body
    end

    def test_it_no_params
        get '/'
        assert last_response.status = 500
        data = {error: true, string: "both parameters missing", author: "Ross Stewart"}
        assert_equal data.to_json, last_response.body
    end


end
