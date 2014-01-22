define openstack_mirrors::rdo (
  $release,
  $el_release,
  $mirror,
) {
  mrepo::repo { "rdo-${release}-el${el_release}":
    ensure    => 'present',
    require   => Class['mrepo'],
    update    => 'nightly',
    repotitle => "RDO ${release} EL${el_release}",
    release   => $release,
    urls      => {
      rdo => join([$mirror, '/openstack-$release/', "epel-${el_release}"], ''),
    },
  }
}
