
class nsm::packages {

    require nsm::params

    $base_url = "https://s3-us-west-1.amazonaws.com/nsm-nubis-rpms"

    notice("Grabbing nsm packages from ${base_url}")

    file { '/tmp/nsmpackages':
        ensure => directory,
        owner  => root,
        group  => root,
        mode   => '0755',
    }

    wget::fetch { "download ${bro_package_name}":
        source     => "/tmp/nsmpackages/${bro_package_name}",
        verbose    => true,
        redownload => true,
        require    => File['/tmp/nsmpackages'],
    }

    wget::fetch { "download ${bro_support_package_name}":
        source     => "/tmp/nsmpackages/${bro_support_package_name}",
        verbose    => true,
        redownload => true,
        require    => File['/tmp/nsmpackages'],
    }

    wget::fetch { "download ${bro_plugin_afpacket_package_name}":
        source     => "/tmp/nsmpackages/${bro_plugin_afpacket_package_name}",
        verbose    => true,
        redownload => true,
        require    => File['/tmp/nsmpackages'],
    }

    wget::fetch { "download ${heka_package_name}":
        source     => "/tmp/nsmpackages/${heka_package_name}",
        verbose    => true,
        redownload => true,
        require    => File['/tmp/nsmpackages'],
    }

    wget::fetch { "download ${heka_nsm_lua_package_name}":
        source     => "/tmp/nsmpackages/${heka_nsm_lua_package_name}",
        verbose    => true,
        redownload => true,
        require    => File['/tmp/nsmpackages'],
    }

    wget::fetch { "download ${python_meld_package_name}":
        source     => "/tmp/nsmpackages/${python_meld_package_name}",
        verbose    => true,
        redownload => true,
        require    => File['/tmp/nsmpackages'],
    }

    wget::fetch { "download ${python_supervisor_package_name}":
        source     => "/tmp/nsmpackages/${python_supervisor_package_name}",
        verbose    => true,
        redownload => true,
        require    => File['/tmp/nsmpackages'],
    }

    wget::fetch { "download ${supervisor_package_name}":
        source     => "/tmp/nsmpackages/${supervisor_package_name}",
        verbose    => true,
        redownload => true,
        require    => File['/tmp/nsmpackages'],
    }

    package { 'libpcap':
        ensure => present
    }

    package { 'bro':
        ensure   => present,
        source   => "/tmp/nsmpackages/${bro_package_name}",
        provider => 'rpm',
        require  => [ File['/tmp/nsmpackages'], Wget::Fetch["download ${bro_package_name}"] ]
    }->
    package { 'bro-support':
        ensure   => present,
        source   => "/tmp/nsmpackages/${bro_support_package_name}"
        provider => 'rpm',
        require  => [ File['/tmp/nsmpackages'], Wget::Fetch["download ${bro_support_package_name}"] ],
    }->
    package { 'bro-plugin-afpacket':
        ensure   => present,
        source   => "/tmp/nsmpackages/${bro_plugin_afpacket_package_name}",
        provider => 'rpm',
        require  => [ File['/tmp/nsmpackages'], Wget::Fetch["download ${bro_plugin_afpacket_package_name}"] ],
    }->
    package { 'heka':
        ensure   => present,
        source   => "/tmp/nsmpackages/${heka_package_name}",
        provider => 'rpm',
        require  => [ File['/tmp/nsmpackages'], Wget::Fetch["download ${heka_package_name}"] ],
    }->
    package { 'heka-nsm-lua':
        ensure   => present,
        source   => "/tmp/nsmpackages/${heka_nsm_lua_package_name}",
        provider => 'rpm',
        require  => [ File['/tmp/nsmpackages'], Wget::Fetch["download ${heka_nsm_lua_package_name}"] ],
    }->
    package { 'python-meld':
        ensure   => present,
        source   => "/tmp/nsmpackages/${python_meld_package_name}",
        provider => 'rpm',
        require  => [ File['/tmp/nsmpackages'], Wget::Fetch["download ${python_meld_package_name}"] ]
    }->
    package { 'python-supervisor':
        ensure   => present,
        source   => "/tmp/nsmpackages/${python_supervisor_package_name}",
        provider => 'rpm',
        require  => [ File['/tmp/nsmpackages'], Wget::Fetch["download ${python_supervisor_package_name}"] ],
    }->
    package { 'supervisor':
        ensure   => present,
        source   => "/tmp/nsmpackages/${supervisor_package_name}",
        provider => 'rpm',
        require  => [ File['/tmp/nsmpackages'], Wget::Fetch["download ${supervisor_package_name}"] ],
    }
}
