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
                    :name => "Tate",
                    :book => true,
                    :base_url => "https://shop.tate.org.uk/books/view-all-books",
                    :link_base_url=> "https://shop.tate.org.uk/",
                    :keywords => %w(print poster art exhibition kids clothes card cushion shirt gifts homeware books),
                    :search_string =>"search?q=",
                    :results_size_string => "sz=",
                    :results_size=> 100,
                    :page_string =>"&start=", #any multiple of 100
                    :searchable => false,
                    :js=>false,
                    :api=> false
   
  },
      "Tate Gifts" =>       {:age=>0..99,
                    :provider=>'salesforce',
                    :book => false,
                    :name => "Tate",
                    :base_url => "https://shop.tate.org.uk/gifts/view-all-gifts",
                    :link_base_url=> "https://shop.tate.org.uk/",
                    :keywords => %w(print poster art exhibition kids clothes card cushion shirt books homeware),
                    :search_string =>"search?q=",
                    :results_size_string => "sz=",
                    :results_size=> 100,
                    :page_string =>"&start=", #any multiple of 100
                    :searchable => false,
                    :js=>false,
                    :api=> false
   
  },
  "Tate" =>       {:age=>0..99,
                    :provider=>'salesforce',
                    :book => false,
                    :name => "Tate",
                    :base_url => "https://shop.tate.org.uk/",
                    :link_base_url=> "https://shop.tate.org.uk/",
                    :keywords => %w(print poster art exhibition kids clothes card cushion shirt),
                    :search_string =>"search?q=",
                    :results_size_string => "&sz=",
                    :results_size=> 100,
                    :page_string =>"&start=", #any multiple of 100
                    :searchable => true,
                    :js=>false,
                    :api=> false
   
  },

    "Tate Homeware" =>       {:age=>0..99,
                    :provider=>'salesforce',
                    :book => false,
                    :name => "Tate",
                    :base_url => "https://shop.tate.org.uk/",
                    :link_base_url=> "https://shop.tate.org.uk",
                    :keywords => %w(print poster art exhibition kids clothes card cushion shirt gifts homeware books),
                    :search_string =>"search?q=",
                    :results_size_string => "&sz=",
                    :results_size=> 100,
                    :page_string =>"&start=", #any multiple of 100
                    :searchable => false,
                    :js=>false,
                    :api=> false
   
  },

  "Second Run"=>  {:age=>16..99,
                  :provider=>'wordpress_ecwid',
                  :book => false,
                  :name => "Second Run",
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