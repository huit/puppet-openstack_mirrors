define openstack_mirrors::pl (
  $release,
  $arch,
  $mirror,
) {
  mrepo::repo { "pl-${release}-${arch}":
    ensure    => 'present',
    require   => Class['mrepo'],
    update    => 'nightly',
    repotitle => "Puppet Labs ${release} ${arch}",
    release   => $release,
    arch      => $arch,
    urls      => {
      dependencies => join([$mirror, '/$release/$repo/$arch/'], ''),
      products     => join([$mirror, '/$release/$repo/$arch/'], ''),
    },
  }

  @@yumrepo { 'puppetlabs':
    baseurl  => "http://${::fqdn}/pl-${release}-${arch}/RPMS.products",
    descr    => 'Puppet Labs Products',
    enabled  => 1,
    gpgcheck => 0,
    proxy    => 'absent',
  }

  @@yumrepo { 'puppetlabs-dependencies':
    baseurl  => "http://${::fqdn}/pl-${release}-${arch}/RPMS.dependencies",
    descr    => 'Puppet Labs Dependencies',
    enabled  => 1,
    gpgcheck => 0,
    proxy    => 'absent',
  }
}
