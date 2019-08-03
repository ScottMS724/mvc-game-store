class Game < ActiveRecord::Base
  belongs_to :store 
  
  def self.valid_params?(params)
    return !params[:name].empty? && !params[:rating].empty?
  end 
  
end 