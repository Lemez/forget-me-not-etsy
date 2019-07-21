require_relative ('./_scrape_stores')

def search_scrape(opts={:name=>nil, :word=>nil, :search=>false})

  shop = STORES[opts[:name]]
  $shop_css = CSS[shop[:identifier]]
  p opts

  shop[:opts] = opts

  shop[:opts][:word]= shop[:standalone] ? "" : $word 
  shop[:url] = (shop[:opts][:word].nil? || shop[:opts][:word].empty?) ? shop[:base_url] : "#{shop[:base_url]}#{shop[:search_string]}#{shop[:opts][:word]}" 

  shop[:results] = {:page=>1, :data=>[]}
  shop[:incomplete]=true

  case shop[:provider]
  when 'shopify'
    @shop = scrape_shopify(shop) # working for Pops & Ozzy
  when 'wordpress_ecwid'
    @shop = scrape_wordpress_ecwid(shop) #needs phantom headless :js (wait etc)
  when 'bigcartel'
    p 'bigcartel'
    @shop = big_cartel_q(shop) # Anorak
  when 'wordpress_woocommerce'
    @shop = scrape_wordpress_woocommerce(shop) #Novalis / Pushkin
  when 'salesforce'
    @shop = scrape_salesforce(shop) #Tate
  when 'amazon'
    @shop = scrape_amazon(shop) #ZSL
  when 'magento'
    @shop = scrape_magento(shop) #Kew / V+A
  when 'custom'
    @shop = scrape_custom(shop) #Ethical Kidz 
  end
  p @shop
    
  # write_to(results, {:format=>'json'}) # or 'csv' or 'print'
  # results = opts[:options][:web] ? results : results.to_json
  p "#{@shop[:results][:data].size} results found for #{@shop[:name]}"
  
  shop = clean_up_results(@shop)
  shop = add_categories_to(shop)
  shop[:results][:data]
end

def get_data_from_product(shop,product)
  data = {
    :has_description => false,
    :description => '',
    :shop => shop[:name],
    :soldout => false,
    :price => nil
  }

  case shop[:identifier]

  when "Pops And Ozzy"
    price = product.attributes[$shop_css[:price_css]].value.to_s
    data[:title]=product.attributes[$shop_css[:title_css]].value
    data[:price]="£" + price.slice(0..price.length-3) + "." + price.slice(-2..-1)
    data[:link]=shop[:base_url] + product.at($shop_css[:link_css]).attributes['href'].value[1..-1] #remove first '/'
    data[:image]='https://' + product.at($shop_css[:img_css]).attributes[$shop_css[:img_source]].value.split("?")[0].gsub!("//","")
    data[:description] = product.at($shop_css[:img_css]).attributes['alt'].value
    data[:has_description] = true
    data[:soldout] = product.css('div.so').any?

  when "V and A", "Kew"
    link= product.at($shop_css[:link_css])#[-1]
    linkalt= product.css($shop_css[:link_css])[0]
    pricediv = product.at($shop_css[:price_css])
    titlediv = product.at($shop_css[:title_css])
     
    # @problem='title'
    data[:title] = titlediv.nil? ?  link.attributes['title'].value : product.at($shop_css[:title_css]).text.strip         
    # @problem='price'
    data[:price] = pricediv.nil? ?  "N/A" : pricediv.text.strip
    # @problem='link'
    data[:link] =   link.attributes['href'].nil? ? linkalt.attributes['href'].value : link.attributes['href'].value  
    # @problem='image'
    data[:image] = product.at($shop_css[:img_css]).attributes[$shop_css[:img_source]].nil? ? link.attributes[$shop_css[:img_source]].value : product.at($shop_css[:img_css]).attributes[$shop_css[:img_source]].value      
    # @problem = ''

  when "Ethical Kidz"

    data[:description] = product.at($shop_css[:desc_css]).text,
    data[:has_description] = true

    title = product.at($shop_css[:title_css])
    data[:title] = title.text.strip
    data[:price] = product.at($shop_css[:price_css]).text.gsub("From",'').strip
    data[:link] = shop[:base_url] + title.attributes['href'].value
    data[:image] =shop[:base_url] + product.at($shop_css[:img_css]).attributes[$shop_css[:img_source]].value


  when "London Zoo" 
    link= product.at($shop_css[:link_css])
    img = product.at($shop_css[:img_css])
    price = product.at($shop_css[:price_css])
 
    data[:title]= img.attributes['title'].value
    data[:price] = price.text.strip
    data[:link] = shop[:link_base_url] + link.attributes['href'].value
    data[:image] = img.attributes['src'].value

  when "Novalia"

    data[:title] = product.at($shop_css[:title_css]).attributes['alt'].value
    data[:price] =  product.at($shop_css[:price_css]).text
    data[:link] = product.at($shop_css[:link_css]).attributes['href'].value
    data[:image] = JSON.parse(product.at($shop_css[:img_css]).attributes[$shop_css[:img_source]])['mobile']
   
  when "Anorak" 

    data[:title] = product['name']
    data[:price] = "£" + sprintf('%.2f',product['price']).to_s
    data[:link] =  shop[:link_base_url] + product['url']
    data[:image] = product['images'].first['url']
    data[:soldout] = product['options'].first['sold_out']
    data[:description] = product['description']
    data[:has_description] = true
    data[:categories] = product['categories'].map{|x|x['name']}
  when "Tate"
         
    prices = product.css($shop_css[:price_css])
    price_span = prices.size==1 ? prices : prices[0]
    href = product.at($shop_css[:link_css]).attributes['href'].value

    data[:title]= product.at($shop_css[:title_css]).text
    data[:price]= price_span.text.strip
    data[:link] = href.include?('https:') ? href : shop[:link_base_url] + href
    data[:image]= product.at($shop_css[:img_css]).attributes[$shop_css[:img_source]].value

  when "Pushkin Press"

    data[:link] = product.attributes['href'].value
    data[:image] = product.at($shop_css[:img_css]).attributes[$shop_css[:img_source]].value
    if product.at($shop_css[:title_css]).attributes.nil? 
      data[:title]=nil
    else
      data[:title], data[:author] = product.at($shop_css[:title_css]).attributes['alt'].value.split(" by ")
    end

  end


  data
end


def clean_up_results(shop)
  p "Clean up results: #{shop[:results][:data].size}"
    results = []
    arr = []
    if shop[:book] && shop[:identifier]!="Kew" #&& !shop[:opts][:web]
        p "starting"
        shop[:results][:data].each_with_index do |book,i|
          unless book[:link].include?('@')
              arr[i]=Thread.new { 
                page = Nokogiri::HTML(HTTParty.get(book[:link])) 

                case shop[:identifier] 
                when "Kew"
                  book = retrieve(book,page,[:description])
                when "Tate"
                  book = retrieve(book,page,[:author])
                when "Pushkin Press"
                  items = [:price,:description,:release_date]
                  items << :title if book[:title].nil?

                  book = retrieve(book,page,items)
                end
                results << book
                # p book
              }
          end
        end
        shop[:results][:data] = results
        p "joining"
        arr.each{|t|t.join}
        p "joined"
      end

      # shop[:results][:data].each{|x| ap x} unless shop[:opts][:web]
      # p shop[:results][:data]
      shop
end

def retrieve(book,page,keys=[])
  keys.each do |key|

    case key
    when :title
      book[:title] = page.at($shop_css[:title_css]).text.nil? ? page.at($shop_css[:secondary_title_css]).text.strip : page.at($shop_css[:title_css]).text.strip
    when :author
      p page.at($shop_css[:author_css])
      book[:author] = page.at($shop_css[:author_css]).text.split("By").last.strip
    when :price
      book[:price] = page.at($shop_css[:price_css]).text.strip
    when :description
      book[:description]=page.css($shop_css[:desc_css]).map(&:text).join(' ').strip
      book[:has_description] = !book[:description].empty?
    when :release_date
      if page.at('p.releasedate').nil?
        book[:available_now] = true
      else
        date = page.at('p.releasedate').text.downcase.gsub('released','').strip
        book[:release_date] = Date.parse(date)
        book[:available_now] = false
      end
    end
  end
  book

end

def add_categories_to(shop)

  p "Adding categories to #{shop[:name]}"
  arr = []
  shop[:results][:data].each_with_index do |book,i|
    puts "#{i}: #{book[:title]}"
    slug = book[:slug].nil? ? "" : book[:slug]

    # arr <<  Thread.new {
      book[:categories] =  [shop[:opts][:word], slug, shop[:main_keyword]] << book[:title].downcase.split(" ")
      book[:categories] = book[:categories].flatten.uniq.reject! { |s| s&.strip&.empty? }
   # }
 end

  # arr.each{|t|t.join}
  shop
end











def test_site_scrape(opts)
  opts[:test]=true
  site_scrape(opts)
end

def site_scrape(opts={:dom=>nil, :test=>false})

  Spidr.site(opts[:dom]) do |spider|
      spider.every_html_page do |page|
        puts "#{page.title}: #{page.url}"
          return if opts[:test]
      end
    
  end

end

def scrape(page)
  results = []
  results
end