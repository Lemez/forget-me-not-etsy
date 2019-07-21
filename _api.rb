# Methods for ETSY / Wordery / BIG_CARTEL

# def oauth_big_cartel
#   client = OAuth2::Client.new('client_id', 'client_secret', :site => 'https://example.org')

#   client.auth_code.authorize_url(:redirect_uri => 'http://localhost:8080/oauth2/callback')
#   # => "https://example.org/oauth/authorization?response_type=code&client_id=client_id&redirect_uri=http://localhost:8080/oauth2/callback"

#   token = client.auth_code.get_token('authorization_code_value', :redirect_uri => 'http://localhost:8080/oauth2/callback', :headers => {'Authorization' => 'Basic some_password'})
#   response = token.get('/api/resource', :params => { 'query_foo' => 'bar' })
#   response
# end

def big_cartel_q(shop)
  
  shop[:url] = "https://api.bigcartel.com/#{shop[:domain]}/products.json"
  uri = URI.escape(shop[:url])
  response = HTTParty.get(uri)
  info = JSON.parse(response.body)

  info.each do |product|
  
      @data = get_data_from_product(shop,product)
      @data = add_categories_to(shop,@data)
      shop[:results][:data] << @data
      p @data
         
  end

  shop[:results][:data].flatten.uniq
  
end

def wordery_search(opts)
  p "Searching Wordery for #{opts[:title]}"

  $searching = true

  uri = URI.escape("https://www.googleapis.com/customsearch/v1?key=#{G_CUSTOM_SEARCH_APP_ID}&cx=#{G_CUSTOM_SEARCH_CSE_ID}&q=wordery #{opts[:author]} #{opts[:title]} ")
  response = HTTParty.get(uri)

  response

  #good response = "https://wordery.com/search?term=9781909263406"

  # result = {:link=>items[0]["link"]}
  
  # result
end

BASE_URL = "https://openapi.etsy.com/v2/listings/active?api_key=#{KEYSTRING}&limit=20&includes=Images:1&sort_on=price"


def init_etsy(opts)
  $tries = 0
  # begin
    results = etsy_q(opts)
    # if results.empty?
  results
end

def etsy_q(opts={:tags=>nil,
                  :book=>false,
                  :ignore_currency=>false,
                  :currency_code=>nil,
                  :ignore_location=>false,
                  :location_code=>nil,
                  :ignore_max_price=>false,
                  :max_price=>nil})

  p "Tries: #{$tries}"

  tags = opts[:tags].nil? ? "boy, t shirt,7,name" : opts[:tags]
  tag_params="&keywords=#{tags}"
  max_price= opts[:max_price].nil? ? "50" : opts[:max_price]
  max_price_params="&max_price=#{max_price}"

  place="GB"

  currency_code= opts[:currency_code].nil? ? "GBP" : opts[:currency_code] 
  currency_params="&currency_code=#{currency_code}"

  location_code= opts[:location_code].nil? ? "2635167" : opts[:location_code] 
  location_params="&location_code=#{location_code}"

  query = tag_params
  query += currency_params unless opts[:ignore_currency]
  query += location_params unless opts[:ignore_location]
  query += max_price_params unless opts[:ignore_max_price]

  fields="&fields=listing_id,title,tags,description,location,price,iso_country_code,before_conversion,currency_code,country,taxonomy_path,processing_min,processing_max,url"
  fields_to_save = %w(title description location)
 

  url = "#{BASE_URL}#{query}#{fields}"
  p url

  out = HTTParty.get(url)

  results= JSON.parse(out.body)

  parse_results(results,opts,fields_to_save)
end

def  parse_results(results,opts,fields_to_save)

  @returned_results = []

  if results.empty?
    $tries +=1
    case $tries
    when 1 
      opts[:ignore_location] = true
      opts[:ignore_currency] = true
    when 2
      opts[:ignore_location] = true
      opts[:ignore_currency] = true
      opts[:ignore_max_price] = true
    end
    p "Retrying: #{$tries}: #{opts}"
    etsy_q(opts)      
      
  else

  results['results'].each_with_index do |item,index|
    images ||=item[:images]
    proc_min ||=item[:processing_min]
    proc_max ||=item[:processing_max]
    price = item[:price]
    currency = item[:currency_code]
    listing = {
       :images=>images,
       :link=>item[:url],
       :from=>proc_min,
       :to=>proc_max,
       :price=>price,
       :currency=>currency,
       :shop=>'Etsy',
       :data=>{}
    }

      item.each_pair do |k,v|
        listing[:data][k]=v if fields_to_save.include?(k)
      end
      @returned_results << listing

    end
  end
  # p returned_results
   @returned_results
end