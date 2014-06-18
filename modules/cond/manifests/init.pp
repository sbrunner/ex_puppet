class cond {
  $content = $::osfamily ? {
    'debian' => 'Running the best OS.',
    'redhat' => 'Running a bood OS.',
    'suse' => 'Running a bad OS.',
    'windows' => 'Running the wroth OS.',
  }
  file { '/tmp/os':
    ensure  => file,
    content => $content,
  }
}
