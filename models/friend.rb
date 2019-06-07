class Friend < ActiveRecord::Base
  belongs_to :user
  serialize :keywords


# Friend.find_by(firstname:'Anna').first.keywords
# Friend.find_by(firstname:'Anna').keywords
# Friend.all_upcoming(14) ... working for all birthdays in the next fortnight


  def upcoming?(num)
      bday = self.birthday.strftime('%j').to_i
      today = Date.today.strftime('%j').to_i

      bday += 365 if bday < num+1
      return  ((bday - today >-1) && (bday - today <= num))
  end

  def age
      bday = self.birthday.strftime('%j').to_i
      today = Date.today.strftime('%j').to_i

      if today >= bday
        age = Date.today.year - self.birthday.year 
      else
        age = Date.today.year - self.birthday.year  - 1
      end
      age
  end

  def significant?
    
       @significant_birthdays = Array (1..18)
       @significant_birthdays += [21,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100]
      return @significant_birthdays.include?(self.age+1)
  end


  def self.all_upcoming(num)
    Friend.all.select {|bday|bday.upcoming?(num)}
  end


end