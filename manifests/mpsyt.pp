# Setting up https://github.com/np1/mps-youtube/blob/master/mpsyt
class pi::mpsyt {
  class { 'python':
    version    => 'system',
    virtualenv => present,
    dev        => absent,
    gunicorn   => absent,
  }

  python::virtualenv { '/var/mpsyt':
    ensure     => present,
    version    => 'system',
    systempkgs => true,
    distribute => false,
    cwd        => '',
    timeout    => 0,
  } ->

  python::pip { 'mps-youtube':
    pkgname    => 'mps-youtube',
    virtualenv => '/var/mpsyt',
  }

  package{'mplayer':
    ensure  => present
  }

}
