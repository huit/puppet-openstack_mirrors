define openstack_mirrors::foreman (
  $release,
  $arch,
  $mirror,
) {
  mrepo::repo { "foreman-${release}-${arch}":
    ensure    => 'present',
    require   => Class['mrepo'],
    update    => 'nightly',
    repotitle => "Foreman ${release} ${arch}",
    release   => $release,
    arch      => $arch,
    urls      => {
      releases => join([$mirror, '/$repo/$release/el6/$arch/'], ''),
      plugins  => join([$mirror, '/$repo/$release/el6/$arch/'], ''),
    },
  }

  @@yumrepo { "foreman-${release}":
    baseurl  => "http://${::fqdn}/foreman-${release}-${arch}/RPMS.releases",
    descr    => "Foreman ${release}",
    enabled  => 1,
    gpgcheck => 0,
    proxy    => 'absent',
  }

  @@yumrepo { "foreman-plugins-${release}":
    baseurl  => "http://${::fqdn}/foreman-${release}-${arch}/RPMS.plugins",
    descr    => "Foreman ${release} plugins",
    enabled  => 1,
    gpgcheck => 0,
    proxy    => 'absent',
  }
}
