class CreateGames < ActiveRecord::Migration
  
  def change
    create_table :games do |t| 
      t.string :name 
      t.string :rating 
    end 
  end
  
end
