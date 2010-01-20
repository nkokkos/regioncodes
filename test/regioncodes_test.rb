 require File.dirname(__FILE__) + '/test_helper.rb' 
 require 'test_helper'

class RegioncodesTest < ActiveSupport::TestCase
  load_schema
  
  class Regioncodes < ActiveRecord::Base
  end
  
   def test_schema_has_loaded_correctly 
     assert_equal [], Regioncodes.all 
   end 
   
end
