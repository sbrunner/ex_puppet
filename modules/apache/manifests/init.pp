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

  file { '/var/www':
    ensure => directory,
    owner  => 'apache',
    group  => 'apache',
  }

  file { '/var/www/html':
    ensure => directory,
    owner  => 'apache',
    group  => 'apache',
  }

  file { '/var/www/html/index.html':
    ensure => file,
    owner  => 'apache',
    group  => 'apache',
    mode   => '0644',
    source => 'puppet:///modules/apache/index.html',
  }

  file { '/etc/httpd/conf/httpd.conf':
    owner  => '0',
    group  => '0',
    mode   => '0644',
    source => 'puppet:///modules/apache/httpd.conf',
    require => Package['httpd'],
  }

  service { 'httpd':
    ensure  => running,
    enable  => true,
    subscribe => Package['httpd'],
  }
}
