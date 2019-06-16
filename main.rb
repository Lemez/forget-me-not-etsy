require_relative './secret'
require_relative './_api'
require_relative './_file'
require_relative './_scrape'
require_relative './_sources'
require 'httparty'
require 'excon'
require 'open-uri'
require 'capybara'
require 'capybara/poltergeist'
require 'capybara/dsl'
require 'json'
require 'nokogiri'
require 'oauth2'
require 'spidr'
require 'upton'
require "awesome_print"
require 'csv'
# require 'deviner'

include Capybara::DSL
Capybara.default_driver = :poltergeist
Capybara.default_selector = :css

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, {:js_errors=>false
    # ,:debug => true
    })
end

Capybara.ignore_hidden_elements = true

def main
  # site_scrape({:dom=>'https://secondrundvd.ecwid.com/#!/c/0/'})
  
  # name = "Pops & Ozzy"
  # name = "Anorak"
  # name = "Novalia"
  # name = 'Tate Gifts'
  # name = 'Tate Books'
  # name = 'Tate Homeware'
  name = 'Tate'


  shop = STORES[name]

  if shop[:searchable]
    shop[:keywords].each do |word|
      search_scrape({:name=>name,:word=>word})
    end
  else
    search_scrape({:name=>name,:word=>""})
  end


end

def query(opts={:shop=>nil, :tags=>nil, :web=>true})

  name = opts[:shop]
  word = opts[:tags].nil? ? "" : opts[:tags]

  if name=='Etsy'
    @data = init_etsy(opts) 
  else
    @data = search_scrape({:name=>name,:word=>word,:web=>opts[:web]})
  end

  @data
end


def test_pushkin
  number_of_lists = 1
  list_of_books = get_list_of_appropriate_books(number_of_lists).flatten

  number_of_books = 0 #all
  books_to_search = list_of_books[0..(number_of_books-1)]

  books_to_search.each do |book| 
    get_pushkin_press(book) 
  end
end

def get_pushkin_press(book)
  File.readlines('./lib/books/pushkin.txt').each do |url|
    begin
      page = Nokogiri::HTML(open(url.strip)) 
      if page.css('button').select{ |button| button.attributes.include?('name') }.empty?
        puts "#"
        next
      end

      page.css('button').select{ |button| button.attributes.include?('name') }.each do |button|
        if button.content.include?("Buy")
          File.open('./lib/books/pushkin-live.txt', 'a+') {|f| f.puts(url.strip)}
          puts url.strip
        end
      end
  rescue RuntimeError => e
    p e
    next
  end

  end  
end
   
 

def tests
  jsons=[]
  number_of_lists = 10
  list_of_books = get_list_of_appropriate_books(number_of_lists).flatten

  number_of_books = 0 #all
  books_to_search = list_of_books[0..(number_of_books-1)]

  books_to_search.each do |book| 
    opts = opts={:title=>book['title'], :author=>book['author']}

    begin
      response = wordery_search (opts)
      result = parseJson response.body, opts
     
    rescue SocketError #offline
      p 'offline'
      parseJson File.read('./lib/books/offline_wordery_full.json'), opts
    rescue NoMethodError => e
      p "error: #{e}"
    ensure
      # write

    end

  end

  # write_to_json_for_offline_reading(jsons)
  
end

# def replace_jsons
#     File.open('./lib/books/offline_wordery_full_2.json', 'a+') do |good|
#       File.open('./lib/books/offline_wordery_full.json', 'r') do |bad|
#         good.puts(bad.class)
#       end
#     end
#   end

def get_list_of_appropriate_books(num)
  results = []
  File.readlines('./lib/books/lists_with_books_full_updated.json')[0..(num-1)].each_with_index do |line,index|
    
  results << JSON.parse(line)["books"]
  end
  results
end

def parseJson d, opts

  @results = {}
  data = JSON.parse(d).gsub('/','')
  p data[0]
  items = data['items']
  $found = false

  items.each do |i|
  
    unless i['pagemap']['book'].nil?
      i['pagemap']['book'].each do |b|

        unless b['name'].nil?
          bookname = b['name'].downcase.gsub(/[^0-9a-z ]/i, '')
          titlename = opts[:title].downcase.gsub(/[^0-9a-z ]/i, '')

          if bookname==titlename && !$found #check this
            @results["isbn"]=b["isbn"]
            @results['link']="http://wordery.com/search?term=#{@results["isbn"]}"
            @results["cse_image"] = i['pagemap']['cse_image']
            @results['title']=opts[:title]
            @results['author']=opts[:author]
            $found = true
          else
            # p "#{b['name'].length} and #{opts[:title].length}: #{b['name']} is not #{opts[:title]}"
          end

        end 
      end
    end
      
  end

  @results

  
end

def write_to_json_for_offline_reading (result)
  File.open('./lib/books/offline_wordery_full.json', 'a+') do |f|
    f.puts (result.to_json)
  end
end




 

def books_update (opts={:girl=>false,:age=>7,:kid=>true,:tags=> nil,:book=>true} ) 
  @@true = 0
  @@false = 0
  IO.foreach('./lib/books/lists_with_books_full.rb') do |line|
    list = JSON.parse(line)
    new_book_array = []

    list['books'].each do |book|
      new_book = book.dup

      title = new_book['title'].gsub("'","").scan /[[:alnum:]]+/ 
      hyphenated = title.map(&:downcase).join("-")
      firstletter = hyphenated[0]
      new_book ['url']= URI.escape("https://www.booktrust.org.uk/book/#{firstletter}/#{hyphenated}")
      new_book ['img']= URI.escape("https://www.booktrust.org.uk/globalassets/images/book-jackets/#{firstletter}/#{hyphenated}.jpg")

      status = Excon.get(new_book['img']).status
   
      if status !=200
       new_book = get_updated_image(new_book)
     else
      new_book['valid']=true
      @@true += 1 
      end

      puts "#{new_book['valid']}: #{new_book['url']}"

      new_book_array << new_book
  
   end

   list['books'] = new_book_array

   File.open('./lib/books/lists_with_books_full_updated.json', 'a+') do |file|
    file.puts(list.to_json)
  end

   print "T: #{@@true}, F: #{@@false}"
   # T: 1724, F: 595JW
    
  end
end

def get_updated_image(new_book)
  begin
    visit(new_book['url'])
    img = page.find('div.bookdetail-cover picture source')[:srcset]
    new_book['img'] = "https://www.booktrust.org.uk#{img}"
    new_book['valid'] = true
  rescue
    new_book['valid'] = false
    @@false += 1 
  ensure
    return new_book
  end
end

