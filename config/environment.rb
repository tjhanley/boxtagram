# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Boxtagram::Application.initialize!

require 'yaml'
YAML::ENGINE.yamler = 'syck'