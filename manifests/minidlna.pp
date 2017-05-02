# Setting up minidlna
class pi::minidlna {
  package{'minidlna':
    ensure  => present
  }

  file {'/etc/minidlna.conf':
    ensure => file,
    mode   => '0644',
    source => 'puppet:///modules/pi/minidlna.conf',
    owner  => root,
    group  => root,
  }

  file {'/etc/default/minidlna':
    ensure => file,
    mode   => '0644',
    source => 'puppet:///modules/pi/minidlna',
    owner  => root,
    group  => root,
  }
}
