require 'serverspec'
require 'docker/compose'
require 'rspec/wait'
require 'net/http'

RSpec.configure do |config|
  config.wait_timeout = 15 # seconds

  compose = Docker::Compose.new

  config.before(:all) do
    compose.up(detached: true, build: true)
  end

  config.after(:all) do
    compose.kill
    compose.rm(force: true)
  end
end
