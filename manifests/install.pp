class cloudbackup::install {
  yumrepo {'drivesrvr':
    enabled  => 1,
    gpgcheck => 0,
    baseurl  => 'http://agentrepo.drivesrvr.com/redhat/',
    descr    => 'drivesrvr'
  }
  package {'driveclient':
    ensure  => present,
    require => Yumrepo['drivesrvr'],
  }
  # Not sure why, but it seems to always ask for
  # permission to overwrite the bootstrap.json
  # file first added a 'Y' to the parameters below
  exec {'driveclient --configure':
    command     => "/usr/bin/printf '%s\n' ${cloudbackup::username} ${cloudbackup::api_key} | /usr/local/bin/driveclient --configure",
    unless			=> "/bin/grep IsRegistered /etc/driveclient/bootstrap.json | /bin/grep -q true",	
  }
}
