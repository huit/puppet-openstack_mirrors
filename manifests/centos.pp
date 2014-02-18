define openstack_mirrors::centos (
  $mirror,
) {
  validate_re(
    $title,
    '^\d+-[[:alnum:]_]+$',
    "'${title}' is not of the form '6-x86_64'."
  )

  $releasearch = split($title, '-')
  validate_array($releasearch)

  $release = $releasearch[0]
  $arch = $releasearch[1]

  mrepo::repo { "centos-${release}-${arch}":
    ensure    => 'present',
    require   => Class['mrepo'],
    update    => 'nightly',
    repotitle => "CentOS ${release} ${arch}",
    release   => $release,
    arch      => $arch,
    urls      => {
      os      => join([$mirror, '/$release/$repo/$arch/'], ''),
      extras  => join([$mirror, '/$release/$repo/$arch/'], ''),
      updates => join([$mirror, '/$release/$repo/$arch/'], ''),
    },
  }

  @@yumrepo { 'centos-base':
    baseurl  => "http://${::fqdn}/centos-${release}-${arch}/RPMS.os",
    descr    => "CentOS ${release} - base",
    enabled  => 1,
    gpgcheck => 0,
    proxy    => 'absent',
  }

  @@yumrepo { 'centos-updates':
    baseurl  => "http://${::fqdn}/centos-${release}-${arch}/RPMS.updates",
    descr    => "CentOS ${release} - updates",
    enabled  => 1,
    gpgcheck => 0,
    proxy    => 'absent',
  }

  @@yumrepo { 'centos-extras':
    baseurl  => "http://${::fqdn}/centos-${release}-${arch}/RPMS.extras",
    descr    => "CentOS ${release} - extras",
    enabled  => 1,
    gpgcheck => 0,
    proxy    => 'absent',
  }
}
