def scrape_wordpress_ecwid(shop)
   # while shop[:incomplete]
   # needs JS wait etc
  
    html = Nokogiri::HTML(open(shop[:url]))
    counter = html.css('img')
    counter.each{|x| p x}

end

def scrape_salesforce(shop)

    if not shop[:searchable]
      shop[:base_url] += "?"
      shop[:search_string] = ''
    else
      "&" << shop[:results_size_string]
    end

    shop[:url] = "#{shop[:base_url]}#{shop[:search_string]}#{shop[:word]}#{shop[:results_size_string]}#{shop[:results_size]}#{shop[:page_string]}0"
    p "Trying #{shop[:url]}"

   while shop[:incomplete]

      html = Nokogiri::HTML(open(shop[:url]))
      pages = html.css('ul.pagination-wrapper li.single-page')
      

      html.css('div.product-tile').each_with_index do |product, index|
        begin
               
                  id = product.attributes['data-itemid'].value

                  data = {:title => product.at('div.product-name a.name-link span').text,
                  :price => product.at('span.product-sales-price').text.strip,
                  :link =>  shop[:link_base_url] + product.at('div.product-name a.name-link').attributes['href'].value,
                  :image => product.at('div.product-image a.thumb-link img').attributes['src'].value,
                  :description => '',
                  :categories => '',
                  :soldout => ''
                }
            if shop[:book]
              data[:categories] = ['book']
              data[:book] = true
              product_page = Nokogiri::HTML(open(data[:link]))  
              data[:author] = product_page.at('div.by-brand-wrapper span.brand-name').text.split("By").last.strip
            else
              data[:book] = false
            end

          shop[:results][:data] << data
          print "."

        rescue
          next 
        end
      end

      p shop[:results][:data]
      p shop[:results][:data].size
      p shop[:results][:data].last

      p "Done #{shop[:url]}"
      
      the_page = pages[-1].attributes.values.first.value
  
      is_last_page = the_page.split(" ").include?('current-page')
      offset = shop[:results_size].to_i * shop[:results][:page]

      shop[:url] = "#{shop[:base_url]}#{shop[:search_string]}#{shop[:word]}#{shop[:results_size_string]}#{shop[:results_size]}#{shop[:page_string]}#{offset}"
      p "Trying #{shop[:url]}"
      
      shop[:results][:page] +=1
      redo unless is_last_page
      shop[:incomplete] = false
    end

    p shop[:results][:data]
    shop[:results][:data]
end

def scrape_wordpress_woocommerce(shop) #working for Novalia

   while shop[:incomplete]
      html = Nokogiri::HTML(open(shop[:url]))
      counter = html.css('div.mk-woocommerce-result-count').text.split(" ")
      total = counter[-2].to_i
      current = counter[1].split("–").last.to_i

       html.css('div.mk-product-holder').each do |product|
        begin

          desc = product.at('a img').attributes['alt'].value
          data = {:title => desc,
                  :price => product.at('span.woocommerce-Price-amount').text,
                  :link =>  product.at('a.woocommerce-LoopProduct-link').attributes['href'].value,
                  :image => JSON.parse(product.at('a img').attributes['data-mk-image-src-set'])['mobile'],
                  :description => desc,
                  :categories => desc.split(" ").uniq,
                  :soldout => false
                }
          shop[:results][:data] << data

        rescue
          next 
        end
      end

    p "Done #{shop[:url]}"
    shop[:results][:page] +=1

    shop[:url] = "#{shop[:base_url]}#{shop[:search_string]}#{shop[:word]}#{shop[:page_string]}#{shop[:results][:page]}/"
    p "Trying #{shop[:url]}"
    
    redo if current != total

    shop[:incomplete] = false
  end

  p shop[:results][:data]
  shop[:results][:data]

    
end


def scrape_shopify(shop)
  #works for https://popsandozzy.com/search?q=shirt
  
  while shop[:incomplete]
  
    html = Nokogiri::HTML(open(shop[:url]))
    counter = html.css('div#pagination span.count').text.split(" ")
    total = counter.last.to_i
    current = counter.select{|x| x.include?("-")}.first.split("-").last.to_i

    html.css('div.product-index').each do |product|
      begin

        categories =  [shop[:word]] + product.at('a img').attributes['alt'].value.downcase.split(" ")
        categories += product.attributes['data-alpha'].value.downcase.split(" ")

        data = {:title => product.attributes['data-alpha'].value,
                  :price => product.attributes['data-price'].value,
                  :link =>  shop[:base_url] + product.at('a').attributes['href'].value[1..-1], #remove first '/'
                  :image => product.at('a img').attributes['src'].value.split("?")[0].gsub!("//",""),
                  :description => product.at('a img').attributes['alt'].value,
                  :categories => categories.uniq,
                  :soldout => product.css('div.so').any?
                }
        shop[:results][:data] << data

      rescue
        next
      end
    end


    p shop[:url]
    shop[:results][:page] +=1

    shop[:url] = "#{shop[:base_url]}#{shop[:search_string]}#{shop[:word]}#{shop[:page_string]}#{shop[:results][:page]}"
    redo if current != total

    shop[:incomplete] = false
  end

  p shop[:results][:data]
  shop[:results][:data]
end