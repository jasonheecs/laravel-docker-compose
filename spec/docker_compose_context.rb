shared_examples 'a laravel docker compose setup' do
  describe command('docker ps --format "{{.Names}}"') do
    its(:stdout) { is_expected.to match(/nginx/) }
    its(:stdout) { is_expected.to match(/php/) }
    its(:stdout) { is_expected.to match(/postgres/) }
  end
end
