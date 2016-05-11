
class nsm::hekad {

    file { '/etc/heka':
        ensure  => directory,
        owner   => root,
        group   => root,
        mode    => '0755',
        require => Package['heka']
    }

    file { '/etc/heka/supervisor.conf':
        ensure  => file,
        owner   => root,
        group   => root,
        mode    => '0644',
        source  => 'puppet:///modules/nsm/heka/supervisor.conf',
        require => [ File['/etc/heka'], Package['heka'] ],
    }

    file { '/etc/init.d/hekad':
        ensure  => file,
        owner   => root,
        group   => root,
        mode    => '0755',
        source  => 'puppet:///modules/nsm/heka/heka-init',
        require => File['/etc/heka/supervisor.conf']
    }

    file { '/usr/share/heka/lua_encoders/mozdef.lua':
        ensure  => file,
        owner   => root,
        group   => root,
        mode    => '0644',
        source  => 'puppet:///modules/nsm/heka/mozdefencoder.lua',
        require => [ Package['heka'], Package['python-supervisor'] ],
    }

    service { 'hekad':
        ensure  => running,
        enable  => true,
        status  => '/usr/local/bin/supervisorctl status hekad | awk \'/^hekad[: ]/{print \$2}\' | grep \'^RUNNING$\'',
        require => [ Package['python-supervisor'], File['/etc/init.d/hekad'] ],
    }
}
