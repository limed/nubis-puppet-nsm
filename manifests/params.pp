
class nsm::params {

    if $::osfamily != 'redhat' {
        fail("osfamily ${::osfamily} is not supported")
    }

    $bro_package_name                   = "bro-2.5_2016_02_01_12_18_22-1.x86_64.rpm"
    $bro_support_package_name           = "bro-support-1.1_2016_02_02_18_49_05-1.x86_64.rpm"
    $bro_plugin_afpacket_package_name   = "bro-plugin-afpacket-1.0_2016_02_01_12_20_41-1.x86_64.rpm"

    $heka_package_name                  = "heka-0_11_0-linux-amd64.rpm"
    $heka_nsm_lua_package_name          = "heka-nsm-lua-2.6_2016_02_01_13_46_13-1.x86_64.rpm"

    $python_meld_package_name           = "python-meld3-1.0.2-1.noarch.rpm"
    $python_supervisor_package_name     = "python-supervisor-3.2.0-1.noarch.rpm"

    $supervisor_package_name            = "supervisor-support-1.0_2016_02_01_14_55_45-1.x86_64.rpm"
}
