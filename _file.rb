def repair_booklist_urls
  # go to new booktrust url (hyphenated title)
  #find image url
  #replace on file
end

def write_to(results, opts={:format=>'json'})

    case opts[:format]
    when 'json'
        write_results_to_json(results)  
    when 'csv'
        write_results_to_csv(results)
    when 'term', 'print'
        print_results(results)
    end
      
end

def write_results_to_json(results)
  name = results[0][:shop]
  path = "#{Dir.pwd}/json/#{name}"

  if not File.directory?(path)
    Dir.mkdir path
  end

  time = Time.now.strftime('%Y-%m-%d_%H-%M-%S')

  File.open("#{path}/#{time}.json", 'w') do |file|
    results.each do |item|
     file.puts(item.to_json)
    end
  end
end

def write_results_to_csv(results)

  name = results[0][:shop]
  path = "#{Dir.pwd}/csv/#{name}"

  if not File.directory?(path)
    Dir.mkdir path
  end

  time = Time.now.strftime('%Y-%m-%d_%H-%M-%S')

  CSV.open("#{path}/#{time}.csv", 'w') do |csv|
    results.each do |item|
      data = item.values
      csv << data
    end
  end
end

def print_results(results)
  results.
    reject{|item|item[:soldout]==true}.
      each_with_index{|x,i| 
        x.each_pair{|k,v| 
          puts "#{i.to_s} #{k}: #{v}"
          }; puts "-"
        }
end

def count_words(string)
  string.scan(/\w+/).each_with_object(Hash.new(0)){|w,h| h[w.downcase]+=1}
end