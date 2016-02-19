
class nsm::supervisord {

    file { '/etc/heka':
        ensure => directory,
        owner  => root,
        group  => root,
        mode   => '0755',
    }

    file { '/etc/heka/supervisor.conf':
        ensure  => file,
        owner   => root,
        group   => root,
        mode    => '0644',
        source  => 'puppet:///modules/nsm/heka/supervisor.conf',
        require => File['/etc/heka']
    }

    file { '/etc/init.d/hekad':
        ensure  => file,
        owner   => root,
        group   => root,
        mode    => '0755',
        source  => 'puppet:///modules/nsm/heka/heka-init',
        require => File['/etc/heka/supervisor.conf']
    }

    service { 'hekad':
        ensure  => running,
        enable  => true,
        status  => '/usr/local/bin/supervisorctl status hekad | awk \'/^hekad[: ]/{print \$2}\' | grep \'^RUNNING$\'',
        require => File['/etc/init.d/hekad'],
    }
}
