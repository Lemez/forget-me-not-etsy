def read_fb_birthdays
  uri = URI('https://www.facebook.com/ical/b.php?uid=602585041&key=AQAlpoQx8IOU78qH') 

  File.open("lib/fb_birthdays.txt", "wb") do |saved_file|
    # the following "open" is provided by open-uri
    open(uri, "rb") do |read_file|
      saved_file.write(read_file.read)
    end
  end
  # event = Icalendar::Calendar.parse(cal_file).first

end