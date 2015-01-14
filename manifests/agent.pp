class zabbix::agent inherits zabbix {
	$zabbix_userparameter_config_dir = "/etc/zabbix/zabbix_agentd"
  $zabbix_agentd_conf = "$zabbix_config_dir/zabbix_agentd.conf"

    package { "zabbix-agent":
        ensure	=> installed,
        require => Apt::Source['dotdeb']
    }

    # not really pretty,
    $zabbix_server = hiera('zabbix_server', false)

    file {
        $zabbix_userparameter_config_dir:
            ensure 	=> directory,
            owner 	=> root,
            group 	=> root,
            mode 	=> 755,
            require => [ Package["zabbix-agent"], File["$zabbix_config_dir"] ];

        $zabbix_agentd_conf:
            owner 	=> root,
            group 	=> root,
            mode 	=> 644,
            content => template("zabbix/zabbix_agentd_conf.erb"),
			      notify	=> Service['zabbix_agentd'],
            require => [ Package["zabbix-agent"], File["$zabbix_config_dir"] ];
  	}

    if $zabbix_server {
      $zabbix_agent_status = true
    } else {
      $zabbix_agent_status = false
    }

    service {
        "zabbix_agentd":
		      name => 'zabbix-agent',
          enable 		=> $zabbix_agent_status,
          ensure 		=> running,
			    hasstatus	=> false,
			    hasrestart	=> true,
          require 	=> [ Package["zabbix-agent"], File["$zabbix_config_dir"], File["$zabbix_log_dir"], File["$zabbix_pid_dir"] ];
    }
	
}

