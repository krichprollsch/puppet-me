# create the user and add it to sudoer

class me::user {
  user { $me::username:
    ensure     => present,
    shell      => '/bin/bash',
    managehome => true,
    password   => $me::password
  }

  file {
  "/home/${me::username}/.bashrc":
    source => 'puppet:///modules/me/bash/.bashrc',
    owner  => $me::username,
    group  => $me::username,
    mode   => '0755';
  "/home/${me::username}/.bash_prompt":
    source => 'puppet:///modules/me/bash/.bash_prompt',
    owner  => $me::username,
    group  => $me::username,
    mode   => '0755';
  "/home/${me::username}/.vimrc":
    source => 'puppet:///modules/me/vim/.vimrc',
    owner  => $me::username,
    group  => $me::username,
    mode   => '0755';
  }

  include me::user::sudoer, me::user::ssh
}
