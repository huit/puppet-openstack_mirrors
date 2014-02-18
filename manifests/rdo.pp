define openstack_mirrors::rdo (
  $release,
  $el_release,
  $mirror,
  $arch = 'x86_64',
) {
  mrepo::repo { "rdo-${release}-el${el_release}":
    ensure    => 'present',
    require   => Class['mrepo'],
    update    => 'nightly',
    repotitle => "RDO ${release} EL${el_release}",
    release   => $release,
    arch      => $arch,
    urls      => {
      rdo => join([$mirror, '/openstack-$release/', "epel-${el_release}"], ''),
    },
  }

  @@yumrepo { "rdo-${release}":
    baseurl  => "http://${::fqdn}/rdo-${release}-${arch}/RPMS.rdo",
    descr    => "RDO ${release} for EPEL ${el_release}",
    enabled  => 1,
    gpgcheck => 0,
    proxy    => 'absent',
  }
}
