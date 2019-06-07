require 'date'
require 'sinatra/activerecord'

# users = [
#   {:firstname => 'Jonathan',
#    :lastname => 'Walton',
#   :email => 'lemez9@gmail.com'}
# ]

# users.each do |u|
#   User.create(u)
# end

# keywords = ['horse', 'child psychology', 'dinosaur', 'magic realism', 'girl adventure', 'Romani', 'gypsy']


# loved_ones = [{
#   :firstname => "Anna",
#   :lastname => "Walton",
#   :birthday => DateTime.parse('19th June 1973'),
#   :keywords => ['horse', 'child psychology']
#   },
#   {
#      :firstname => "Alma",
#     :lastname => "Walton",
#     :birthday => DateTime.parse('19th May 2012'),
#   :keywords => ['dinosaur', 'myth', 'girl adventure']
#   },
#   {
#      :firstname => "Nora",
#     :lastname => "Kertesz",
#     :birthday =>  DateTime.parse('16th September 1970'),
#   :keywords => ['Romani', 'gypsy', 'magic realism']
#   }
# ]

# loved_ones.each do |u|
#   Friend.create(u)
# end

Friend.create({:firstname => "Ruth",
:lastname => "Walton",
 :birthday => Date.parse('7th June 1946'),
:keywords =>['art','sculpture','opera','clipon earrings']})
