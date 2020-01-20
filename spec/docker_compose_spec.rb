require_relative 'spec_helper'

set :backend, :exec

describe 'Right containers are running' do
  describe command('docker ps --format "{{.Names}}"') do
    its(:stdout) { is_expected.to match(/nginx/) }
    its(:stdout) { is_expected.to match(/php/) }
    its(:stdout) { is_expected.to match(/postgres/) }
  end
end

describe 'Able to access localhost' do
  it 'returns a 200 status code' do
    Net::HTTP.start('localhost', 8080) {|http|
      expect(http.head('/').code).to eql("200")
    }
  end
end
