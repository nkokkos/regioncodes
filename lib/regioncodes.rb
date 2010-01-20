
Dir.glob(File.join(File.dirname(__FILE__), "db", "migrate", "*")).each do |file| 
  require file 
end 

%w{ models }.each do |dir| 
  path = File.join(File.dirname(__FILE__), 'app', dir)  
  $LOAD_PATH << path
  ActiveSupport::Dependencies.load_paths << path 
  ActiveSupport::Dependencies.load_once_paths.delete(path) 
end
