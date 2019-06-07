class CreateUsersTable < ActiveRecord::Migration[5.2]
  def change
     create_table :users do |t|
         t.column :firstname, :string, :null => false
         t.column :lastname, :string
         t.column :email, :string
         t.column :active, :boolean, :default => true
         t.timestamps
      end

    create_table :notifications do |t|
         t.column :active, :boolean, :default => true
         t.timestamps
      end

    create_table :friends do |t|
        t.column :active, :boolean, :default => true
        t.column :firstname, :string, :null => false
        t.column :lastname, :string
        t.column :address, :string
        t.column :birthday, :datetime, :null => false
        t.column :age, :int
        t.column :budget, :int, :default => 10
        t.column :active, :boolean, :default => true
        t.column :keywords, :text
        t.timestamps
      end


    create_table :gifts do |t|
         t.column :url, :string
         t.column :image_url, :string
         t.column :price, :float
         t.column :currency, :string
         t.column :purchased, :boolean, :default => false
         t.column :description, :string
         t.column :title, :string
         t.timestamps
    end
  end
end

#     + Name
#     + Email
#     + Active
#     + Notifications : has
#         * On T/F
#         * Times : has


 #Friends:  Name
 #        + Birthday
 #        + Address
 #        + Age
 #        
 #        + Budget
 #        + Gifts : has
 #            + Item
 #            + Cost
 #            + Purchase Date
 #            + Message
 #        + Active T/F
 #        + Friend has many users -> Shared with other users <?> eg only one person needs to update
#         + friend has many keywords