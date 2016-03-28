# Tiny first gen pi profile
class pi::profiles::tiny {
  include pi::ssh
  include pi::tty
  include pi::shell
  include pi::swap
  include pi::bootlog
  include pi::ipv6

  exec{'noop scheduler':
    command => "/bin/sed -i 's/deadline/noop/g' /boot/cmdline.txt",
    user    => 'root',
    onlyif  => '/usr/bin/test -f /boot/cmdline.txt'
  }

  package{'mlocate':
    ensure  => present
  }

  class {'::shell':
    include => false
  }

  class{ '::shell::tmux':
    tmuxinator => false,
    conffile   => '.tmux.conf'
  }

}
