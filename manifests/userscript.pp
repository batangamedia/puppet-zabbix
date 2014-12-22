define zabbix::userscript (
	$ensure=present,
  $content="",
  $source="",
	$user_params=false
) {

	include zabbix::params

	if ! defined(File[$zabbix::params::zabbix_userscript_config_dir]){
		file { $zabbix::params::zabbix_userscript_config_dir:
			ensure  => directory,
			group   => "zabbix",
			owner 	=> "zabbix",
			mode    => 755
		}
	}

	file {"${zabbix::params::zabbix_userscript_config_dir}/${name}":
		ensure  => $ensure,
		group   => "zabbix",
		owner 	=> "zabbix",
		mode  	=> "700",
		content => $content ? {
			""      => undef,
			default => $content,
		},
		source  => $source ? {
			""      => undef,
			default => $source,
		},
		require => File[$zabbix::params::zabbix_userscript_config_dir],
		notify	=> Service['zabbix_agentd'],
    }
}
