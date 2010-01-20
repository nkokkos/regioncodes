class CreateRegioncodes < ActiveRecord::Migration 
  
 def self.up 
   create_table :regioncodes, :force => true do |t| 
     t.integer :code_index  
     t.string :code  
     t.string :description  
    end  
  
  end 
  
  def self.down 
    drop_table :regioncodes  
  end 
  
end 