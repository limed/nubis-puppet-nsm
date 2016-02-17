
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

    wget::fetch { "download ${nsm::params::bro_package_name}":
        source      => "${base_url}/${nsm::params::bro_package_name}",
        destination => "/tmp/nsmpackages/${nsm::params::bro_package_name}",
        verbose     => true,
        redownload  => true,
        require     => File['/tmp/nsmpackages'],
    }

    wget::fetch { "download ${nsm::params::bro_support_package_name}":
        source      => "${base_url}/${nsm::params::bro_support_package_name}",
        destination => "/tmp/nsmpackages/${nsm::params::bro_support_package_name}",
        verbose     => true,
        redownload  => true,
        require     => File['/tmp/nsmpackages'],
    }

    wget::fetch { "download ${nsm::params::bro_plugin_afpacket_package_name}":
        source      => "${base_url}/${nsm::params::bro_plugin_afpacket_package_name}",
        destination => "/tmp/nsmpackages/${nsm::params::bro_plugin_afpacket_package_name}",
        verbose     => true,
        redownload  => true,
        require     => File['/tmp/nsmpackages'],
    }

    wget::fetch { "download ${nsm::params::heka_package_name}":
        source      => "${base_url}/${nsm::params::heka_package_name}",
        destination => "/tmp/nsmpackages/${nsm::params::heka_package_name}",
        verbose     => true,
        redownload  => true,
        require     => File['/tmp/nsmpackages'],
    }

    wget::fetch { "download ${nsm::params::heka_nsm_lua_package_name}":
        source      => "${base_url}/${nsm::params::heka_nsm_lua_package_name}",
        destination => "/tmp/nsmpackages/${nsm::params::heka_nsm_lua_package_name}",
        verbose     => true,
        redownload  => true,
        require     => File['/tmp/nsmpackages'],
    }

    wget::fetch { "download ${nsm::params::python_meld_package_name}":
        source      => "${base_url}/${nsm::params::python_meld_package_name}",
        destination => "/tmp/nsmpackages/${nsm::params::python_meld_package_name}",
        verbose     => true,
        redownload  => true,
        require     => File['/tmp/nsmpackages'],
    }

    wget::fetch { "download ${nsm::params::python_supervisor_package_name}":
        source      => "${base_url}/${nsm::params::python_supervisor_package_name}",
        destination => "/tmp/nsmpackages/${nsm::params::python_supervisor_package_name}",
        verbose     => true,
        redownload  => true,
        require     => File['/tmp/nsmpackages'],
    }

    wget::fetch { "download ${nsm::params::supervisor_package_name}":
        source      => "${base_url}/${nsm::params::python_supervisor_package_name}",
        destination => "/tmp/nsmpackages/${nsm::params::supervisor_package_name}",
        verbose     => true,
        redownload  => true,
        require     => File['/tmp/nsmpackages'],
    }

    package { 'libpcap':
        ensure => present
    }

    package { 'bro':
        ensure   => present,
        source   => "/tmp/nsmpackages/${nsm::params::bro_package_name}",
        provider => 'rpm',
        require  => [ File['/tmp/nsmpackages'], Wget::Fetch["download ${nsm::params::bro_package_name}"] ]
    }->
    package { 'bro-support':
        ensure   => present,
        source   => "/tmp/nsmpackages/${nsm::params::bro_support_package_name}",
        provider => 'rpm',
        require  => [ File['/tmp/nsmpackages'], Wget::Fetch["download ${nsm::params::bro_support_package_name}"] ],
    }->
    package { 'bro-plugin-afpacket':
        ensure   => present,
        source   => "/tmp/nsmpackages/${nsm::params::bro_plugin_afpacket_package_name}",
        provider => 'rpm',
        require  => [ File['/tmp/nsmpackages'], Wget::Fetch["download ${nsm::params::bro_plugin_afpacket_package_name}"] ],
    }->
    package { 'heka':
        ensure   => present,
        source   => "/tmp/nsmpackages/${nsm::params::heka_package_name}",
        provider => 'rpm',
        require  => [ File['/tmp/nsmpackages'], Wget::Fetch["download ${nsm::params::heka_package_name}"] ],
    }->
    package { 'heka-nsm-lua':
        ensure   => present,
        source   => "/tmp/nsmpackages/${nsm::params::heka_nsm_lua_package_name}",
        provider => 'rpm',
        require  => [ File['/tmp/nsmpackages'], Wget::Fetch["download ${nsm::params::heka_nsm_lua_package_name}"] ],
    }->
    package { 'python-meld':
        ensure   => present,
        source   => "/tmp/nsmpackages/${nsm::params::python_meld_package_name}",
        provider => 'rpm',
        require  => [ File['/tmp/nsmpackages'], Wget::Fetch["download ${nsm::params::python_meld_package_name}"] ]
    }->
    package { 'python-supervisor':
        ensure   => present,
        source   => "/tmp/nsmpackages/${nsm::params::python_supervisor_package_name}",
        provider => 'rpm',
        require  => [ File['/tmp/nsmpackages'], Wget::Fetch["download ${nsm::params::python_supervisor_package_name}"] ],
    }->
    package { 'supervisor':
        ensure   => present,
        source   => "/tmp/nsmpackages/${nsm::params::supervisor_package_name}",
        provider => 'rpm',
        require  => [ File['/tmp/nsmpackages'], Wget::Fetch["download ${nsm::params::supervisor_package_name}"] ],
    }
}
