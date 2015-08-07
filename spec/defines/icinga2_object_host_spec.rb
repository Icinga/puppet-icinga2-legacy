require 'spec_helper'
require 'variants'

describe 'icinga2::object::host' do

  default = 'Debian wheezy'

  context "on default #{default} with basic parameters" do
    let :facts do
      IcingaPuppet.variants[default]
    end
    let :pre_condition do
      "class { 'icinga2':
      }"
    end

    let(:title) { 'testhost' }

    # TODO: should be removed with refactoring
    let(:params) do
      {
        :object_hostname => 'testhost',
        :display_name => 'testhost',
        :target_file_name => 'testhost.conf',
        :ipv4_address => '1.1.1.1',
      }
    end

    object_file = '/etc/icinga2/objects/hosts/testhost.conf'
    it { should contain_icinga2__object__host('testhost') }
    it { should contain_file(object_file).with({
          :ensure => 'file',
          :path => '/etc/icinga2/objects/hosts/testhost.conf',
          :content => /object Host "testhost"/,
        }) }
    it { should contain_file(object_file).with_content(/^\s*import "generic-host"$/) }
    it { should contain_file(object_file).with_content(/^\s*display_name = "testhost"$/) }
    it { should contain_file(object_file).with_content(/^\s*address = "1.1.1.1"$/) }

  end

  context "on default #{default} with vars hash" do
    let :facts do
      IcingaPuppet.variants[default]
    end
    let :pre_condition do
      "class { 'icinga2':
      }"
    end

    let(:title) { 'testhost' }

    let(:params) do
      {
        :object_hostname => 'testhost',
        :display_name => 'testhost',
        :target_file_name => 'testhost.conf',
        :vars => {
          'hash_test' => {
            'hash_var1' => 'test',
            'subhash' => {
              'hash_var2' => [ 'subarray1' ],
              'subsubhash' => {
                'hash_var3' => 1234,
              },
            },
          },
          'array' => ['array1', 'array2', 'array3'],
          'integer' => 1234,
          'float' => 1234.0,
          'string' => 'teststring',
          'bool1' => true,
          'bool2' => false,
          'other' => nil,
          "evil\"\nvar" => "evil\"\nvalue",
          'oldstyle' => '"damn string"',
        },
      }
    end

    object_file = '/etc/icinga2/objects/hosts/testhost.conf'
    it { should contain_icinga2__object__host('testhost') }
    it { should contain_file(object_file).with({
          :ensure => 'file',
          :path => '/etc/icinga2/objects/hosts/testhost.conf',
          :content => /object Host "testhost"/,
        }) }
    it { should contain_file(object_file).with_content(/^\s*vars \+= {$/) }
    it { should contain_file(object_file).with_content(/^\s*"array" = \[\n\s+"array1",\n/) }
    it { should contain_file(object_file).with_content(/^\s*"hash_test" = {\n\s+"hash_var1" = "test"\n/) }
    it { should contain_file(object_file).with_content(/^\s*"float.*1234\.0/) }
    it { should contain_file(object_file).with_content(/^\s*"integer.*1234/) }
    it { should contain_file(object_file).with_content(/^\s*"string" = "teststring"$/) }
    it { should contain_file(object_file).with_content(/^\s*"oldstyle" = "damn string"$/) }

  end

  context "on default #{default} with all parameters" do
    pending
  end

end
