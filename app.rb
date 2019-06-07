require_relative './main'
require 'sinatra'
require 'sinatra/activerecord'

  set :database, "sqlite3:project-name.sqlite3"
  set :server, "thin"
  set :logging, true
  
class App < Sinatra::Base
  get '/' do
    @friends = Friend.order('lastname, firstname')
     erb :friends, :locals => {:friends => @friends}
  end

  post '/add' do
     fr = Friend.new(params[:friend])
     words = fr.keywords.split(",")
     fr.keywords =words.map!{|w|w.strip}
     fr.save!
     redirect '/'
  end

  get '/add' do
     erb :add
  end

  get '/results' do
    @results = etsy_q
    erb :results, :locals => {:results => @results}
  end

  get '/recommendations/:id/:word' do
    @results = etsy_q({:tags=>params[:word]})
    erb :results, :locals => {:results => @results}
  end

  post '/results' do
    @results = etsy_q({:tags=>params[:search]})
    p params
    erb :results, :locals => {:results => @results}
  end

end

Dir.glob('./models/*.rb').each{|x| require x}