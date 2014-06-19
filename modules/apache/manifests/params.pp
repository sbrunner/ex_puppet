class apache::params {
  case $::osfamily {
    'debian': {
      $apache_package = 'apache2'
      $apache_user = 'www-data'
      $apache_group = 'www-data'
      $apache_service = 'apache2'
      $apache_conf = '/etc/apache2/apache2.conf'
      $apache_docroot = '/var/www/'
    }
    'redhat': {
      $apache_package = 'httpd'
      $apache_user = 'apache'
      $apache_group = 'apache'
      $apache_service = 'httpd'
      $apache_conf = '/etc/httpd/conf/httpd.conf'
      $apache_docroot = '/var/www/html'
    }
    default: {
      fail('unsupported')
    }
  }
}
