# Setting up dropbear instead of openssh conserving resources
class pi::dropbear(
  $port = '2222'
){
  package{['openssh-client', 'dropbear']:
    ensure  => present
  } ->

  exec{'enable dropbear':
    command => "sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear",
    user    => 'root',
    path    => ['/bin']
  } ->

  editfile::config { 'dropbear port':
    ensure => $port,
    path   => '/etc/default/dropbear',
    quote  => false,
    sep    => '=',
    entry  => 'DROPBEAR_PORT',
  }


  if($environment != 'dev'){
    service{'dropbear':
      ensure    => running,
      enable    => true,
      hasstatus => true,
      require   => Editfile::Config['dropbear port']
    }

    package{'raspi-config':
      ensure  => present
    }

    service{'ssh':
      ensure    => stopped,
      enable    => false,
    } ->

    package{'openssh-server':
      ensure  => absent
    }
  }
}
