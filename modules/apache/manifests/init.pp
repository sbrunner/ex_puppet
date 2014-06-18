class apache {
  package { 'httpd':
    ensure => present,
  }

  user { 'apache':
    ensure => present,
    require => Package['httpd'],
  }

  group { 'apache':
    ensure => present,
    require => Package['httpd'],
  }

  File {
    owner  => 'apache',
    group  => 'apache',
    mode   => '0644',
  }

  file { '/var/www':
    ensure => directory,
  }

  file { '/var/www/html':
    ensure => directory,
  }

  file { '/var/www/html/index.html':
    ensure => file,
    source => 'puppet:///modules/apache/index.html',
  }

  file { '/etc/httpd/conf/httpd.conf':
    source => 'puppet:///modules/apache/httpd.conf',
    require => Package['httpd'],
  }

  service { 'httpd':
    ensure  => running,
    enable  => true,
    subscribe => Package['httpd'],
  }
}
