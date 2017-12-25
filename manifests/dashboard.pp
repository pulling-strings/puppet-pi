# pi as a dashboard
class pi::dashboard(
  $user = 'ronen'
){
  package{'xscreensaver':
    ensure  => present
  }

  file_line { 'change default login':
    path => '/etc/lightdm/lightdm.conf',
    line => "autologin-user=${::pi::dashboard::user}"
  }

  file_line { 'remove pi default login':
    path => '/etc/lightdm/lightdm.conf',
    line => 'autologin-user=pi'
  }

}
