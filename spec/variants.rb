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
      },
      'Ubuntu trusty' => {
        :osfamily                  => 'Debian',
        :operatingsystem           => 'Ubuntu',
        :operatingsystemrelease    => '14.04',
        :operatingsystemmajrelease => '14.04',
        :lsbdistcodename           => 'trusty',
        :lsbdistid                 => 'ubuntu',
      },
      'RedHat 6' => {
        :osfamily                  => 'RedHat',
        :operatingsystem           => 'RedHat',
        :operatingsystemrelease    => '6.6',
        :operatingsystemmajrelease => '6',
        #:lsbdistcodename          => '',
        #:lsbdistid                => 'ubuntu',
      },
    }
  end

end
