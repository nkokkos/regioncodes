ActiveRecord::Schema.define(:version => 0) do  
  
  create_table :regioncodes, :force => true do |t| 
    t.integer :code_index  
    t.string :code  
    t.string :description  
   end  
  
  end 