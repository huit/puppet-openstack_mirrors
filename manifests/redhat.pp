define openstack_mirrors::redhat (
  $uuid,
) {
  validate_re(
    $title,
    '^\d+-[[:alnum:]_]+$',
    "'${title}' is not of the form '6-x86_64'."
  )

  $rhnreleases = {
    '6' => '6Server',
    '5' => '5Server',
  }

  $releasearch = split($title, '-')
  validate_array($releasearch)

  $release = $releasearch[0]
  $rhnrelease = $rhnreleases[$release]
  $arch = $releasearch[1]

  file { '/etc/sysconfig/rhn/up2date-uuid':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template('openstack_mirrors/etc/sysconfig/rhn/up2date-uuid.erb'),
  } ->

  file { '/etc/sysconfig/rhn/sources':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => 'up2date default',
  } ->

  mrepo::repo { "redhat-${release}-${arch}":
    ensure    => 'present',
    require   => Class['mrepo'],
    update    => 'nightly',
    repotitle => "Red Hat Enterprise Linux ${release} ${arch}",
    release   => $rhnrelease,
    type      => 'rhn',
    arch      => $arch,
    urls      => {
      "rhel${release}-${arch}"                    => "rhns:///rhel-${arch}-server-${release}",
      "jbappplatform-6-${arch}-server-${release}" => "rhns:///jbappplatform-6-${arch}-server-${release}",
      "jb-ews-2-${arch}-server-${release}"        => "rhns:///jb-ews-2-${arch}-server-${release}",
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
