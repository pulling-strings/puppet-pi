# making eth0 to wlan0 brigding see:
# 1.http://bit.ly/1mWquA5
# 2. http://bit.ly/1jpunN6
class pi::gateway(
  $address='192.168.1.1',
  $network ='192.168.0.1',
  $broadcast='192.168.1.255',
  $subnet='192.168.1.0/24',
  $range ='192.168.1.15,192.168.1.150,12h',
  $interface = 'wlan0',
  $wireless = false,
  $server = '8.8.8.8'
){

  file { '/etc/network/interfaces':
    ensure  => file,
    mode    => '0644',
    content => template('pi/interfaces.erb'),
    owner   => root,
    group   => root,
  } ~>

  service{'networking':
    ensure    => running,
    enable    => true,
    hasstatus => true,
  } ~> Service['dnsmasq']

  package{'dnsmasq':
    ensure  => present
  } ->

  file { '/etc/dnsmasq.conf':
    ensure  => file,
    mode    => '0644',
    content => template('pi/dnsmasq.conf.erb'),
    owner   => root,
    group   => root,
  }

  service{'dnsmasq':
    ensure    => running,
    enable    => true,
    hasstatus => true,
  }

  package{'ifplugd':
    ensure  => absent
  }

  service{'ifplugd':
    ensure => stopped,
    enable => false,
  }

  file_line { 'ipv4_forwarding':
    path => '/etc/sysctl.conf',
    line => 'net.ipv4.ip_forward=1'
  }
}
