require 'fastercsv'

namespace :db do
  namespace :migrate do
  
 desc "This will migrate your table"
  task :regioncodes => :environment do  
      ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true 
      ActiveRecord::Migrator.migrate("vendor/plugins/regioncodes/lib/db/migrate/", ENV["VERSION"] ? ENV["VERSION"].to_i : nil)  
      Rake::Task["db:schema:dump"].invoke if ActiveRecord::Base.schema_format == :ruby  
    end
  end
end

namespace :regioncodes do 
  desc "This task will insert data into the table"
  task :insertdata => :environment do  
  puts "Reading number of lines to parse..."
  lines = File.readlines("#{RAILS_ROOT}/vendor/plugins/regioncodes/data/test_data2.csv")
  puts "Lines to parse and import: " + (lines.length).to_s
  puts "Started importing data..."
  puts "Percent completed:"
  @counter = 0
  @number_of_lines = (lines.length).to_f

    FasterCSV.foreach("#{RAILS_ROOT}/vendor/plugins/regioncodes/data/test_data2.csv", :headers => true, :col_sep => ';', :row_sep => "\r\n") do |row|
        Regioncode.create(:code_index => row[0], :code => row[1], :description => row[2])
          @counter = @counter +1.0
          print "\r#{"%4.2f" % ((@counter/@number_of_lines)*100) }"
      end
    end
end