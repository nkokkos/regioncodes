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
    FasterCSV.foreach("#{RAILS_ROOT}/tmp/data3.csv", :headers => true, :col_sep => ';', :row_sep => "\r\n") do |row|
        Regioncodes.create(:code_index => row[0])
        puts row[0]
      end
    end
end