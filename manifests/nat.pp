# Setting NAT for AP mode
class pi::nat(
  $lan='',
  $ap=''
) {
  package{'uwf':
    ensure  => absent
  }
  # the file the holds the nat rules
  file { '/usr/bin/routing':
    ensure  => file,
    mode    => '0644',
    content => template('pi/routing.erb'),
    owner   => root,
    group   => root,
  }

  package{'dnsmasq':
    ensure  => present
  } ->

  file { '/etc/dnsmasq.conf':
    ensure => file,
    mode   => '0644',
    source => 'puppet:///modules/pi/dnsmasq.conf',
    owner  => root,
    group  => root,
  } ~>

  service{'dhcpcd':
    ensure    => running,
    enable    => true,
    hasstatus => true,
  }

  include 'rclocal'

  rclocal::update{ 'iptables restore':
    content => 'iptables-restore < /etc/iptables.ipv4.nat'
  }
}
