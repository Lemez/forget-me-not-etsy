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


  def self.all_upcoming(num)
    Friend.all.select {|bday|bday.upcoming?(num)}
  end


end