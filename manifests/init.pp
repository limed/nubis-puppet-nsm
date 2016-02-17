# Class: nsm
# ===========================
#
# Installs and configures nsm
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'nsm':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Ed Lim <limed@mozilla.com>
#
# Copyright
# ---------
#
# Copyright 2016 Ed Lim.
#
class nsm (
    $ensure     = 'present',
    $networks   = {},
    $nsm_mailto = ""

){

    include nsm::packages

    if !($ensure in ['present', 'absent']) {
        fail("${ensure} is not a valid parameter")
    }

    if $ensure == 'present' {
        $file_ensure        = 'file'
        $user_ensure        = 'present'
        $group_ensure       = 'present'
        $directory_ensure   = 'directory'
    }
    else {
        $file_ensure        = 'absent'
        $user_ensure        = 'absent'
        $group_ensure       = 'absent'
        $directory_ensure   = 'absent'
    }

    user { 'bro':
        ensure => $user_ensure,
        before => Class['nsm::packages'],
    }

    group { 'bro':
        ensure => $group_ensure,
        before => Class['nsm::packages'],
    }

    $nsm_dirs = [ '/nsm', '/nsm/bro', '/opt/bro' ]

    file { $nsm_dirs:
        ensure  => $directory_ensure,
        owner   => bro,
        group   => bro,
        mode    => '0744',
        require => [ User['bro'], Group['bro']
   }

}
