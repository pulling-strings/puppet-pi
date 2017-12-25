# Desktop cleanup and setup
class pi::desktop {
  $libreoffice = ['libreoffice-base-core', 'libreoffice-common', 'libreoffice-core',
                  'libreoffice-gtk', 'libreoffice-math', 'libreoffice-style-elementary',
                  'libreoffice-style-galaxy', 'libreoffice-writer', 'libreoffice-calc']

  package{$libreoffice:
    ensure  => absent
  }

  $development = ['geany', 'wolfram-engine', 'bluej', 'minecraft-pi',
                  'greenfoot', 'scratch', 'scratch2', 'python3-thonny']

  package{$development:
    ensure  => absent
  }

  package{'xscreensaver':
    ensure  => present
  }
}
