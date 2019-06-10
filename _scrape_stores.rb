def scrape_wordpress_ecwid(shop)
   # while shop[:incomplete]
   # needs JS wait etc
  
    html = Nokogiri::HTML(open(shop[:url]))
    counter = html.css('img')
    counter.each{|x| p x}

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

      shop[:results][:data] << {:title => product.attributes['data-alpha'].value,
                  :price => product.attributes['data-price'].value,
                  :link =>  shop[:base_url] + product.at('a').attributes['href'].value[1..-1], #remove first '/'
                  :image => product.at('a img').attributes['src'].value.split("?")[0].gsub!("//",""),
                  :description => product.at('a img').attributes['alt'].value,
                  :categories => categories.uniq,
                  :soldout => product.css('div.so').any?
                }
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