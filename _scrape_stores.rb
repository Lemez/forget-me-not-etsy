
# def divine_category
#   keys = [:name, :description, :categories]
#   matcher = Deviner::Match.new(weights)
#   matcher.model(product, keys)

#   matcher.match(Category.all) # result will be the matching category

# end

def scrape_custom(shop)
  p "custom"
  case shop[:name]
  when "Ethical Kidz"
    @string =   "/#{shop[:page_string]}"
  end

  while shop[:incomplete]

    fields = shop[:subcategories] ? shop[:slugs] : [""]
      
    fields.each do |slug|

        shop[:url] =  "#{shop[:initial_url]}#{slug}#{@string}" 
      
        p "Trying #{shop[:url]}"

        $html = Nokogiri::HTML(open(shop[:url]))
      
        @data={}
        $html.css($shop_css[:product_css]).each_with_index do |product,index|
            begin
                puts index
                @data = get_data_from_product(shop,product)
                @data = add_categories_to(shop,@data)
                shop[:results][:data] << @data
                p @data
                 
            rescue  StandardError => e
                  # p "Problem = #{@problem}" unless @problem.empty?
                  p @data
                  raise e
 
            end
         
        end
      end
    shop[:incomplete] = false
  end
  
  shop[:results][:data].flatten.uniq
end

def scrape_magento(shop)
  # KEW uses limit=all? { |e|  }
  # SLUG: https://shop.kew.org/kewbooksonline/gift-books?limit=all 
  # SEARCH: https://shop.kew.org/catalogsearch/result/?q=frog

  # V+A uses pagination p=1
   
  while shop[:incomplete]


    if  !shop[:opts][:search] && shop[:subcategories] #if not passing a search string from searchbar
      fields =  shop[:slugs]
      @slugging = true
    else # but if yes...
      fields = [""] #ignore slug-based iterative search
      @slugging = false
    end

     fields.each do |slug|

        case shop[:identifier]
        when "Kew"
          @string = shop[:results_size_string]
          @size = shop[:results_size]
        when "V and A"
          @string = shop[:page_string]
          @size = shop[:results][:page]  
        end

        @pagination_string = shop[:is_paginated]||shop[:identifier]=='Kew' ? "?#{@string}#{@size}" : ""
        shop[:url] = "#{shop[:initial_url]}#{slug}#{@pagination_string}"
         
        if !@slugging && !shop[:opts][:word].empty?
          shop[:url] =   "#{shop[:search_base_url]}#{shop[:opts][:word]}&#{@string}#{@size}"
        end
          
        p "Trying #{shop[:url]}: Slugs=#{@slugging}"

        $html = Nokogiri::HTML(open(shop[:url]))
        $pagination = $html.css($shop_css[:pagination_css])
        
        $html.css($shop_css[:product_css]).each_with_index do |product, index|
     
            begin
                @data = get_data_from_product(shop,product)
                @data = add_categories_to(shop,@data,slug)
                shop[:results][:data] << @data
                p @data
                 
            rescue  StandardError => e
                  # p "Problem = #{@problem}" unless @problem.empty?
                  p @data
                  raise e
 
            end
          end

          # shop[:results][:data].each{|x| ap x} #unless shop[:opts][:web]

          p "Done #{shop[:url]}"
        end


        if shop[:is_paginated]
          last_page = $html.css($shop_css[:last_page_css]).empty? ? true : $html.css($shop_css[:last_page_css]).last.classes.include?('is-current')
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
    pagination = html.css($shop_css[:pagination_css])

    html.css($shop_css[:product_css]).each_with_index do |product, index|
         begin
                @data = get_data_from_product(shop,product)
                @data = add_categories_to(shop,@data)
                shop[:results][:data] << @data
                p @data
                 
            rescue  StandardError => e
                  # p "Problem = #{@problem}" unless @problem.empty?
                  p @data
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

def scrape_salesforce(shop) #Tate
  p shop
    @web = shop[:opts][:web]

    if shop[:opts][:word].to_s.empty?
      shop[:base_url] += "?"
      shop[:search_string] = ''
      shop[:url] = "#{shop[:base_url]}#{shop[:results_size_string]}#{shop[:results_size]}#{shop[:page_string]}0"

    else
      shop[:url] = "#{shop[:search_base_url]}#{shop[:opts][:word]}#{shop[:results_size_string]}#{shop[:results_size]}#{shop[:page_string]}0"

    end
     p shop

    p "Trying #{shop[:url]}"
    $all_categories = []

   while shop[:incomplete]

      html = Nokogiri::HTML(open(shop[:url]))
      pagination = html.css($shop_css[:pagination_css])
      
      html.css($shop_css[:product_css]).each_with_index do |product, index|
         begin
                @data = get_data_from_product(shop,product)
                @data = add_categories_to(shop,@data)
                shop[:results][:data] << @data
                p @data
                 
        rescue  StandardError => e
          p "Rescue me!"
                # p "Problem = #{@problem}" unless @problem.empty?
                p @data
                next

        end
       
      end

      p "Done #{shop[:url]}"
      
      if pagination.any? #&& !shop[:opts][:web]
        the_page = pagination[-1].attributes.values.first.value
        is_last_page = the_page.split(" ").include?('current-page')
        p is_last_page
        
        if not is_last_page
          offset = shop[:results_size].to_i * shop[:results][:page]
          shop[:url] = "#{shop[:base_url]}#{shop[:search_string]}#{shop[:opts][:word]}#{shop[:results_size_string]}#{shop[:results_size]}#{shop[:page_string]}#{offset}"
          shop[:results][:page] +=1
          p "Trying #{shop[:url]}"
          redo
        else
          p "Last page"
        end

      else
        p "no pagination detected"
      end

      shop[:incomplete] = false

    end

    shop[:results][:data]
end

def scrape_wordpress_woocommerce(shop) #working for Novalia, not yet for Pushkin Press
  p shop[:url]
   while shop[:incomplete]
      html = Nokogiri::HTML(open(shop[:url]))

      if shop[:is_paginated]
        counter = html.css($shop_css[:pagination_css]).text.split(" ")
        total = counter[-2].to_i
        current = counter[1].split("–").last.to_i
      end

       html.css($shop_css[:product_css]).each_with_index do |product,index|
          begin
                puts index
                @data = get_data_from_product(shop,product)
                @data = add_categories_to(shop,@data)
                shop[:results][:data] << @data
                p @data
                 
          rescue  StandardError => e
                # p "Problem = #{@problem}" unless @problem.empty?
                p @data
                next
 
          end
      end

    p "Done #{shop[:url]}"
    
    if shop[:is_paginated]
      shop[:results][:page] +=1
      shop[:url] = "#{shop[:base_url]}#{shop[:search_string]}#{shop[:opts][:word]}#{shop[:page_string]}#{shop[:results][:page]}/"
      p "Trying #{shop[:url]}"
      redo if current != total
    end

    shop[:incomplete] = false
  end

  # p shop[:results][:data]
  shop[:results][:data]

    
end


def scrape_shopify(shop)
  #works for https://popsandozzy.com/search?q=kids
  p "shopify"
  $empties = 0
  while shop[:incomplete]
    p shop[:url]
    html = Nokogiri::HTML(open(shop[:url]))
    pag = $shop_css[:pagination_css]
    if html.css(pag).nil? || html.css(pag).empty? 
      @last_page = true
    else
      counter = html.css(pag).last.text
      @last_page = counter.to_i == shop[:results][:page] ? true : false
    end
    
    @data={}
    stuff =  html.css($shop_css[:product_css])

   stuff.each do |product|

      begin

        @data = get_data_from_product(shop,product)
        @data = add_categories_to(shop,@data)
        shop[:results][:data] << @data
        p @data

      rescue
        $empties +=1
        next
      end
    end


    $empties +=1 if @data.keys.empty? || @data.keys.nil?
    shop[:results][:page] +=1

    shop[:url] = "#{shop[:base_url]}#{shop[:search_string]}#{shop[:opts][:word]}#{shop[:page_string]}#{shop[:results][:page]}"
    redo unless @last_page || $empties >=3
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