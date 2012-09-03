import '*'

class cloudbackup($username, $api_key){
  class {'cloudbackup::install':}
  class {'cloudbackup::service':}
}
