define openstack_mirrors::foreman (
  $release,
  $arch,
  $mirror,
) {
  mrepo::repo { "foreman-${release}-${arch}":
    ensure    => 'present',
    require   => Class['mrepo'],
    update    => 'nightly',
    repotitle => "Puppet Labs ${release} ${arch}",
    release   => $release,
    arch      => $arch,
    urls      => {
      releases => join([$mirror, '/$repo/$release/el6/$arch/'], ''),
      plugins  => join([$mirror, '/$repo/$release/el6/$arch/'], ''),
    },
  }
}
