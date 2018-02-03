# Medium first gen pi profile
class pi::profiles::medium {
  include pi::shell

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
