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
    results = scrape_shopify(shop) # working for Pops & Ozzy
  when 'wordpress_ecwid'
    results = scrape_wordpress_ecwid(shop) #needs phantom headless :js (wait etc)
  when 'bigcartel'
    p 'bigcartel'
    results = big_cartel_q(shop) # Anorak
  when 'wordpress_woocommerce'
    results = scrape_wordpress_woocommerce(shop) #Novalis
  when 'salesforce'
    results = scrape_salesforce(shop) #Tate
  when 'amazon'
    results = scrape_amazon(shop) #ZSL
  when 'magento'
    results = scrape_magento(shop) #Kew / V+A
  when 'custom'
    results = scrape_custom(shop) #Ethical Kidz
  end
    
  # write_to(results, {:format=>'json'}) # or 'csv' or 'print'
  # results = opts[:options][:web] ? results : results.to_json
  results.uniq
end

def get_data_from_product(shop,product)
  data = {
    :has_description => false,
    :description => '',
    :shop => shop[:name],
    :soldout => false
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
    link= product.css($shop_css[:link_css])[-1]
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

  end

  data
end

def add_categories_to(shop,d)
  d[:categories] =  [shop[:opts][:word], shop[:main_keyword]] << d[:title].downcase.split(" ")
  d[:categories] = d[:categories].flatten.uniq.reject! { |s| s&.strip&.empty? }
  d
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