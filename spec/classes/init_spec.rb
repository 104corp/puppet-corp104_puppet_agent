require 'spec_helper'

describe 'corp104_puppet_agent', :type => 'class' do
  context 'with defaults for all parameters' do
    let(:facts) do
      { 
        :os => { :family => 'Debian', :name => 'Ubuntu', :release => { :major => '16.04', :full => '16.04' }},
        :lsbdistrelease  => '16.04',
        :lsbdistid       => 'Ubuntu',
        :osfamily        => 'Debian',
        :lsbdistcodename => 'xenial',
      }
    end
    it do
      should contain_class('corp104_puppet_agent')
      should contain_class('corp104_puppet_agent::config')
      should contain_class('corp104_puppet_agent::service')
    end

    it do
      should compile.with_all_deps
    end

    describe "modify puppet version" do
      let(:params) { {'puppet_version' => '5.0.1'} }
      it { is_expected.to contain_package('puppet-agent').with_ensure('5.0.1-1xenial') }
    end

  end
end