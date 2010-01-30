class Regioncode < ActiveRecord::Base
    # Regioncode table has three fields: code_index, code and description
    # code_index has values from 1 to 6 
    # code has a unique value for every entry in the table
    # description contains the name of region; that being municipality, department or commune
    
    # Official translation of terms:
    # Region: Γεωγραφική Περιοχή
    # Department : Νομός
    # Municipality: Δήμος
    # Administrative District : Τ.Δ
    # Commune : Κοινότητα    

    # Here's how I implemented the retrieval:
    
    # code has always a range of 8 ascii characters.  Let's use the entry:
    # code_index, code, description
    # 6;01010101;Μεσολόγγιον,το;
    # as an example.
    
    # the very first character "0" represents the region of Greece where this entry resides; therefore
    # for "0" the region is "ΛΟΙΠΗ ΣΤΕΡΕΑ ΕΛΛΑΣ ΚΑΙ ΕΥΒΟΙΑ"
    
    # the two first characters combined represent the department (Nomos) where this entry resides
    # for "01" the department is "ΝΟΜΟΣ ΑΙΤΩΛΙΑΣ ΚΑΙ ΑΚΑΡΝΑΝΙΑΣ"
    
    # the 4 first characters combined represent the municipality where this entry resides
    # for "0101" the municipality is "ΔΗΜΟΣ ΙΕΡΑΣ ΠΟΛΗΣ ΜΕΣΟΛΟΓΓΙΟΥ"
    
    # the 6 first characters combined represent the administrative district where this entry resides
    # for 010101 the district is "Τ.Δ.Μεσολογγίου"
    
    # and finally the whole 8 characters represent the commune where this entry resides
    # for 01010101 the commune is Μεσολόγγιον
    
    # So the level we use is ΛΟΙΠΗ ΣΤΕΡΕΑ ΕΛΛΑΣ ΚΑΙ ΕΥΒΟΙΑ-> ΝΟΜΟΣ ΑΙΤΩΛΙΑΣ ΚΑΙ ΑΚΑΡΝΑΝΙΑΣ
    # -> ΔΗΜΟΣ ΙΕΡΑΣ ΠΟΛΗΣ ΜΕΣΟΛΟΓΓΙΟΥ->Τ.Δ.Μεσολογγίου->Μεσολόγγιον
    
    # the above combined with the code_index level lets you retrieve the entries quickly, so :
    # for code_index = 1, you get back the geographical region (Γεωγραφική Περιοχή)
    # for code_index = 2, you get back the department (Νομός)
    # for code_index = 4, you get back the municipality (Δήμος)
    # for code_index = 5, you get back the administrative department (Διοικητικό Διαμέρισμα)
    # for code_index = 6, you get back the commune (Οικισμός)
    
    # ActiveRecord is fine but I use find_by_sql 'cause I believe sql engine should do most the 
    # work


    # the implementation is far from perfect but it works.
    # you need to follow some rules:
    # If you want to get communes, you must pass as a parameter to self.commune 
    # a code that refers to a district
    # and if you want to get districts you need to pass as a parameter to self.municipality a code
    # that refers to a department, etc..


    def self.geographical_region(str="")
       # class method returns all the geographical regions if you call it without parameters
       # e.g myRegions = Regioncode.geographical_region(), will return all the regions (that should  be ten)
       # if you call it with parameters, the parameter you pass is the code 
       # e,g, myRegions = Regioncode.geographical_region("01010101"), will give you -> "0" -> ΛΟΙΠΗ ΣΤΕΡΕΑ ΕΛΛΑΣ ΚΑΙ ΕΥΒΟΙΑ

      if str.empty? 
            Regioncode.find_by_sql('select description, code from regioncodes where code_index = 1')
      elsif str.size == 1 # there is only one character (you passed "0", for example) 
            search = str.to_s + "%"
            Regioncode.find_by_sql(["select description, code from regioncodes where code_index = 1 and code like ? ", search])
      elsif str.size > 1 
            search = str[0].to_s + "%"
            Regioncode.find_by_sql(["select description, code from regioncodes where code_index = 1 and code like ? ", search])
      end
          
    end #def self.geographical_region(str="") 

    def self.department(str="")
      if str.empty? 
      	Regioncode.find_by_sql('select description, code from regioncodes where code_index = 2')
      elsif str.size >= 1  # department is defined by 2 character code, for example 01;ΝΟΜΟΣ ΑΙΤΩΛΙΑΣ ΚΑΙ ΑΚΑΡΝΑΝΙΑΣ; you passed a two character code or a 8 character code of which you want to know the department
        search = str[0..1].to_s + "%"
        Regioncode.find_by_sql(["select description, code from regioncodes where code_index = 2 and code like ? ", search])
      end
    end
    
    def self.municipality(str="")
      if str.empty?
        Regioncode.find_by_sql("select description, code from regioncodes where code_index = 4")
      elsif str.size >= 1 
        str = str.to_s
        search = str[0..1]      # grap 2 first characters but different code_level (=4)
        search = search + "%"
        Regioncode.find_by_sql(["select description, code from regioncodes where code_index = 4 and code like ? ", search])
      end
    end 

    def self.administrative_district(str="")
      if str.empty? 
        Regioncode.find_by_sql("select description, code from regioncodes where code_index = 5")
      elsif str.size == 8     # district has always an 8 character code
        str = str.to_s
        search = str[0..4]    # grap first 4 characters
        search = search + "%"
        Regioncode.find_by_sql(["select description, code from regioncodes where code_index = 5 and code like ? ", search])
      end
    end 
    
    def self.commune(str="")
       if str.empty? 
         Regioncode.find_by_sql("select description, code from regioncodes where code_index = 6")
       elsif str.size == 8     #  commune has always an 8 character code
         str = str.to_s
         search = str[0..5]    #  grab first 5 characters but use different code_level (=6)
         search = search + "%"
         Regioncode.find_by_sql(["select description, code from regioncodes where code_index = 6 and code like ? ", search])
       end
     end
    
end 
