class cond {
    class { 'staging':
      path  => '/var/staging',
      owner => 'puppet',
      group => 'puppet',
    }
    ::staging::file { 'apache-tomcat-6.0.41.tar.gz':
      source => 'http://apache.cs.utah.edu/tomcat/tomcat-6/v6.0.41/bin/apache-tomcat-6.0.41-deployer.tar.gz',
    }
    ::staging::extract { 'apache-tomcat-6.0.41.tar.gz':
      target  => '/var/staging',
      creates => '/var/staging/apache-tomcat-6.0.41',
      require => Staging::File['apache-tomcat-6.0.41.tar.gz'],
    }

  notice(abs(-42.42))
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
