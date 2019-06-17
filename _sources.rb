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
                    :keywords => %w(electronics poster instrument technology science musician kids),
                    :search_string =>"",
                    :results_size_string => nil,
                    :results_size=> 10,
                    :page_string =>"page/", #only 2
                    :searchable => false,
                    :standalone => true,
                    :js=>false,
                    :api=> false
   
  },
    
  "Pops & Ozzy"=>  {:age=>0..12,
                    :provider=>'shopify',
                    :book => false,
                    :name => "Pops & Ozzy",
                    :main_keyword => 'kids',
                    :base_url => 'https://popsandozzy.com/',
                    :keywords => ['tattoo', 'shirt', 'clothes', 'kids', 'book', 'baby', 'toy'],
                    :searchable => true,
                    :search_string =>"search?q=",
                    :page_string =>"&page=",
                    :standalone => true,
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
                  :standalone => true,
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
                    :keywords => %w(books),
                    :search_string =>"search?q=",
                    :results_size_string => "sz=",
                    :results_size=> 100,
                    :min_price_string=>'pmin',
                    :max_price_string=>'pmax',
                    :price_format=>  "%0.02f", #sprintf( "%0.02f", 123.4564564)
                    :page_string =>"&start=", #any multiple of 100
                    :searchable => false,
                    :standalone => true,
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
                    :keywords => %w(gifts),
                    :search_string =>"search?q=",
                    :results_size_string => "sz=",
                    :results_size=> 100,
                    :min_price_string=>'pmin',
                    :max_price_string=>'pmax',
                    :price_format=>  "%0.02f", #sprintf( "%0.02f", 123.4564564)
                    :page_string =>"&start=", #any multiple of 100
                    :searchable => false,
                    :standalone => true,
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
                    :keywords => %w(home),
                    :search_string =>"search?q=",
                    :results_size_string => "sz=",
                    :results_size=> 100,
                    :min_price_string=>'pmin',
                    :max_price_string=>'pmax',
                    :price_format=>  "%0.02f", #sprintf( "%0.02f", 123.4564564)
                    :page_string =>"&start=", #any multiple of 100
                    :searchable => false,
                    :standalone => true,
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
                    :keywords => %w(poster painting print exhibition kids clothes card cushion shirt toy),
                    :search_string =>"search?q=",
                    :search_base_url=> "https://shop.tate.org.uk/search?q=",
                    :results_size_string => "&sz=",
                    :results_size=> 100,  
                    :min_price_string=>'pmin',
                    :max_price_string=>'pmax',
                    :price_format=>  "%0.02f", #sprintf( "%0.02f", 123.4564564)
                    :page_string =>"&start=", #any multiple of 100
                    :searchable => true,
                    :standalone => false,
                    :js=>false,
                    :api=> false
  },

#magento also V+A https://www.vam.ac.uk/shop

 "Kew Books" =>    {:age=>0..99,
                    :provider=>'magento',
                    :book => true,
                    :name => "Kew Books",
                    :main_keyword => 'nature books',
                    :base_url => "https://shop.kew.org",
                    :link_base_url=> "https://shop.kew.org",
                    :keywords => %w(flower tree garden plant home),
                    :slugs => %w(new-books children-s-kew gift-books special-offers gardening),
                    :search_string =>"/?q=",
                    :initial_url => "https://shop.kew.org/kewbooksonline/",
                    :search_base_url=> "https://shop.kew.org/catalogsearch/result/?q=",
                    :page_string =>"", #any multiple of 100
                    :max_tries => 5,
                    :results_size=> 'all',
                    :results_size_string =>"limit=",
                    :searchable => false,
                    :standalone => true,
                    :subcategories => true,
                    :js=>false,
                    :api=> false
  },
   "Kew Homeware" =>    {:age=>0..99,
                    :provider=>'magento',
                    :book => true,
                    :name => "Kew Homeware",
                    :identifier => "Kew",
                    :main_keyword => 'nature homeware',
                    :base_url => "https://shop.kew.org",
                    :link_base_url=> "https://shop.kew.org",
                    :keywords => %w(flower tree garden plant home),
                    :slugs => %w(rugs-throws home-decoration tableware mugs glassware tea-towels stationery candles souvenirs art-prints),
                    :search_string =>"/?q=",
                    :initial_url => "https://shop.kew.org/homeware/",
                    :search_base_url=> "https://shop.kew.org/catalogsearch/result/?q=",
                    :page_string =>"", #any multiple of 100
                    :max_tries => 5,
                    :results_size=> 'all',
                    :results_size_string =>"limit=",
                    :searchable => false,
                    :standalone => true, #used to see if it can be searched in a category without a keyword
                    :subcategories => true,
                    :js=>false,
                    :api=> false
  },

     "Kew Gifts" =>    {:age=>0..99,
                    :provider=>'magento',
                    :book => true,
                    :name => "Kew Gifts",
                    :identifier => "Kew",
                    :main_keyword => 'nature gifts',
                    :base_url => "https://shop.kew.org",
                    :link_base_url=> "https://shop.kew.org",
                    :keywords => %w(flower tree garden plant home),
                    :search_string =>"/?q=",
                    :initial_url => "https://shop.kew.org/gift-ideas",
                    :search_base_url=> "https://shop.kew.org/catalogsearch/result/?q=",
                    :page_string =>"", #any multiple of 100
                    :max_tries => 5,
                    :results_size=> 'all',
                    :results_size_string =>"limit=",
                    :standalone => true, #used to see if it can be searched in a category without a keyword
                    :searchable => false,
                    :subcategories => false,
                    :js=>false,
                    :api=> false
  },

  
     "Kew Food" =>    {:age=>0..99,
                    :provider=>'magento',
                    :book => true,
                    :name => "Kew Food",
                    :identifier => "Kew",
                    :main_keyword => 'natural food',
                    :base_url => "https://shop.kew.org",
                    :link_base_url=> "https://shop.kew.org",
                    :keywords => %w(flower tree garden plant home),
                    :search_string =>"/?q=",
                    :initial_url => "https://shop.kew.org/food-and-drink",
                    :search_base_url=> "https://shop.kew.org/catalogsearch/result/?q=",
                    :page_string =>"", #any multiple of 100
                    :max_tries => 5,
                    :results_size=> 'all',
                    :results_size_string =>"limit=",
                    :searchable => false,
                    :standalone => true, #used to see if it can be searched in a category without a keyword
                    :subcategories => false,
                    :js=>false,
                    :api=> false
  },
 "Kew Gardens" =>    {:age=>0..99,
                    :provider=>'magento',
                    :book => false,
                    :name => "Kew Gardens",
                    :identifier => "Kew",
                    :main_keyword => 'nature',
                    :base_url => "https://shop.kew.org",
                    :link_base_url=> "https://shop.kew.org",
                    :keywords => %w(flower tree garden plant home toy),
                    :search_string =>"/?q=",
                    :initial_url => "https://shop.kew.org/gift-ideas?limit=all",
                    :search_base_url=> "https://shop.kew.org/catalogsearch/result/index/?limit=all&q=",
                    :page_string =>"", #any multiple of 100
                    :max_tries => 5,
                    :searchable => true,
                    :standalone => false, #used to see if it can be searched in a category without a keyword
                    :js=>false,
                    :api=> false
  },

  # https://www.vam.ac.uk/shop/home.html?p=2
   "V and A Home" =>    {:age=>0..99,
                    :provider=>'magento',
                    :book => false,
                    :name => "V and A Home",
                    :identifier => "V and A",
                    :main_keyword => 'design homeware',
                    :base_url =>  "https://www.vam.ac.uk/shop",
                    :link_base_url=> "https://www.vam.ac.uk/",
                    :keywords => %w(style design modern),
                    :search_string =>"/?q=",
                    :initial_url => "https://www.vam.ac.uk/shop/home.html",
                    :search_base_url=> "https://www.vam.ac.uk/shop/catalogsearch/result/?q=",
                    :page_string =>"p=", #any multiple of 100
                    :max_tries => 10,
                    :results_size=> 'all',
                    :results_size_string =>"limit=",
                    :searchable => false,
                    :standalone => true, #used to see if it can be searched in a category without a keyword
                    :subcategories => false,
                    :js=>false,
                    :api=> false
  },
     "V and A Fashion" =>    {:age=>0..99,
                    :provider=>'magento',
                    :book => false,
                    :name => "V and A Fashion",
                    :identifier => "V and A",
                    :main_keyword => 'design fashion',
                    :base_url =>  "https://www.vam.ac.uk/shop",
                    :link_base_url=> "https://www.vam.ac.uk/",
                    :keywords => %w(style design modern),
                    :search_string =>"/?q=",
                    :initial_url => "https://www.vam.ac.uk/shop/fashion.html",
                    :search_base_url=> "https://www.vam.ac.uk/shop/catalogsearch/result/?q=",
                    :page_string =>"p=", #any multiple of 100
                    :max_tries => 10,
                    :results_size=> 'all',
                    :results_size_string =>"limit=",
                    :searchable => false,
                    :standalone => true, #used to see if it can be searched in a category without a keyword
                    :subcategories => false,
                    :js=>false,
                    :api=> false
  },

  "V and A Pooh" =>    {:age=>0..99,
                    :provider=>'magento',
                    :book => false,
                    :name => "V and A Pooh",
                    :identifier => "V and A",
                    :main_keyword => 'design pooh milne',
                    :base_url =>  "https://www.vam.ac.uk/shop",
                    :link_base_url=> "https://www.vam.ac.uk/",
                    :keywords => %w(style design modern kids toy),
                    :search_string =>"/?q=",
                    :initial_url => "https://www.vam.ac.uk/shop/catalogsearch/result/?q=pooh",
                    :search_base_url=> "https://www.vam.ac.uk/shop/catalogsearch/result/?q=",
                    :page_string =>"p=", #any multiple of 100
                    :max_tries => 10,
                    :results_size=> 'all',
                    :results_size_string =>"limit=",
                    :searchable => false,
                    :standalone => true,
                    :subcategories => false,
                    :js=>false,
                    :api=> false
  },
   "V and A" =>    {:age=>0..99,
                    :provider=>'magento',
                    :book => false,
                    :name => "V and A",
                    :identifier => "V and A",
                    :main_keyword => 'design',
                    :base_url =>  "https://www.vam.ac.uk/shop",
                    :link_base_url=> "https://www.vam.ac.uk/",
                    :keywords => %w(shirt jewellery kids toy),
                    :search_string =>"/?q=",
                    :initial_url => "https://www.vam.ac.uk/shop.html",
                    :search_base_url=> "https://www.vam.ac.uk/shop/catalogsearch/result/?q=",
                    :page_string =>"p=", #any multiple of 100
                    :max_tries => 10,
                    :results_size=> 'all',
                    :results_size_string =>"limit=",
                    :searchable => true,
                    :standalone => false,
                    :subcategories => false,
                    :js=>false,
                    :api=> false
  },

  # https://shop.zsl.org/product-search?title=mug
  # https://shop.zsl.org/search?field_product_recipient_tid=All&field_price_range_tid=All&field_product_animal_tid=All&field_product_category_tid=All&page=2


 "London Zoo" =>    {:age=>0..99,
                    :provider=>'amazon',
                    :book => false,
                    :name => "London Zoo",
                    :main_keyword => 'wildlife',
                    :base_url => "https://shop.zsl.org",
                    :link_base_url=> "https://shop.zsl.org",
                    :keywords => %w(animal environment shirt kids toy),
                    :search_string =>"/product-search?title=",
                    :search_base_url=> "https://shop.zsl.org/product-search?title=",
                    :page_string =>"&page=", #any multiple of 100
                    :max_tries => 5,
                    :searchable => true,
                    :standalone => false,
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
                  :standalone => false,
                  :search_string =>"keyword=",
                  :results_size=> 10,
                  :page_string =>"&offset=", #multiple of 10
                  :divider=>nil,
                  :js=>true,
                  :api=> false
  }
}

BACKUP_PRODUCT_IMAGES = {
  'Kew Gardens'=> "https://i2.wp.com/mygorgeousboys.com/wp-content/uploads/2014/04/Royal-Botanic-Gardens-Kew-logo.jpg",
  'Kew Gifts'=> "https://i2.wp.com/mygorgeousboys.com/wp-content/uploads/2014/04/Royal-Botanic-Gardens-Kew-logo.jpg",
  'Kew Food'=> "https://i2.wp.com/mygorgeousboys.com/wp-content/uploads/2014/04/Royal-Botanic-Gardens-Kew-logo.jpg",
  'Kew Home'=> "https://i2.wp.com/mygorgeousboys.com/wp-content/uploads/2014/04/Royal-Botanic-Gardens-Kew-logo.jpg",
  'Kew Books'=> "https://i2.wp.com/mygorgeousboys.com/wp-content/uploads/2014/04/Royal-Botanic-Gardens-Kew-logo.jpg",
  'V and A'=> "https://proxy.duckduckgo.com/iu/?u=http%3A%2F%2Fovertures.org.uk%2Fwp-content%2Fuploads%2F2017%2F05%2FVA-glasto3.jpg",
    'V and A Pooh'=> "https://proxy.duckduckgo.com/iu/?u=http%3A%2F%2Fovertures.org.uk%2Fwp-content%2Fuploads%2F2017%2F05%2FVA-glasto3.jpg",
'Anorak'=>"https://cdn.shopify.com/s/files/1/1862/6717/files/Anorak_New_-_Turquoise-01_large.png",
  'Pops & Ozzy'=> "https://cdn.shopify.com/s/files/1/1810/5127/files/NEW_LOGO_800x.png",
'London Zoo'=>'https://tickets.picniq.co.uk/zsl-london-zoo/images/logo-zsllondonzoo.png',
'Novalia'=> "http://www.novalia.co.uk/wp-content/uploads/2014/09/logo-dark1.png",
'Tate'=>'https://www.romney-society.org.uk/uploads/8/0/9/1/80919364/tate-logo_orig.jpg'

}