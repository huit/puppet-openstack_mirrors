define openstack_mirrors::centos (
  $release,
  $arch,
  $mirror,
  $proto,
) {
  mrepo::repo { "centos-${release}-${arch}":
    ensure    => 'present',
    require   => Class['mrepo'],
    update    => 'nightly',
    repotitle => "CentOS ${release} ${arch}",
    release   => $release,
    arch      => $arch,
    urls      => {
      extras  => join(["${proto}://${mirror}", '/$release/$repo/$arch/'], ''),
      updates => join(["${proto}://${mirror}", '/$release/$repo/$arch/'], ''),
    },
  }
}
