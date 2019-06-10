require_relative ('./_scrape_stores')

def search_scrape(opts={:name=>nil})

  shop = STORES[opts[:name]]
  shop[:word]=opts[:word]
  shop[:url] = "#{shop[:base_url]}#{shop[:search_string]}#{shop[:word]}"
  shop[:results] = {:page=>1, :data=>[]}
  shop[:incomplete]=true

  if shop[:provider]=='shopify'
    results = scrape_shopify(shop) # working for Pops & Ozzy
  elsif shop[:provider]=='wordpress_ecwid'
    results = scrape_wordpress_ecwid(shop)
  elsif shop[:provider]=='bigcartel'
    results = big_cartel_q(shop)
  end
    
  print_scrape_results(results)

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