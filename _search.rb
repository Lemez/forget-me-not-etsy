def  search_by_item(opts)
  p "search_by_item"

  p opts
  # 1. find all shops with that item as keyword
    shops = STORES.values.
    reject {|t| t[:keywords].nil?}.
     select {|u|u[:keywords].include?(opts[:word])}. 
    select{ |s|s[:searchable] || s[:standalone]}
          
         

  # 2. search each shop with that item as keyword
    @results = []
    shops.each do |shop|
      p shop
      opts[:name] = shop[:name]
    p opts
      # turn into threads
     @results << search_scrape(opts)
    end
    
  # 3. collate and present
  @results.flatten.uniq.reject{|x|x[:soldout]}.reject{|x|x[:title].nil? || x[:title].empty?}


end
