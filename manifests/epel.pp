define openstack_mirrors::epel (
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
