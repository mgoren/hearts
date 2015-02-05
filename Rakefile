require("sinatra/activerecord")
require("sinatra/activerecord/rake")

Dir[File.dirname(__FILE__) + '/lib/*'].each { |file| require file }

namespace(:db) do
  task(:load_config)
end
