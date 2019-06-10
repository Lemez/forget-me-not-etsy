def repair_booklist_urls
  # go to new booktrust url (hyphenated title)
  #find image url
  #replace on file
end

def print_scrape_results(results)
  results.
    reject{|item|item[:soldout]}.
      each_with_index{|x,i| 
        x.each_pair{|k,v| 
          puts "#{i.to_s} #{k}: #{v}"
          }; puts "-"
        }
end