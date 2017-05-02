# Setting up an access point
class pi::hostapd {
  package{'hostapd':
    ensure  => present
  } ->

  file { '/etc/hostapd.conf':
    ensure=> file,
    mode  => '0644',
    content => template('pi/hostapd.conf.erb'),
    owner => root,
    group => root,
  } ->

  file_line { 'configuration':
    path => '/etc/default/hostapd',
    line => 'DAEMON_CONF="/etc/hostapd/hostapd.conf'
  }
}
