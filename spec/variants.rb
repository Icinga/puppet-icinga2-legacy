class IcingaPuppet
  def self.variants
    {
      'Debian wheezy' => {
        :osfamily                  => 'Debian',
        :operatingsystem           => 'Debian',
        :operatingsystemrelease    => '7.8',
        :operatingsystemmajrelease => '7',
        :lsbdistcodename           => 'wheezy',
        :lsbdistid                 => 'debian',
        :path                      => '/dummy',
        :nrpe_daemon_name          => 'nagios-nrpe-server',
      },
      'Ubuntu trusty' => {
        :osfamily                  => 'Debian',
        :operatingsystem           => 'Ubuntu',
        :operatingsystemrelease    => '14.04',
        :operatingsystemmajrelease => '14.04',
        :lsbdistcodename           => 'trusty',
        :lsbdistid                 => 'ubuntu',
        :path                      => '/dummy',
        :nrpe_daemon_name          => 'nagios-nrpe-server',
      },
      'RedHat 6' => {
        :osfamily                  => 'RedHat',
        :operatingsystem           => 'RedHat',
        :operatingsystemrelease    => '6.6',
        :operatingsystemmajrelease => '6',
        #:lsbdistcodename          => '',
        #:lsbdistid                => 'ubuntu',
        :path                      => '/dummy',
        :nrpe_daemon_name          => 'nrpe',
      },
      'FreeBSD 10.2' => {
          :osfamily                  => 'FreeBSD',
          :operatingsystem           => 'FreeBSD',
          :operatingsystemrelease    => '10.2-RELEASE',
          :operatingsystemmajrelease => '10',
          :path                      => '/dummy',
          #:nrpe_daemon_name          => 'nrpe',
      },
    }
  end
end
