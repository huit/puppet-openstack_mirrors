define openstack_mirrors::epel (
  $release,
  $arch,
  $mirror,
) {
  mrepo::repo { "epel-${release}-${arch}":
    ensure    => 'present',
    require   => Class['mrepo'],
    update    => 'nightly',
    repotitle => "EPEL ${release} ${arch}",
    release   => $release,
    arch      => $arch,
    urls      => {
      epel => join([$mirror, '/$release/$arch/'], ''),
    },
  }
}
