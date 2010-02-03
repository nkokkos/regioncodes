class Regioncode < ActiveRecord::Base
    # Regioncode table has three fields: code_index, code and description
    # code_index has values from 1 to 6 
    # code has a unique for every entry in the table
    # description contains the name of region; that being minicipality, department or commune

    # Here's how I implemented the retrieval:
    
    # code has always a range of 8 ascii characters.  Let's use the entry:
    # code_index, code, description
    # 6;01010101;ÃÂÛÔÎ¸„„ÈÔÌ,ÙÔ;
    # as an example.
    
    # the very first character "0" represents the region of Greece where this entry resides; therefore
    # for "0" the region is "Àœ…–« ”‘≈—≈¡ ≈ÀÀ¡”  ¡… ≈’¬œ…¡"
    
    # the two first characters combined represent the department (Nomos) where this entry resides
    # for "01" the department is "ÕœÃœ” ¡…‘ŸÀ…¡”  ¡… ¡ ¡—Õ¡Õ…¡”"
    
    # the 4 first characters combined represent the municipality where this entry resides
    # for "0101" the municipality is "ƒ«Ãœ” …≈—¡” –œÀ«” Ã≈”œÀœ√√…œ’"
    
    # the 6 first characters combined represent the administrative district where this entry resides
    # for 010101 the district is "‘.ƒ.ÃÂÛÔÎÔ„„ﬂÔı"
    
    # and finally the whole 8 characters represent the commune where this entry resides
    # for 01010101 the commune is ÃÂÛÔÎ¸„„ÈÔÌ
    
    # So the level we use is Àœ…–« ”‘≈—≈¡ ≈ÀÀ¡”  ¡… ≈’¬œ…¡-> ÕœÃœ” ¡…‘ŸÀ…¡”  ¡… ¡ ¡—Õ¡Õ…¡”
    # -> ƒ«Ãœ” …≈—¡” –œÀ«” Ã≈”œÀœ√√…œ’->‘.ƒ.ÃÂÛÔÎÔ„„ﬂÔı->ÃÂÛÔÎ¸„„ÈÔÌ
    
    # the above combined with the code_index level lets you retrive the entries quickly:
    

    
    
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
