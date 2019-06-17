
# def divine_category
#   keys = [:name, :description, :categories]
#   matcher = Deviner::Match.new(weights)
#   matcher.model(product, keys)

#   matcher.match(Category.all) # result will be the matching category

# end

def scrape_magento(shop)
  # KEW uses limit=all
  # V+A uses pagination p=1
   
  while shop[:incomplete]


    if not shop[:opts][:search] #if not passing a search string from searchbar
      fields = shop[:subcategories] ? shop[:slugs] : [""]
    else # but if yes...
      fields = [""] #ignore slug-based iterative search
    end

     fields.each do |slug|

        case shop[:identifier]
        when "Kew"
          @string = shop[:results_size_string]
          @size = shop[:results_size]
          $is_paginated = false
          @product_css = 'div.relative-holder'
          @price_css = 'span.price'
          @img_css = 'img'
          @link_css = 'a'
          @title_css = 'h2.product-name a'
          @img_source = 'src'
        when "V and A"
          @string = shop[:page_string]
          @size = shop[:results][:page]
          $is_paginated = true
          @product_css = "article.product-thumb"
          @price_css = "div.product-thumb__price"
          @img_css = 'img'
          @link_css ='a'
          @title_css = 'div.product-thumb__title'
          @img_source = 'data-src'
        end

        if slug == ""
          shop[:url] = shop[:opts][:word].empty? ? "#{shop[:initial_url]}#{slug}&#{@string}#{@size}" : "#{shop[:search_base_url]}#{shop[:opts][:word]}&#{@string}#{@size}"
        else 
          shop[:url] = "#{shop[:initial_url]}#{slug}?#{@string}#{@size}"
        end
          
        p "Trying #{shop[:url]}"

        $html = Nokogiri::HTML(open(shop[:url]))
        $pagination = $html.css('a.pagination__next')

        $html.css(@product_css).each_with_index do |product, index|
     
            begin
                      link= product.css(@link_css)[-1]
                      imgdiv = product.at(@img_css)
                      price = product.at(@price_css)
                      title = product.at(@title_css).text.strip
                   
                      data = {:title => title,
                      :price => price.text.strip,
                      :link =>  link.attributes['href'].value,
                      :image => imgdiv.attributes[@img_source].value ,
                      :description => '',
                      :has_description => false,
                      :categories => ([shop[:main_keyword]] << title.split(" ")).flatten,
                      :soldout => false,
                      :shop => shop[:name]
                    }
                 
                 shop[:results][:data] << data
                  print "."
            rescue => e
              puts e
              # raise e
              next
            end
          end

          shop[:results][:data].each{|x| ap x} #unless shop[:opts][:web]

          p "Done #{shop[:url]}"
        end

        if $is_paginated
          last_page = $html.css('div.pagination__pages a').empty? ? true : $html.css('div.pagination__pages a').last.classes.include?('is-current')
          p "Last page: #{last_page}"
           if $pagination.text.strip=="Next"
              if shop[:results][:page] < shop[:max_tries] && !last_page
                shop[:results][:page] +=1
                p "Pagination: going to next page"
                redo
              else
                p "Page #{shop[:results][:page]} out of maximum #{shop[:max_tries]}"
              end
            else 
              p "Pagination: no next page"
            end
        else
          p "Pagination: none"
        end
        
        shop[:incomplete]=false 
      end

    shop[:results][:data].flatten.uniq
end


def scrape_amazon(shop)

  while shop[:incomplete]

    page_info = shop[:results][:page]==1 ? "" : "#{shop[:page_string]}#{shop[:results][:page]}"
    shop[:url] = "#{shop[:search_base_url]}#{shop[:opts][:word]}#{page_info}"
    p "Trying #{shop[:url]}"

    html = Nokogiri::HTML(open(shop[:url]))
    # p html
    pagination = html.css('li.pager-next')

    html.css('div.card-grid__item div.card').each_with_index do |product, index|
        # p product
        begin
                  link= product.at('div.card__media a')
                  img = product.at('img')
                  price = product.at('div.field-commerce-price')
                  # p link
                  # p img
                  # p price
               
                  data = {:title => img.attributes['title'].value,
                  :price => price.text.strip,
                  :link =>  shop[:link_base_url] + link.attributes['href'].value,
                  :image => img.attributes['src'].value,
                  :description => '',
                  :has_description => false,
                  :categories => '',
                  :soldout => false,
                  :shop => shop[:name]
                }
             
             shop[:results][:data] << data
              print "."
        rescue => e
          puts e
          next
        end
      end

      # shop[:results][:data].each{|x| ap x} unless shop[:opts][:web]
      
      # $all_categories.flatten!
      # cats = $all_categories.map(&:downcase).join(" ")

      p "Done #{shop[:url]}"

      if pagination.text=="Load more"

        if shop[:results][:page] < shop[:max_tries]
          shop[:results][:page] +=1
          redo
        else
          p "Page #{shop[:results][:page]} out of #{shop[:max_tries]}: Max tries reached"
        end
            
      else
        p "no pagination detected"
      end

      shop[:incomplete] = false

    end

    shop[:results][:data]

end

def scrape_salesforce(shop)
  p shop
    @web = shop[:opts][:web]

    if shop[:opts][:word].to_s.empty?
      shop[:base_url] += "?"
      shop[:search_string] = ''
      shop[:url] = "#{shop[:base_url]}/#{shop[:results_size_string]}#{shop[:results_size]}#{shop[:page_string]}0"

    else
      shop[:url] = "#{shop[:search_base_url]}#{shop[:opts][:word]}#{shop[:results_size_string]}#{shop[:results_size]}#{shop[:page_string]}0"

    end
     p shop

    p "Trying #{shop[:url]}"
    $all_categories = []

   while shop[:incomplete]

      html = Nokogiri::HTML(open(shop[:url]))
      pagination = html.css('ul.pagination-wrapper li.single-page')
      
      html.css('div.product-tile').each_with_index do |product, index|
        begin
               
                  id = product.attributes['data-itemid'].value
                  prices = product.css('div.product-pricing span')
                  price_span = prices.size==1 ? prices : prices[0]
                  # product.at('span.product-sales-price')
                  href = product.at('div.product-name a.name-link').attributes['href'].value
                  link = href.include?('https:') ? href : shop[:link_base_url] + href

                  data = {:title => product.at('div.product-name a.name-link span').text,
                  :price => price_span.text.strip,
                  :link =>  link,
                  :image => product.at('div.product-image a.thumb-link img').attributes['src'].value,
                  :description => '',
                  :has_description => false,
                  :categories => '',
                  :soldout => false,
                  :shop => shop[:name]
                }


            if shop[:book] && !shop[:opts][:web]
              data[:categories] = ['book']
              data[:book] = true
              product_page = Nokogiri::HTML(open(data[:link]))  
              data[:author] = product_page.at('div.by-brand-wrapper span.brand-name').text.split("By").last.strip
            else
              data[:book] = false
              words = data[:title].split(" ")
              arr = Array.new words.flatten 
              data[:categories] = ([shop[:main_keyword],shop[:opts][:word]] << arr).flatten.uniq
              data[:main_category] =  data[:categories].last
              $all_categories << words

            end

          # data = data.to_json if @web
          shop[:results][:data] << data
          print "."

        rescue
          next 
        end
      end

      shop[:results][:data].each{|x| ap x} unless shop[:opts][:web]
      
      # $all_categories.flatten!
      # cats = $all_categories.map(&:downcase).join(" ")

      p "Done #{shop[:url]}"
      
      if pagination.any? && !shop[:opts][:web]
        the_page = pagination[-1].attributes.values.first.value
  
        is_last_page = the_page.split(" ").include?('current-page')
        offset = shop[:results_size].to_i * shop[:results][:page]

        shop[:url] = "#{shop[:base_url]}#{shop[:search_string]}#{shop[:opts][:word]}#{shop[:results_size_string]}#{shop[:results_size]}#{shop[:page_string]}#{offset}"
        p "Trying #{shop[:url]}"
      
        shop[:results][:page] +=1
        redo if not is_last_page

      else
        p "no pagination detected"
      end

      shop[:incomplete] = false

    end

    shop[:results][:data]
end

def scrape_wordpress_woocommerce(shop) #working for Novalia
  p shop[:url]
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
                  :description => '',
                  :has_description => false,
                  :categories => desc.split(" ").uniq,
                  :soldout => false,
                  :shop => shop[:name]
                }
          shop[:results][:data] << data

        rescue
          next 
        end
      end

    p "Done #{shop[:url]}"
    shop[:results][:page] +=1

    shop[:url] = "#{shop[:base_url]}#{shop[:search_string]}#{shop[:opts][:word]}#{shop[:page_string]}#{shop[:results][:page]}/"
    p "Trying #{shop[:url]}"
    
    redo if current != total

    shop[:incomplete] = false
  end

  p shop[:results][:data]
  shop[:results][:data]

    
end


def scrape_shopify(shop)
  #works for https://popsandozzy.com/search?q=kids
  
  while shop[:incomplete]
    p shop[:url]
    html = Nokogiri::HTML(open(shop[:url]))
    if html.css('div#pagination a').empty? || html.css('div#pagination a').nil?
      @last_page = true
    else
      counter = html.css('div#pagination a').last.text
      @last_page = counter.to_i == shop[:results][:page] ? true : false
    end
    

    html.css('div.product-index').each do |product|
      begin

        categories =  [shop[:opts][:word]] + product.at('a img').attributes['alt'].value.downcase.split(" ")
        categories += product.attributes['data-alpha'].value.downcase.split(" ")
        price = product.attributes['data-price'].value.to_s

        data = {:title => product.attributes['data-alpha'].value,
                  :price => "£" + price.slice(0..price.length-3) + "." + price.slice(-2..-1),
                  :link =>  shop[:base_url] + product.at('a').attributes['href'].value[1..-1], #remove first '/'
                  :image => 'https://' + product.at('a img').attributes['src'].value.split("?")[0].gsub!("//",""),
                  :description => product.at('a img').attributes['alt'].value,
                  :has_description => true,
                  :categories => categories.uniq,
                  :shop => shop[:name],
                  :soldout => product.css('div.so').any?
                }
        shop[:results][:data] << data

      rescue
        next
      end
    end


    p shop[:url]
    shop[:results][:page] +=1

    shop[:url] = "#{shop[:base_url]}#{shop[:search_string]}#{shop[:opts][:word]}#{shop[:page_string]}#{shop[:results][:page]}"
    redo unless @last_page
    # redo if current != total

    shop[:incomplete] = false
  end

  p shop[:results][:data]
  shop[:results][:data]
end

def scrape_wordpress_ecwid(shop)
   # while shop[:incomplete]
   # needs JS wait etc
  
    html = Nokogiri::HTML(open(shop[:url]))
    counter = html.css('img')
    counter.each{|x| p x}

end