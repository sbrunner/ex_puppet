class wp_profile {
  include ::mysql::server
  class { '::mysql::bindings':
    php_enable => true,
  }
  include ::wordpress
  class { '::apache':
    mpm_module => prefork,
  }
  include ::apache::mod::php
  ::apache::vhost { 'wordpress.example.vm':
    docroot => '/opt/wordpress'
  }

  host { 'wordpress.example.vm':
    ip => '10.27.12.179'
  }
}
