require_relative 'spec_helper'
require_relative 'docker_compose_context'

set :backend, :exec

describe 'build command' do
  before do
    system('make build')
  end

  it_behaves_like 'a laravel docker compose setup'
end

describe 'rebuild command' do
  before do
    system('make rebuild')
  end

  it_behaves_like 'a laravel docker compose setup'
end

