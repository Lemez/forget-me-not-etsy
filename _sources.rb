FILMS = {:api=>false, :provider=> 'wordpress_ecwid',:saved=>false,:name => "Second Run"}
BOOKS = {:api=>false, :provider=> 'wordpress', :saved=>false,:name => "Pushkin Press"}
TSHIRTS = {:api=>true, :saved=>false,:name => "Etsy"}
CRAFT = {:api=>false, :saved=>false,:name => "Folksy"}
POSTERS = {:api=>false, :saved=>false,:name => "Tate"}
ELECTRONIC = {:api=>false, :provider=> 'wordpress_woocommerce',:saved=>false,:name=>"Novalia",:url=>"http://www.novalia.co.uk/contact-3-copy/?orderby=date"}

# Big Cartel has an api
KIDS = [
  # {:name => "Kawaii Doodles Club", :url => 'http://kawaiidoodles.club/', :keywords => ['badge', 't-shirt', 'kids']},
]

SHOP_PROVIDERS=%w(wordpress_woocommerce wordpress_ecwid shopify bigcartel salesforce)

STORES = {
  "Novalia" =>       {:age=>13..99,
                    :provider=>'wordpress_woocommerce',
                    :name => "Novalia",
                    :book => false,
                    :main_keyword => 'technology',
                    :base_url => "http://www.novalia.co.uk/contact-3-copy/",
                    :link_base_url=> "http://www.novalia.co.uk/product/",
                    :keywords => %w(electronics poster instrument technology science musician),
                    :search_string =>"",
                    :results_size_string => nil,
                    :results_size=> 10,
                    :page_string =>"page/", #only 2
                    :searchable => false,
                    :js=>false,
                    :api=> false
   
  },
    
  "Pops & Ozzy"=>  {:age=>0..12,
                    :provider=>'shopify',
                    :book => false,
                    :name => "Pops & Ozzy",
                    :main_keyword => 'kids',
                    :base_url => 'https://popsandozzy.com/',
                    :keywords => ['tattoo', 'shirt', 'clothes', 'kids', 'book', 'toy', 'baby'],
                    :searchable => true,
                    :search_string =>"search?q=",
                    :page_string =>"&page=",
                    :divider=>'+',
                    :js=>false,
                    :api=> false
  },

      "Anorak"=>  {:age=>6..12,
                  :provider=>'bigcartel',
                  :book => false,
                  :name => "Anorak",
                  :main_keyword => 'kids',
                  :domain => 'squarepegsstudiosocial',
                  :base_url => 'https://anorakmagazine.com/collections/all',
                  :link_base_url => 'https://squarepegsstudiosocial.bigcartel.com',
                  :keywords => ['magazine', 'design', 'kids', 'book'],
                  :searchable => false,
                  :search_string =>nil,
                  :divider=>nil,
                  :js=>false,
                  :api=> true
  },
      "Tate Books" =>       {:age=>0..99,
                    :provider=>'salesforce',
                    :name => "Tate Books",
                    :book => true,
                    :main_keyword => 'book',
                    :base_url => "https://shop.tate.org.uk/books/view-all-books",
                    :link_base_url=> "https://shop.tate.org.uk",
                    :search_base_url=> "https://shop.tate.org.uk/search?q=",
                    :keywords => %w(print poster art exhibition kids clothes card cushion shirt gifts homeware books),
                    :search_string =>"search?q=",
                    :results_size_string => "sz=",
                    :results_size=> 100,
                    :min_price_string=>'pmin',
                    :max_price_string=>'pmax',
                    :price_format=>  "%0.02f", #sprintf( "%0.02f", 123.4564564)
                    :page_string =>"&start=", #any multiple of 100
                    :searchable => false,
                    :js=>false,
                    :api=> false
   
  },
      "Tate Gifts" =>       {:age=>0..99,
                    :provider=>'salesforce',
                    :book => false,
                    :main_keyword => 'gift',
                    :name => "Tate Gifts",
                    :base_url => "https://shop.tate.org.uk/gifts/view-all-gifts",
                    :link_base_url=> "https://shop.tate.org.uk",
                    :search_base_url=> "https://shop.tate.org.uk/search?q=",
                    :keywords => %w(print poster art exhibition kids clothes card cushion shirt books homeware),
                    :search_string =>"search?q=",
                    :results_size_string => "sz=",
                    :results_size=> 100,
                    :min_price_string=>'pmin',
                    :max_price_string=>'pmax',
                    :price_format=>  "%0.02f", #sprintf( "%0.02f", 123.4564564)
                    :page_string =>"&start=", #any multiple of 100
                    :searchable => false,
                    :js=>false,
                    :api=> false
   
  },
      "Tate Homeware" =>       {:age=>0..99,
                    :provider=>'salesforce',
                    :book => false,
                    :name => "Tate Homeware",
                    :main_keyword => 'homeware',
                    :base_url => "https://shop.tate.org.uk/homeware/view-all-homeware",
                    :link_base_url=> "https://shop.tate.org.uk",
                    :search_base_url=> "https://shop.tate.org.uk/search?q=",
                    :keywords => %w(print poster art exhibition kids clothes card cushion shirt gifts),
                    :search_string =>"search?q=",
                    :results_size_string => "sz=",
                    :results_size=> 100,
                    :min_price_string=>'pmin',
                    :max_price_string=>'pmax',
                    :price_format=>  "%0.02f", #sprintf( "%0.02f", 123.4564564)
                    :page_string =>"&start=", #any multiple of 100
                    :searchable => false,
                    :js=>false,
                    :api=> false
   
  },
  "Tate" =>       {:age=>0..99,
                    :provider=>'salesforce',
                    :book => false,
                    :name => "Tate",
                    :main_keyword => 'art',
                    :base_url => "https://shop.tate.org.uk/",
                    :link_base_url=> "https://shop.tate.org.uk",
                    :keywords => %w(poster painting print exhibition child clothes card cushion shirt),
                    :search_string =>"search?q=",
                    :search_base_url=> "https://shop.tate.org.uk/search?q=",
                    :results_size_string => "&sz=",
                    :results_size=> 100,  
                    :min_price_string=>'pmin',
                    :max_price_string=>'pmax',
                    :price_format=>  "%0.02f", #sprintf( "%0.02f", 123.4564564)
                    :page_string =>"&start=", #any multiple of 100
                    :searchable => true,
                    :js=>false,
                    :api=> false
  },

  # https://shop.zsl.org/product-search?title=mug
  # https://shop.zsl.org/search?field_product_recipient_tid=All&field_price_range_tid=All&field_product_animal_tid=All&field_product_category_tid=All&page=2

 "Kew Gardens" =>    {:age=>0..99,
                    :provider=>'magento',
                    :book => false,
                    :name => "Kew Gardens",
                    :main_keyword => 'nature',
                    :base_url => "https://shop.kew.org",
                    :link_base_url=> "https://shop.kew.org",
                    :keywords => %w(flower tree garden plant home),
                    :search_string =>"/?q=",
                    :initial_url => "https://shop.kew.org/gift-ideas?limit=all",
                    :search_base_url=> "https://shop.kew.org/catalogsearch/result/index/?limit=all&q=",
                    :page_string =>"", #any multiple of 100
                    :max_tries => 5,
                    :searchable => true,
                    :js=>false,
                    :api=> false
  },
 "ZSL London Zoo" =>    {:age=>0..99,
                    :provider=>'amazon',
                    :book => false,
                    :name => "London Zoo",
                    :main_keyword => 'wildlife',
                    :base_url => "https://shop.zsl.org",
                    :link_base_url=> "https://shop.zsl.org",
                    :keywords => %w(animal environment shirt kids),
                    :search_string =>"/product-search?title=",
                    :search_base_url=> "https://shop.zsl.org/product-search?title=",
                    :page_string =>"&page=", #any multiple of 100
                    :max_tries => 5,
                    :searchable => true,
                    :js=>false,
                    :api=> false
  },

  "Second Run"=>  {:age=>16..99,
                  :provider=>'wordpress_ecwid',
                  :book => false,
                  :name => "Second Run",
                  :main_keyword => 'film',
                  :base_url => 'https://secondrundvd.ecwid.com/#!/~/search/',
                  :keywords => ['film', 'dvd', 'arthouse', 'cinema'],
                  :searchable => true,
                  :search_string =>"keyword=",
                  :results_size=> 10,
                  :page_string =>"&offset=", #multiple of 10
                  :divider=>nil,
                  :js=>true,
                  :api=> false
  }
}