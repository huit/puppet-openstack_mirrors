# Class:: openstack_mirrors::params
#
#
class openstack_mirrors::params {
  $mrepo_source = 'git'
  $el_versions = [ 6 ]
  $centos_mirror = 'http://mirror.seas.harvard.edu/centos'
  $centos_proto = 'http'
} # Class:: openstack_mirrors::params
