define apache::vhost (
  $docroot,
  $port = '80',
  $priority = '10',
  $options = 'Index MultiViews',
  $vhost_name = $title,
  $servername = $title,
  $logdir = '/var/log/httpd',
) {
  $vhost = $name
  file { "${docroot}/index.html":
    ensure  => file,
    content => template('apache/index.html.erb'),
  }
  file { $docroot:
    ensure => directory,
    owner   => 'apache',
    group   => 'apache',
    mode    => '0644',
  }
  file { "/etc/httpd/conf.d/${name}.conf":
    ensure  => file,
    owner   => 'apache',
    group   => 'apache',
    mode    => '0644',
    content => template('apache/vhost.conf.erb'),
    notify  => Service['apache_service'],
  }
}
