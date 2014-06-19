class apache (
  $apache_package = $apache::params::apache_package,
  $apache_user = $apache::params::apache_user,
  $apache_group = $apache::params::apache_group,
  $apache_service = $apache::params::apache_service,
  $apache_conf = $apache::params::apache_conf,
  $apache_docroot = $apache::params::apache_docroot,
) inherits apache::params {

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

  file { $apache_docroot:
    ensure => directory,
  }

  $vhost = 'www'
  file { "${apache_docroot}/index.html":
    ensure  => file,
    content => template('apache/index.html.erb'),
  }

  file { 'apache_config':
    path    => $apache_conf,
    content => template('apache/httpd.conf.erb'),
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
