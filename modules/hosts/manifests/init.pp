class hosts {
  host { 'main':
    comment      => 'a fake host',
    ensure       => present,
    host_aliases => 'main.puppetlabs.vm',
    ip           => '192.1.2.3',
  }
}
