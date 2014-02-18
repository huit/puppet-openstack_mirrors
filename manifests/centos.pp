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
  validate_slength($releasearch, 2)

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
      extras  => join([$mirror, '/$release/$repo/$arch/'], ''),
      updates => join([$mirror, '/$release/$repo/$arch/'], ''),
    },
  }
}
