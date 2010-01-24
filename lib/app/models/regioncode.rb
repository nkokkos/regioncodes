class Regioncode < ActiveRecord::Base
   
    def self.nomos
      Regioncode.find_by_sql('select description, code from regioncodes where code_index = 2')
    end
    
    def self.dhmotiko_diamerisma(str)
      str = str.to_s
      search = str[0..1]
      search = search + "%"
      Regioncode.find_by_sql(["select description, code from regioncodes where code_index = 5 and code like ? ", search])
    end 
    
    def self.dhmos_or_oikismos(str)
      str = str.to_s
      search = str[0..5]
      search = search + "%"
      Regioncode.find_by_sql(["select description, code from regioncodes where code_index = 6 and code like ? ", search])
    end
    
end 
