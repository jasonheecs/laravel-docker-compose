require 'serverspec'
require 'rspec/wait'
require 'net/http'

RSpec.configure do |config|
  config.wait_timeout = 15 # seconds

  config.after(:suite) do
    system('make destroy')
  end
end
