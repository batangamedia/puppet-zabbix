class zabbix::params {

  $zabbix_userparameter_config_dir = "/etc/zabbix/zabbix_agentd"
  $zabbix_agentd_conf              = "$zabbix_config_dir/zabbix_agentd.conf"
  $zabbix_userscript_config_dir    = "/etc/monitoring"
  $zabbix_userscript_log_dir       = "/var/log/monitoring"
}
