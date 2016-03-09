require 'spec_helper'
require 'variants'

describe 'icinga2::object::apply_scheduleddowntime' do

  let(:facts) do
    on_supported_os['debian-8-x86_64']
  end

  let :pre_condition do
    "include 'icinga2'"
  end

  context 'with basic parameters' do
    let(:title) { 'testdowntime' }

    let(:params) do
      {
        :assign_where => 'host.vars.stage == "test"',
        :author       => 'spectest',
        :comment      => 'spectest',
        :ranges       => {
          'sunday' => '02:00-03:00'
        }
      }
    end

    object = 'icinga2 apply scheduleddowntime testdowntime'
    object_file = '/etc/icinga2/objects/apply_scheduleddowntimes/testdowntime.conf'

    it { should contain_icinga2__object__apply_scheduleddowntime('testdowntime') }
    it { should contain_file(object).with({
          :ensure => 'file',
          :path => object_file,
          :content => /apply ScheduledDowntime "testdowntime" to Service/,
        }) }
    it { should contain_file(object).with_content(/^\s*author = "spectest"/) }
    it { should contain_file(object).with_content(/^\s*comment = "spectest"/) }
    it { should contain_file(object).with_content(/^\s*assign where host.vars.stage == "test"/) }
    it { should contain_file(object).with_content(/^\s*ranges = {\n\s*"sunday" = "02:00-03:00"\n\s*}/) }
    it { should contain_file(object).without_content(/^\s*fixed = /) }
    it { should contain_file(object).without_content(/^\s*duration = /) }
  end

  context 'with all parameters' do
    let(:title) { 'testdowntime2' }

    let(:params) do
      {
        :apply        => 'Host',
        :assign_where => 'host.vars.stage == "meh"',
        :ignore_where => 'host.vars.foobar',
        :author       => 'spectest',
        :comment      => 'spectest',
        :ranges       => {
          'sunday' => '02:00-03:00',
          'monday' => '01:00-04:00'
        },
        :fixed        => true,
        :duration     => '30m'
      }
    end

    object = 'icinga2 apply scheduleddowntime testdowntime2'
    object_file = '/etc/icinga2/objects/apply_scheduleddowntimes/testdowntime2.conf'

    it { should contain_icinga2__object__apply_scheduleddowntime('testdowntime2') }
    it { should contain_file(object).with({
      :ensure => 'file',
      :path => object_file,
      :content => /apply ScheduledDowntime "testdowntime2" to Host/,
    }) }
    it { should contain_file(object).with_content(/^\s*author = "spectest"/) }
    it { should contain_file(object).with_content(/^\s*comment = "spectest"/) }
    it { should contain_file(object).with_content(/^\s*ranges = {\n\s*"monday" = "01:00-04:00"\n\s*"sunday" = "02:00-03:00"\n\s*}/) }

    it { should contain_file(object).with_content(/^\s*ignore where host.vars.foobar/) }

    it { should contain_file(object).with_content(/^\s*fixed = true/) }
    it { should contain_file(object).with_content(/^\s*duration = 30m/) }

  end
end
