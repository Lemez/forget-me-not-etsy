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

SHOP_PROVIDERS=%w(wordpress_woocommerce wordpress_ecwid shopify bigcartel)

STORES = {

  "Pops & Ozzy"=>  {:age=>0..12,
                    :provider=>'shopify',
                    :name => "Pops & Ozzy",
                    :base_url => 'https://popsandozzy.com/',
                    :keywords => ['tattoo', 'shirt', 'clothes', 'kids', 'book', 'toy', 'game', 'baby'],
                    :searchable => true,
                    :js=>false,
                    :search_string =>"search?q=",
                    :page_string =>"&page=",
                    :divider=>'+'},

  "Anorak"=>  {:age=>6..12,
              :provider=>'bigcartel',
              :name => "Anorak",
              :domain => 'squarepegsstudiosocial',
              :base_url => 'https://anorakmagazine.com/collections/all',
              :link_base_url => 'https://squarepegsstudiosocial.bigcartel.com',
              :keywords => ['magazine', 'design', 'kids', 'book'],
              :searchable => false,
              :search_string =>nil,
              :divider=>nil
            },
  "Second Run"=>  {:age=>16..99,
              :provider=>'wordpress_ecwid',
              :name => "Second Run",
              :base_url => 'https://secondrundvd.ecwid.com/#!/~/search/',
              :keywords => ['film', 'dvd', 'arthouse', 'cinema'],
              :searchable => true,
              :page_string =>"&offset=",
              :search_string =>"keyword=",
              :divider=>nil,
              :js=>true
            },

}