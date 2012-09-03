require 'spec_helper'

describe 'cloudbackup' do
  let(:title) { 'test'}
  let(:params) { {:username => 'rackspace', :api_key => 'xxxxxxxxxx'} }  
  let(:facts) { {:operatingsystem => ['CentOS','Fedora']}}
  
  it { should include_class('cloudbackup::install')}
  it { should include_class('cloudbackup::service')}

  context "On a RedHat OS" do
    let :facts do
      {
        :osfamily => 'RedHat'
      }
    end
    it {
      should contain_package('driveclient')
      should contain_service('driveclient')
    }
  end
end
