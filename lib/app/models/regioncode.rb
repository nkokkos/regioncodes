class Regioncode < ActiveRecord::Base
    
    #added class method to return geographical region. Right now Greece is divided into 10 geographical regions
    #( 
    
    def 
       self.geografical_region(str)
         if str.empty? 
      	  Regioncode.find_by_sql('select description, code from regioncodes where code_index = 1')
      else
         str = str.to_s
         search = str[0]  # first character of coderegion refers to geographical region
         search = search + "%"
         Regioncode.find_by_sql(["select description, code from regioncodes where code_index = 1 and code like ? ", search]
      end
    end
   
    def self.nomos(str)
      if str.empty? 
      	Regioncode.find_by_sql('select description, code from regioncodes where code_index = 2')
      else
        str = str.to_s
        search = str[0..1]
        search = search + "%"
        Regioncode.find_by_sql(["select description, code from regioncodes where code_index = 2 and code like ? ", search]
      end
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
