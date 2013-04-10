# include the user ssh keys and configuration
class me::user::ssh {

  # create the .ssh directory
  # =========================
  file{ "/home/${me::username}/.ssh":
    ensure  => directory,
    links   => follow,
    owner   => $me::username,
    group   => $me::username,
    mode    => '0700',
    require => User[$me::username],
  }

  file{ "/home/${me::username}/.ssh/keys":
    ensure  => directory,
    links   => follow,
    owner   => $me::username,
    group   => $me::username,
    mode    => '0700',
    require => File["/home/${me::username}/.ssh"],
  }

  # include ssh private keys
  # ========================
  # id_rsa for general purpose
  file{ "/home/${me::username}/.ssh/keys/default":
    ensure  => present,
    links   => follow,
    source  => 'puppet:///modules/me/ssh/default',
    owner   => $me::username,
    group   => $me::username,
    mode    => '0400',
    require => File["/home/${me::username}/.ssh/keys"],
  }
  # git_rsa for git purpose
  file{ "/home/${me::username}/.ssh/keys/gitlab":
    ensure  => present,
    links   => follow,
    source  => 'puppet:///modules/me/ssh/gitlab',
    owner   => $me::username,
    group   => $me::username,
    mode    => '0400',
    require => File["/home/${me::username}/.ssh/keys"],
  }

  # include public keys
  # ===================
  # id_rsa for general purpose
  file{ "/home/${me::username}/.ssh/keys/default.pub":
    ensure  => present,
    links   => follow,
    source  => 'puppet:///modules/me/ssh/default.pub',
    owner   => $me::username,
    group   => $me::username,
    mode    => '0644',
    require => File["/home/${me::username}/.ssh/keys"],
  }
  # git_rsa for git purpose
  file{ "/home/${me::username}/.ssh/keys/gitlab.pub":
    ensure  => present,
    links   => follow,
    source  => 'puppet:///modules/me/ssh/gitlab.pub',
    owner   => $me::username,
    group   => $me::username,
    mode    => '0644',
    require => File["/home/${me::username}/.ssh/keys"],
  }

  # authorized keys
  # ===============
  file{ "/home/${me::username}/.ssh/authorized_keys":
    ensure  => present,
    links   => follow,
    source  => 'puppet:///modules/me/ssh/authorized_keys',
    owner   => $me::username,
    group   => $me::username,
    mode    => '0644',
    require => File["/home/${me::username}/.ssh"],
  }

  # known hosts are shared too
  # ==========================
  file{ "/home/${me::username}/.ssh/known_hosts":
    ensure  => present,
    source  => 'puppet:///modules/me/ssh/known_hosts',
    replace => no,
    links   => follow,
    owner   => $me::username,
    group   => $me::username,
    mode    => '0644',
    require => File["/home/${me::username}/.ssh/keys"],
  }

  # config
  # ==========================
  file{ "/home/${me::username}/.ssh/config":
    ensure  => present,
    source  => 'puppet:///modules/me/ssh/config',
    replace => no,
    links   => follow,
    owner   => $me::username,
    group   => $me::username,
    mode    => '0644',
    require => File["/home/${me::username}/.ssh"],
  }
}
