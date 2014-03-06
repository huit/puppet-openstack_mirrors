define openstack_mirrors::redhat (
  $mirror,
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
    ensure    => 'present',
    require   => Class['mrepo'],
    update    => 'nightly',
    repotitle => "Red Hat Enterprise Linux ${release} ${arch}",
    release   => $release,
    arch      => $arch,
    urls      => {
      os      => join([$mirror, '/$release/$repo/$arch/'], ''),
      extras  => join([$mirror, '/$release/$repo/$arch/'], ''),
      updates => join([$mirror, '/$release/$repo/$arch/'], ''),
    },
  }

  @@yumrepo { 'redhat-base':
    baseurl  => "http://${::fqdn}/redhat-${release}-${arch}/RPMS.os",
    descr    => "Red Hat Enterprise Linux ${release} - base",
    enabled  => 1,
    gpgcheck => 0,
    proxy    => 'absent',
  }

  @@yumrepo { 'redhat-updates':
    baseurl  => "http://${::fqdn}/redhat-${release}-${arch}/RPMS.updates",
    descr    => "Red Hat Enterprise Linux ${release} - updates",
    enabled  => 1,
    gpgcheck => 0,
    proxy    => 'absent',
  }

  @@yumrepo { 'redhat-extras':
    baseurl  => "http://${::fqdn}/redhat-${release}-${arch}/RPMS.extras",
    descr    => "Red Hat Enterprise Linux ${release} - extras",
    enabled  => 1,
    gpgcheck => 0,
    proxy    => 'absent',
  }
}
