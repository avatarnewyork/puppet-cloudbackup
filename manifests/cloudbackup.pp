class cloudbackup($api_key){
  class {'cloudbackup::install':}
  class {'cloudbackup::service':}
}

class cloudbackup::install {
  yumrepo {'drivesrvr':
    enabled => 1,
    gpgcheck => 0,
    baseurl => 'http://agentrepo.drivesrvr.com/redhat/',
    descr => 'drivesrvr'
  }
  
  package {'driveclient':
    ensure => latest,
    require => Yumrepo['drivesrvr'],
    notify => Exec['driveclient --configure'],
  }
  
  exec {'driveclient --configure':
    command => 'driveclient --configure',
    refreshonly => true,
    require => Package['driveclient']
  }

}

class cloudbackup::service {

}
