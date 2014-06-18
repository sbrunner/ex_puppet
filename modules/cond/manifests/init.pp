class cond {
  case $::osfamily {
    'debian': {
      $qualif = 'the best'
    }
    'redhat': {
      $qualif = 'a good'
    }
    'suse': {
      $qualif = 'a bad'
    }
    'windows': {
      $qualif = 'the wroth'
    }
    default: {
      fail('unsupported')
    }
  }
  notice("Running ${qualif} OS.")
  file { '/tmp/os':
    ensure  => file,
    content => "Running ${qualif} OS.",
  }
}
