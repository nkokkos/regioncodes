class Regioncode < ActiveRecord::Base
   
   def self.nomos
      Regioncode.find_by_sql('select description, code from regioncodes where code_index=2')
    end
    
    def self.dhmotiko_diamerisma
      Regioncode.find_by_sql('select description, code from regioncodes where code_index=5')
    end 
    
    def self.dhmos_or_oikismos
      Regioncode.find_by_sql('select description, code from regioncodes where code_index=6')
    end
    
end 