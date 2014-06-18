class apache {
  case $::osfamily {
    'debian': {
      $apache_package = 'apache2'
      $apache_user = 'www-data'
      $apache_group = 'www-data'
      $apache_service = 'apache2'
      $apache_conf = '/etc/apache2/apache2.conf'
    }
    'redhat': {
      $apache_package = 'httpd'
      $apache_user = 'apache'
      $apache_group = 'apache'
      $apache_service = 'httpd'
      $apache_conf = '/etc/httpd/conf/httpd.conf'
    }
    default: {
      fail('unsupported')
    }
  }

  package { 'apache_package':
    name   => $apache_package,
    ensure => present,
  }

  user { $apache_user:
    ensure => present,
    require => Package['apache_package'],
  }

  group { $apache_group:
    ensure => present,
    require => Package['apache_package'],
  }

  File {
    owner  => $apache_user,
    group  => $apache_group,
    mode   => '0644',
  }

  file { '/var/www':
    ensure => directory,
  }

  file { '/var/www/html':
    ensure => directory,
  }

  $vhost = 'www'
  file { '/var/www/html/index.html':
    ensure  => file,
    content => template('apache/index.html.erb'),
  }

  file { 'apache_config':
    path    => $apache_conf,
    source  => 'puppet:///modules/apache/httpd.conf',
    require => Package['apache_package'],
  }
  service { 'apache_service':
    name      => $apache_service,
    ensure    => running,
    enable    => true,
    subscribe => File['apache_config'],
  }

  file { '/var/www/muppets':
    ensure => directory,
  }
  apache::vhost { 'elmo.puppetlabs.com':
    docroot => '/var/www/muppets/elmo',
    options => 'Indexes MultiViews',
  }

  apache::vhost { 'piggy.puppetlabs.com':
    docroot => '/var/www/muppets/piggy',
    options => '-MultiViews',
  }
}
