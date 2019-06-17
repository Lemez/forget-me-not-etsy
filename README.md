tux
to access db

Sinatra (w reloading)
rerun app.rb

(Using heroku config.ru)
rerun -- rackup --port 4567 config.ru

Sinatra (wo reloading)
ruby app.rb

Script only
ruby main.rb
ruby -r "./main.rb" -e "etsy_q"


# to do
1. Save Products, including last_updated field


Pseudocode (May 2019)
- log in

- import list of birthdays to DB from FB

Server
1. Once per day, query all Friends.birthday (active)
2. If Today falls into upcoming birthday User.Notifications.Times
3. Queries Etsy API with Keywords, Budget >> Desc, Image, Cost, Url

Etsy query: if no results from /listings/, then 
# compare images to refuse duplicates
    <!-- https://github.com/Nakilon/dhash-vips -->

4. Get appropriate books from booklist

# fix broken links to booktrust >> new file lists_with_books_full_updated
# add to Books db?
# find buying online link (wordery) 
# get better search than Google Custom (rate limiting blah blah)
#   search by ISBN is more reliable for wordery / Amazon direct links  

5. Compiles output to Mailer

Client Functions
1. Log in with FB / Google
2. Add Person


- 
- Launches Etsy App

ActiveRecord
rake db:create_migration NAME=create_users_table
Add code to the migration for creating columns
rake db:migrate

# models.rb
class User < ActiveRecord::Base
end

# at the bottom of app.rb
require './models

edit db/seeds.rb
rake db:seed

@users = User.all in the routes.



- User has :
    + Name
    + Email
    + Notifications : has
        * On T/F
        * Times : has
    + Friends : has
        + Name
        + Birthday
        + Address
        + Age
        + Keywords
        + Budget
        + Gifts : has
            + Item
            + Cost
            + Purchase Date
            + Message
        + Active T/F
        + Shared with other users <?> eg only one person needs to update