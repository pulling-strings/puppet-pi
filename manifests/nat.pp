# Nat routing and iptables blocking
class pi::nat (
  $lan = 'eth0',
  $ap= 'wlan0'
){
  # the file the holds the nat rules
  file { '/usr/bin/routing':
    ensure  => file,
    mode    => '0644',
    content => template('pi/routing.erb'),
    owner   => root,
    group   => root,
  }

  include 'rclocal'

  rclocal::update{ 'iptables restore':
    content => 'iptables-restore < /etc/iptables.ipv4.nat'
  }


}
