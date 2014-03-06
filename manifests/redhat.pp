define openstack_mirrors::redhat (
) {
  validate_re(
    $title,
    '^\d+-[[:alnum:]_]+$',
    "'${title}' is not of the form '6-x86_64'."
  )

  $releasearch = split($title, '-')
  validate_array($releasearch)

  $release = $releasearch[0]
  $rhnrelease = $rhnreleases[$release]
  $arch = $releasearch[1]

  mrepo::repo { "redhat-${release}-${arch}":
    ensure    => 'present',
    require   => Class['mrepo'],
    update    => 'nightly',
    repotitle => "Red Hat Enterprise Linux ${release} ${arch}",
    release   => $release,
    type      => 'rhn',
    arch      => $arch,
    urls      => {
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
