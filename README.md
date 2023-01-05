# valheim-aws
Terraform module for deploying a Valheim dedicated server to AWS

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | 2.2.0 |
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.48.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.4.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.sync](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.sync](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_cloudwatch_log_group.server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_datasync_location_efs.backups](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/datasync_location_efs) | resource |
| [aws_datasync_location_s3.backups](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/datasync_location_s3) | resource |
| [aws_datasync_task.sync](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/datasync_task) | resource |
| [aws_default_subnet.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_subnet) | resource |
| [aws_default_vpc.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_vpc) | resource |
| [aws_ecs_cluster.server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_ecs_service.server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_efs_access_point.server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_access_point) | resource |
| [aws_efs_file_system.server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_file_system) | resource |
| [aws_efs_mount_target.server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_mount_target) | resource |
| [aws_eip.server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_iam_role.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.sync](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_lambda_function.sync](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_permission.sync](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_lb.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener.status](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener.supervisor](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group.status](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group.supervisor](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_route53_record.server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_s3_bucket.backups](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.backups_acl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_security_group.server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.efs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.out](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ssh](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.status](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.supervisor](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.valheim](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [random_string.cluster_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [archive_file.sync](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |
| [aws_ami.amzn2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_canonical_user_id.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/canonical_user_id) | data source |
| [aws_ec2_instance_types.server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ec2_instance_types) | data source |
| [aws_route53_zone.zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_adminlist_ids"></a> [adminlist\_ids](#input\_adminlist\_ids) | List of admin Steam IDs | `list(string)` | `[]` | no |
| <a name="input_backups"></a> [backups](#input\_backups) | Whether the server should create periodic backups | `bool` | `true` | no |
| <a name="input_backups_bucket"></a> [backups\_bucket](#input\_backups\_bucket) | The name of the S3 bucket to store the world in | `string` | `"valheim-world"` | no |
| <a name="input_backups_cron"></a> [backups\_cron](#input\_backups\_cron) | Cron expression for when to create backups | `string` | `"0 * * * *"` | no |
| <a name="input_backups_directory"></a> [backups\_directory](#input\_backups\_directory) | The directory to store backups in | `string` | `"/config/backups"` | no |
| <a name="input_backups_idle_grace_period"></a> [backups\_idle\_grace\_period](#input\_backups\_idle\_grace\_period) | Grace period in seconds after the last player has disconnected in which we will still create backups when backups\_if\_idle is false | `number` | `3600` | no |
| <a name="input_backups_if_idle"></a> [backups\_if\_idle](#input\_backups\_if\_idle) | Backup even when no players have been connected for a while | `bool` | `true` | no |
| <a name="input_backups_max_age"></a> [backups\_max\_age](#input\_backups\_max\_age) | The maximum age of backups, in days | `number` | `3` | no |
| <a name="input_backups_max_count"></a> [backups\_max\_count](#input\_backups\_max\_count) | The maximum number of backups to keep (0 or null for infinite) | `number` | `null` | no |
| <a name="input_bannedlist_ids"></a> [bannedlist\_ids](#input\_bannedlist\_ids) | List of banned Steam IDs | `list(string)` | `[]` | no |
| <a name="input_bepinex_config"></a> [bepinex\_config](#input\_bepinex\_config) | BepInEx config | `map(map(any))` | `null` | no |
| <a name="input_mods_manager"></a> [mods\_manager](#input\_mods\_manager) | Mods manager to use ('valheim\_plus', 'bepinex', or null for no mods) | `string` | `null` | no |
| <a name="input_on_valheim_log_filter_contains"></a> [on\_valheim\_log\_filter\_contains](#input\_on\_valheim\_log\_filter\_contains) | Run command hook for log lines containing | `string` | `null` | no |
| <a name="input_on_valheim_log_filter_endswith"></a> [on\_valheim\_log\_filter\_endswith](#input\_on\_valheim\_log\_filter\_endswith) | Run command hook for log lines ending with | `string` | `null` | no |
| <a name="input_on_valheim_log_filter_match"></a> [on\_valheim\_log\_filter\_match](#input\_on\_valheim\_log\_filter\_match) | Run command hook for log lines exactly matching | `string` | `null` | no |
| <a name="input_on_valheim_log_filter_regexp"></a> [on\_valheim\_log\_filter\_regexp](#input\_on\_valheim\_log\_filter\_regexp) | Run command hook for log lines matching regular expression | `string` | `null` | no |
| <a name="input_on_valheim_log_filter_startswith"></a> [on\_valheim\_log\_filter\_startswith](#input\_on\_valheim\_log\_filter\_startswith) | Run command hook for log lines starting with | `string` | `null` | no |
| <a name="input_permissions_umask"></a> [permissions\_umask](#input\_permissions\_umask) | Umask to use for backups, config files and directories | `string` | `"022"` | no |
| <a name="input_permittedlist_ids"></a> [permittedlist\_ids](#input\_permittedlist\_ids) | List of permitted Steam IDs | `list(string)` | `[]` | no |
| <a name="input_pgid"></a> [pgid](#input\_pgid) | The group ID to use for the server | `number` | `0` | no |
| <a name="input_post_bepinex_config_hook"></a> [post\_bepinex\_config\_hook](#input\_post\_bepinex\_config\_hook) | Post-BepInEx config hook command | `string` | `null` | no |
| <a name="input_post_bootstrap_hook"></a> [post\_bootstrap\_hook](#input\_post\_bootstrap\_hook) | Post-bootstrap hook command | `string` | `null` | no |
| <a name="input_post_restart_hook"></a> [post\_restart\_hook](#input\_post\_restart\_hook) | Post-restart hook command | `string` | `null` | no |
| <a name="input_post_server_listening_hook"></a> [post\_server\_listening\_hook](#input\_post\_server\_listening\_hook) | Post-server listening hook command | `string` | `null` | no |
| <a name="input_post_server_run_hook"></a> [post\_server\_run\_hook](#input\_post\_server\_run\_hook) | Post-server run hook command | `string` | `null` | no |
| <a name="input_post_server_shutdown_hook"></a> [post\_server\_shutdown\_hook](#input\_post\_server\_shutdown\_hook) | Post-server shutdown hook command | `string` | `null` | no |
| <a name="input_post_start_hook"></a> [post\_start\_hook](#input\_post\_start\_hook) | Post-start hook command | `string` | `null` | no |
| <a name="input_post_update_check_hook"></a> [post\_update\_check\_hook](#input\_post\_update\_check\_hook) | Post-update check hook command | `string` | `null` | no |
| <a name="input_pre_bepinex_config_hook"></a> [pre\_bepinex\_config\_hook](#input\_pre\_bepinex\_config\_hook) | Pre-BepInEx config hook command | `string` | `null` | no |
| <a name="input_pre_bootstrap_hook"></a> [pre\_bootstrap\_hook](#input\_pre\_bootstrap\_hook) | Pre-bootstrap hook command | `string` | `null` | no |
| <a name="input_pre_restart_hook"></a> [pre\_restart\_hook](#input\_pre\_restart\_hook) | Pre-restart hook command | `string` | `null` | no |
| <a name="input_pre_server_listening_hook"></a> [pre\_server\_listening\_hook](#input\_pre\_server\_listening\_hook) | Pre-server listening hook command | `string` | `null` | no |
| <a name="input_pre_server_run_hook"></a> [pre\_server\_run\_hook](#input\_pre\_server\_run\_hook) | Pre-server run hook command | `string` | `null` | no |
| <a name="input_pre_server_shutdown_hook"></a> [pre\_server\_shutdown\_hook](#input\_pre\_server\_shutdown\_hook) | Pre-server shutdown hook command | `string` | `null` | no |
| <a name="input_pre_start_hook"></a> [pre\_start\_hook](#input\_pre\_start\_hook) | Pre-start hook command | `string` | `null` | no |
| <a name="input_pre_supervisor_hook"></a> [pre\_supervisor\_hook](#input\_pre\_supervisor\_hook) | Pre-supervisord hook command | `string` | `null` | no |
| <a name="input_pre_update_check_hook"></a> [pre\_update\_check\_hook](#input\_pre\_update\_check\_hook) | Pre-update check hook command | `string` | `null` | no |
| <a name="input_profile"></a> [profile](#input\_profile) | The AWS profile to use | `string` | `"default"` | no |
| <a name="input_puid"></a> [puid](#input\_puid) | The user ID to use for the server | `number` | `0` | no |
| <a name="input_ram_mb"></a> [ram\_mb](#input\_ram\_mb) | The amount of RAM to use, in MiBs | `number` | `8192` | no |
| <a name="input_region"></a> [region](#input\_region) | The AWS region to use | `string` | `"us-east-1"` | no |
| <a name="input_restart_cron"></a> [restart\_cron](#input\_restart\_cron) | Cron expression for when to restart the server | `string` | `"0 5 * * *"` | no |
| <a name="input_restart_if_idle"></a> [restart\_if\_idle](#input\_restart\_if\_idle) | Only restart the server if it's idle | `bool` | `true` | no |
| <a name="input_route53_zone_id"></a> [route53\_zone\_id](#input\_route53\_zone\_id) | The ID of the Route 53 zone to use, if any | `string` | `null` | no |
| <a name="input_server_args"></a> [server\_args](#input\_server\_args) | Additional arguments to pass to the server | `list(string)` | `[]` | no |
| <a name="input_server_name"></a> [server\_name](#input\_server\_name) | The name of the server | `string` | `"Valheim Server"` | no |
| <a name="input_server_pass"></a> [server\_pass](#input\_server\_pass) | The password to use for server login | `string` | `"secret"` | no |
| <a name="input_server_port"></a> [server\_port](#input\_server\_port) | The UDP port to use | `number` | `2456` | no |
| <a name="input_server_public"></a> [server\_public](#input\_server\_public) | Whether to make the server public | `bool` | `true` | no |
| <a name="input_state"></a> [state](#input\_state) | Target state of the server ('running', 'paused', or 'stopped') | `string` | `"running"` | no |
| <a name="input_status_http_conf"></a> [status\_http\_conf](#input\_status\_http\_conf) | The path to the busybox httpd config file | `string` | `"/config/httpd.conf"` | no |
| <a name="input_status_http_htdocs"></a> [status\_http\_htdocs](#input\_status\_http\_htdocs) | Path to the status httpd htdocs where status.json is written | `string` | `"/opt/valheim/htdocs"` | no |
| <a name="input_status_http_port"></a> [status\_http\_port](#input\_status\_http\_port) | The port to use for the status HTTP server | `number` | `80` | no |
| <a name="input_steamcmd_args"></a> [steamcmd\_args](#input\_steamcmd\_args) | Additional arguments to pass to SteamCMD CLI | `list(string)` | <pre>[<br>  "validate"<br>]</pre> | no |
| <a name="input_supervisor_http"></a> [supervisor\_http](#input\_supervisor\_http) | Whether to enable the Supervisor HTTP server | `bool` | `false` | no |
| <a name="input_supervisor_http_password"></a> [supervisor\_http\_password](#input\_supervisor\_http\_password) | The password to use for the Supervisor HTTP server | `any` | `null` | no |
| <a name="input_supervisor_http_port"></a> [supervisor\_http\_port](#input\_supervisor\_http\_port) | The port to use for the Supervisor HTTP server | `number` | `9001` | no |
| <a name="input_supervisor_http_username"></a> [supervisor\_http\_username](#input\_supervisor\_http\_username) | The username to use for the Supervisor HTTP server | `string` | `"admin"` | no |
| <a name="input_syslog_remote_and_local"></a> [syslog\_remote\_and\_local](#input\_syslog\_remote\_and\_local) | Whether to also log locally when sending logs to a remote syslog server | `bool` | `true` | no |
| <a name="input_syslog_remote_host"></a> [syslog\_remote\_host](#input\_syslog\_remote\_host) | The remote syslog host or IP to send logs to | `string` | `null` | no |
| <a name="input_syslog_remote_port"></a> [syslog\_remote\_port](#input\_syslog\_remote\_port) | The remote syslog UDP port to send logs to | `number` | `514` | no |
| <a name="input_timezone"></a> [timezone](#input\_timezone) | Timezone for container | `string` | `"Etc/UTC"` | no |
| <a name="input_update_cron"></a> [update\_cron](#input\_update\_cron) | Cron expression for when to update the server | `string` | `"*/15 * * * *"` | no |
| <a name="input_update_if_idle"></a> [update\_if\_idle](#input\_update\_if\_idle) | Only update the server if it's idle | `bool` | `true` | no |
| <a name="input_valheim_log_filter_contains"></a> [valheim\_log\_filter\_contains](#input\_valheim\_log\_filter\_contains) | Filter log lines containing | `string` | `null` | no |
| <a name="input_valheim_log_filter_empty"></a> [valheim\_log\_filter\_empty](#input\_valheim\_log\_filter\_empty) | Whether to filter out empty log lines | `bool` | `true` | no |
| <a name="input_valheim_log_filter_endswith"></a> [valheim\_log\_filter\_endswith](#input\_valheim\_log\_filter\_endswith) | Filter log lines ending with | `string` | `null` | no |
| <a name="input_valheim_log_filter_match"></a> [valheim\_log\_filter\_match](#input\_valheim\_log\_filter\_match) | Filter log lines exactly matching | `string` | `" "` | no |
| <a name="input_valheim_log_filter_regexp"></a> [valheim\_log\_filter\_regexp](#input\_valheim\_log\_filter\_regexp) | Filter log lines matching regular expression | `string` | `null` | no |
| <a name="input_valheim_log_filter_startswith"></a> [valheim\_log\_filter\_startswith](#input\_valheim\_log\_filter\_startswith) | Filter log lines starting with | `string` | `"(Filename:"` | no |
| <a name="input_valheim_log_filter_utf8"></a> [valheim\_log\_filter\_utf8](#input\_valheim\_log\_filter\_utf8) | Whether to filter out invalid UTF-8 characters | `bool` | `true` | no |
| <a name="input_valheim_plus_config"></a> [valheim\_plus\_config](#input\_valheim\_plus\_config) | Valheim Plus config | `map(map(any))` | `null` | no |
| <a name="input_vcpus"></a> [vcpus](#input\_vcpus) | The number of vCPUs to use | `number` | `1` | no |
| <a name="input_world_name"></a> [world\_name](#input\_world\_name) | The name of the Valheim world | `string` | `"valheim"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_domain_name"></a> [domain\_name](#output\_domain\_name) | The domain name of the Valheim server |
| <a name="output_server_ip"></a> [server\_ip](#output\_server\_ip) | The IP address of the Valheim server |
<!-- END_TF_DOCS -->