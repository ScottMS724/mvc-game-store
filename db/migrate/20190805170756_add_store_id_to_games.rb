class AddStoreIdToGames < ActiveRecord::Migration
  
  def change
    add_column :games, :store_id, :integer 
  end
  
end
