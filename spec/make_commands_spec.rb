require_relative 'spec_helper'
require_relative 'docker_compose_context'

set :backend, :exec

describe 'build command' do
  before(:all) do
    system('make build')
  end

  it_behaves_like 'a laravel docker compose setup'

  describe 'Able to access localhost' do
    it 'returns a 200 status code' do
      Net::HTTP.start('localhost', 8080) {|http|
        expect(http.head('/').code).to eql("200")
      }
    end
  end

  describe 'php container should have php.ini loaded' do
    describe command('docker-compose exec php sh -c "php --ini"') do
      its(:stdout) { is_expected.to contain('/usr/local/etc/php/php.ini').after('Loaded Configuration File') }
    end
  end
end

describe 'destroy command' do
  before(:all) do
    system('make destroy')
  end

  describe command('docker ps --format "{{.Names}}"') do
    its(:stdout) { is_expected.to eql('') }
  end
end

describe 'rebuild command' do
  before(:all) do
    system('make rebuild')
  end

  it_behaves_like 'a laravel docker compose setup'
end

