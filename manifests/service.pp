class cloudbackup::service {
  service {'driveclient':
    ensure => running,
    enable => true,
    require=> Class['cloudbackup::install'],
  }
}
