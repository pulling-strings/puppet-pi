# basic firewall lockout
class pi::iptables(
  $network = '192.168.0.0/24',
  $gateway = '192.168.0.1',
  $broadcast = '192.168.0.255',
  $ssh_port = '22'
){

  file { '/etc/network/if-pre-up.d/firewall':
    ensure => file,
    source => 'puppet:///modules/pi/firewall',
    mode   => 'a+x',
    owner  => root,
    group  => root,
  } ->

  file { '/etc/network/iptables':
    ensure  => file,
    mode    => '0644',
    content => template('pi/iptables.erb'),
    owner   => root,
    group   => root,
  } ~>

  exec{'/etc/network/if-pre-up.d/firewall':
    user => 'root',
    path => ['/usr/bin','/bin',]
  }
}
