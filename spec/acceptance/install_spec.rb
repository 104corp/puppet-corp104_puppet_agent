require 'spec_helper_acceptance'

describe 'install corp104_puppet_agent' do
  context 'default parameters' do
    it 'should install package' do
      pp = "class { 'corp104_puppet_agent': }"

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end
  end
end

describe 'upgrade puppet 5 corp104_puppet_agent' do
  context 'default parameters' do
    it 'should install package' do
      pp = <<-EOS
        class { 'corp104_puppet_agent':
          puppet_version => '5.0.1',
        }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end
  end
end

describe 'downgrade puppet 4 corp104_puppet_agent' do
  context 'default parameters' do
    it 'should install package' do
      pp = <<-EOS
        class { 'corp104_puppet_agent':
          puppet_version => '1.10.6',
        }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end
  end
end