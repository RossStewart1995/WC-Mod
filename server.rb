#server.rb

require 'sinatra'
require 'json'
require 'sinatra/cross_origin'

set :bind, '0.0.0.0'
set :port, 6995

configure do
    enable :cross_origin
end

before do
    content_type :json
    response.headers['Access-Control-Allow-Origin'] = '*'
end

get '/' do 

    if params[:val].nil? and params[:mod].nil?
        halt 500, {
            error: true,
            string: "both parameters missing",
            author: "Ross Stewart"
            }.to_json
    end
    
    if params[:val].nil?
        halt 500, {
            error: true,
            string: "missing input for val",
            author: "Ross Stewart"
            }.to_json
    end

    if params[:mod].nil?
        halt 500, {
            error: true,
            string: "missing input for mod",
            author: "Ross Stewart"
            }.to_json
    end

    if params[:val] == '0' and params[:mod] == '0'
        halt 500, {
            error: true,
            string: "both parameters equal zero",
            author: "Ross Stewart"
            }.to_json
    end

    if params[:val] == '0'
        halt 500, {
            error: true,
            string: "input for val is 0",
            author: "Ross Stewart"
            }.to_json
    end
    
    if params[:mod] == '0'
        halt 500, {
            error: true,
            string: "input for mod is 0",
            author: "Ross Stewart"
            }.to_json
    end


    begin
    val = Integer(params[:val])
    mod = Integer(params[:mod])   
    rescue
        halt 500, {
            error: true,
            string: "invalid data type",
            author: "Ross Stewart"
            }.to_json
    end

    answer = val.remainder(mod)

    {
    error: false,
    string: val.to_s+"%"+mod.to_s+"="+answer.to_s,
    author: "Ross Stewart",
    answer: answer
    }.to_json
end