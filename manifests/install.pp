class cloudbackup::install {
  if $osfamily == 'redhat' {
    yumrepo {'drivesrvr':
      enabled  => 1,
      gpgcheck => 0,
      baseurl  => 'http://agentrepo.drivesrvr.com/redhat/',
      descr    => 'drivesrvr'
    }
    package {'driveclient':
      ensure  => latest,
      require => Yumrepo['drivesrvr'],
      notify  => Exec['driveclient --configure'],
    }
    # Not sure why, but it seems to always ask for
    # permission to overwrite the bootstrap.json
    # file first added a 'Y' to the parameters below
    exec {'driveclient --configure':
      command     => "/usr/bin/printf '%s\n' Y ${cloudbackup::username} ${cloudbackup::api_key} | /usr/local/bin/driveclient --configure",
      refreshonly => true,
      require     => Package['driveclient']
    }
  } elsif $osfamily == "debian" {
    $repo_key = "http://agentrepo.drivesrvr.com/debian/agentrepo.key"

    $install_repo_key = "curl $repo_key | apt-key add -"
    $install_repo_key_stop_condition = 'apt-key list | grep -c "Rackspace"'
    $repo_file_name = 'driveclient.list'
    $repo_path = "/etc/apt/sources.list.d/$repo_file_name"

    exec { 'driveclient run apt-update':
      require     => File['driveclient-repo'],
      before      => Package['driveclient'],
      command     => 'apt-get update',
      path        => '/usr/bin/',
      subscribe   => File['driveclient-repo'],
      refreshonly => true,
    }

    exec { 'driveclient-repo-key':
      path    => '/bin:/usr/bin',
      command => $install_repo_key,
      unless  => $install_repo_key_key_stop_condition,
    }

    file { 'driveclient-repo':
      path    => $repo_path,
      mode    => '0644',
      source  => "puppet:///modules/driveclient/$repo_file_name",
      require => Exec['driveclient-repo-key']
    }

    package { 'driveclient':
      ensure  => installed,
      require => File['driveclient-repo'],
    }

  }
}
