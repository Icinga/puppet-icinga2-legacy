require 'spec_helper'

describe 'icinga2_ticket_id' do

  it { should run.with_params('mymaster.example.com', '1234567890').and_return('6dd2a36e73c4bd442f3f6f129ae42cbb597cee2e') }
  it { should run.with_params('mysatellite.example.com', '1234567890').and_return('7ebde03d368bd8128fdb95015d8740f36fcebda2') }

  it { should run.with_params('', '').and_raise_error(Puppet::ParseError) }
  it { should run.with_params('saltempty', '').and_raise_error(Puppet::ParseError) }
  it { should run.with_params('', 'cnempty').and_raise_error(Puppet::ParseError) }
  it { should run.with_params('onlyhostname').and_raise_error(Puppet::ParseError) }
  it { should run.with_params().and_raise_error(Puppet::ParseError) }

end
