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
}
