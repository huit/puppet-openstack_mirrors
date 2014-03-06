define openstack_mirrors::redhat (
) {
  validate_re(
    $title,
    '^[65]-[[:alnum:]_]+$',
    "'${title}' is not of the form '6-x86_64'."
  )

  $releasearch = split($title, '-')
  validate_array($releasearch)

  $rhnreleases = {
    '6' => '6Server',
    '5' => '5Server',
  }

  $release = $releasearch[0]
  $release = $rhnreleases[$release]
  $arch = $releasearch[1]

  mrepo::repo { "redhat-${release}-${arch}":
    ensure     => 'present',
    require    => Class['mrepo'],
    update     => 'nightly',
    repotitle  => "Red Hat Enterprise Linux ${release} ${arch}",
    release    => $release,
    rhnrelease => $rhnrelease,
    arch       => $arch,
    urls       => {
      "rhel${release}-${arch}" => "rhns:///rhel-${arch}-server-${release}",
    },
  }

  @@yumrepo { "rhel${release}-${arch}":
    baseurl  => "http://${::fqdn}/redhat-${release}-${arch}/rhel${release}-${arch}",
    descr    => "Red Hat Enterprise Linux ${release} - base",
    enabled  => 1,
    gpgcheck => 0,
    proxy    => 'absent',
  }
}
