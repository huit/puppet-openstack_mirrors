# == Class: openstack_mirrors
#
# Set up mirrors for HUIT OpenStack deployment.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { openstack_mirrors:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Steve Huff <steve_huff@harvard.edu>
#
# === Copyright
#
# Copyright 2014 President and Fellows of Harvard College
#
class openstack_mirrors (
  $el_versions = $openstack_mirrors::params::el_versions,
  $mrepo_source = $openstack_mirrors::params::mrepo_source,
  $centos_mirror = $openstack_mirrors::params::centos_mirror,
  $centos_proto = $openstack_mirrors::params::centos_proto,
) inherits openstack_mirrors::params {

  class { 'mrepo':
    source => $openstack_mirrors::mrepo_source,
  }

  openstack_mirrors::centos { 'centos-6-x86_64':
    release => '6',
    arch    => 'x86_64',
    mirror  => $centos_mirror,
    proto   => $centos_proto,
  }

}
