class users::admins {
  group { 'staff':
    ensure => present,
  }
  
  user { 'admin': 
    ensure => present,
    shell  => '/bin/zsh',
  }
}
