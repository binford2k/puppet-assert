assert { 'Path exists':
  path => '/etc',
} ->
notify { 'validate etc': }

assert { 'File exists':
  file => '/etc/passwd',
} ->
notify { 'validate etc passwd': }

assert { 'Directory exists':
  directory => '/etc',
} ->
notify { 'validate etc directory': }



assert { 'absent path':
  ensure => absent,
  path   => '/etsdfsfc',
} ->
notify { 'absent path': }



assert { 'File not directory':
  directory => '/etc/passwd',
} ->
notify { 'validate File not directory': }

assert { 'Directory not file':
  file => '/etc',
} ->
notify { 'Directory not file': }



assert { 'Path does not exist':
  path => '/etcdflkjsf',
} ->
notify { 'path not exist etc': }

assert { 'File not exists':
  file => '/etc/passwdsdfsfd',
} ->
notify { 'validate etc passwd not': }

assert { 'Directory not exists':
  directory => '/etcssfdsdf',
} ->
notify { 'validate etc directory not': }
