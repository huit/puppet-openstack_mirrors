# Class:: openstack_mirrors::params
#
#
class openstack_mirrors::params {
  $mrepo_source = 'git'
  $el_source = 'centos'
  $epel = true
  $el_versions = [ '6-x86_64' ]
  $os_versions = [ 'havana', 'icehouse' ]
  $centos_mirror = 'http://mirror.seas.harvard.edu/centos'
  $epel_mirror = 'http://mirror.seas.harvard.edu/epel'
  $rdo_mirror = 'http://repos.fedorapeople.org/repos/openstack'
  $pl_mirror = 'http://yum.puppetlabs.com/el'
} # Class:: openstack_mirrors::params
