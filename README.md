puppet-cloudbackup
==================

Rackspace Cloud Backup Puppet Module

## Module Installation

* Add the 'cloudbackup' folder into your module path
* Include the class and configure the relevant variables for your Rackspace Cloud Backup account:
* __username__ - your rackspace cloud username
* __api_key__ - found under Your Account > API Access here: https://manage.rackspacecloud.com/APIAccess.do

### EXAMPLE

```ruby
class { 'cloudbackup':
username => 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
api_key  => 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
}
```
