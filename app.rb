require_relative './main'
require 'sinatra'
require 'sinatra/activerecord'

  set :database_file, "config/database.yml"
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
     

    @results = query(opts={:shop=>params[:shop], :web=>true, :tags => params[:q], :by_item=>params[:by_item]})
    @current = params[:shop] 
    @total = @results.size

    # p @results.first if not @results.nil?

    @shops = params[:by_item] ? @results.map{|x|x[:shop]}.uniq : []
    @searchbar = params[:by_item] ? false : true

    erb :results, :locals => {:results => @results}
  end

  get '/recommendations/:id/:word' do
    @searchbar = true 
    keyword = params[:word]
    # if Friend.find_by(id:params[:id]).age <= 18
    #   keyword= params[:word] + ' funny'
    #   p ":Under 18"

    # else
    #   keyword= params[:word] +' independent'
    #   p ":Older than 18"
    # end
    @results = init_etsy({:tags=>keyword})
    erb :results, :locals => {:results => @results}
  end

  post '/results' do
    p params
    @searchbar = true 
    @results = query(opts={:tags=>params[:search], :shop=>params[:shop], :web=>true, :search=>true})
    @current = params[:shop] 
    @total = @results.size
    
    erb :results, :locals => {:results => @results}
  end

end

Dir.glob('./models/*.rb').each{|x| require x}