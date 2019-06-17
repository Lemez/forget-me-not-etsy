require_relative ('./_scrape_stores')

def search_scrape(opts={:name=>nil, :word=>nil, :search=>false})

  shop = STORES[opts[:name]]
  p opts
  shop[:opts] = opts

  shop[:opts][:word]= shop[:standalone] ? "" : $word 
  shop[:url] = (shop[:opts][:word].nil? || shop[:opts][:word].empty?) ? shop[:base_url] : "#{shop[:base_url]}#{shop[:search_string]}#{shop[:opts][:word]}" 
  p shop[:url]
  
  shop[:results] = {:page=>1, :data=>[]}
  shop[:incomplete]=true

  case shop[:provider]
  when 'shopify'
    results = scrape_shopify(shop) # working for Pops & Ozzy
  when 'wordpress_ecwid'
    results = scrape_wordpress_ecwid(shop) #needs phantom headless :js (wait etc)
  when 'bigcartel'
    results = big_cartel_q(shop) # Anorak
  when 'wordpress_woocommerce'
    results = scrape_wordpress_woocommerce(shop) #Novalis
  when 'salesforce'
    results = scrape_salesforce(shop) #Tate
  when 'amazon'
    results = scrape_amazon(shop) #ZSL
  when 'magento'
    results = scrape_magento(shop) #Kew / V+A
  end
    
  # write_to(results, {:format=>'json'}) # or 'csv' or 'print'
  # results = opts[:options][:web] ? results : results.to_json
  results
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