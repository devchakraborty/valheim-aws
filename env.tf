variable "server_name" {
  description = "The name of the server"
  type        = string
  default     = "Valheim Server"
}

variable "server_port" {
  description = "The UDP port to use"
  type        = number
  default     = 2456
}

variable "world_name" {
  description = "The name of the Valheim world"
  type        = string
  default     = "valheim"
}

variable "server_pass" {
  description = "The password to use for server login"
  default     = "secret"

  validation {
    condition     = length(var.server_pass) >= 5
    error_message = "The server password must be at least 5 characters long."
  }
}

variable "server_public" {
  description = "Whether to make the server public"
  type        = bool
  default     = true
}

variable "server_args" {
  description = "Additional arguments to pass to the server"
  type        = list(string)
  default     = []
}

variable "adminlist_ids" {
  description = "List of admin Steam IDs"
  type        = list(string)
  default     = []
}

variable "bannedlist_ids" {
  description = "List of banned Steam IDs"
  type        = list(string)
  default     = []
}

variable "permittedlist_ids" {
  description = "List of permitted Steam IDs"
  type        = list(string)
  default     = []
}

variable "update_cron" {
  description = "Cron expression for when to update the server"
  type        = string
  nullable    = true
  default     = "*/15 * * * *" # Every 15 minutes
}

variable "update_if_idle" {
  description = "Only update the server if it's idle"
  type        = bool
  default     = true
}

variable "restart_cron" {
  description = "Cron expression for when to restart the server"
  type        = string
  nullable    = true
  default     = "0 5 * * *"
}

variable "restart_if_idle" {
  description = "Only restart the server if it's idle"
  type        = bool
  default     = true
}

variable "timezone" {
  description = "Timezone for container"
  type        = string
  default     = "Etc/UTC"
}

variable "backups" {
  description = "Whether the server should create periodic backups"
  type        = bool
  default     = true
}

variable "backups_cron" {
  description = "Cron expression for when to create backups"
  type        = string
  nullable    = true
  default     = "0 * * * *"
}

variable "backups_directory" {
  description = "The directory to store backups in"
  type        = string
  default     = "/config/backups"
}

variable "backups_max_age" {
  description = "The maximum age of backups, in days"
  type        = number
  default     = 3
}

variable "backups_max_count" {
  description = "The maximum number of backups to keep (0 or null for infinite)"
  type        = number
  nullable    = true
  default     = null
}

variable "backups_if_idle" {
  description = "Backup even when no players have been connected for a while"
  type        = bool
  default     = true
}

variable "backups_idle_grace_period" {
  description = "Grace period in seconds after the last player has disconnected in which we will still create backups when backups_if_idle is false"
  type        = number
  default     = 3600
}

variable "permissions_umask" {
  description = "Umask to use for backups, config files and directories"
  type        = string
  default     = "022"
}

variable "steamcmd_args" {
  description = "Additional arguments to pass to SteamCMD CLI"
  type        = list(string)
  default     = ["validate"]
}

variable "mods_manager" {
  description = "Mods manager to use ('valheim_plus', 'bepinex', or null for no mods)"
  type        = string
  nullable    = true
  default     = null

  validation {
    condition     = var.mods_manager == null || var.mods_manager == "valheim_plus" || var.mods_manager == "bepinex"
    error_message = "Mods manager must be 'valheim_plus', 'bepinex', or null."
  }
}

variable "supervisor_http" {
  description = "Whether to enable the Supervisor HTTP server"
  type        = bool
  default     = false
}

variable "supervisor_http_port" {
  description = "The port to use for the Supervisor HTTP server"
  type        = number
  default     = 9001
}

variable "supervisor_http_username" {
  description = "The username to use for the Supervisor HTTP server"
  type        = string
  default     = "admin"
}

variable "supervisor_http_password" {
  description = "The password to use for the Supervisor HTTP server"
  sensitive   = true
  nullable    = true
  default     = null
}

variable "status_http_port" {
  description = "The port to use for the status HTTP server"
  type        = number
  default     = 80
}

variable "status_http_conf" {
  description = "The path to the busybox httpd config file"
  type        = string
  default     = "/config/httpd.conf"
}

variable "status_http_htdocs" {
  description = "Path to the status httpd htdocs where status.json is written"
  type        = string
  default     = "/opt/valheim/htdocs"
}

variable "syslog_remote_host" {
  description = "The remote syslog host or IP to send logs to"
  type        = string
  nullable    = true
  default     = null
}

variable "syslog_remote_port" {
  description = "The remote syslog UDP port to send logs to"
  type        = number
  default     = 514
}

variable "syslog_remote_and_local" {
  description = "Whether to also log locally when sending logs to a remote syslog server"
  type        = bool
  default     = true
}

variable "puid" {
  description = "The user ID to use for the server"
  type        = number
  default     = 0
}

variable "pgid" {
  description = "The group ID to use for the server"
  type        = number
  default     = 0
}

variable "valheim_log_filter_empty" {
  description = "Whether to filter out empty log lines"
  type        = bool
  default     = true
}

variable "valheim_log_filter_utf8" {
  description = "Whether to filter out invalid UTF-8 characters"
  type        = bool
  default     = true
}

variable "valheim_log_filter_match" {
  description = "Filter log lines exactly matching"
  type        = string
  nullable    = true
  default     = " "
}

variable "valheim_log_filter_startswith" {
  description = "Filter log lines starting with"
  type        = string
  nullable    = true
  default     = "(Filename:"
}

variable "valheim_log_filter_endswith" {
  description = "Filter log lines ending with"
  type        = string
  nullable    = true
  default     = null
}

variable "valheim_log_filter_contains" {
  description = "Filter log lines containing"
  type        = string
  nullable    = true
  default     = null
}

variable "valheim_log_filter_regexp" {
  description = "Filter log lines matching regular expression"
  type        = string
  nullable    = true
  default     = null
}

variable "on_valheim_log_filter_match" {
  description = "Run command hook for log lines exactly matching"
  type        = string
  nullable    = true
  default     = null
}

variable "on_valheim_log_filter_startswith" {
  description = "Run command hook for log lines starting with"
  type        = string
  nullable    = true
  default     = null
}

variable "on_valheim_log_filter_endswith" {
  description = "Run command hook for log lines ending with"
  type        = string
  nullable    = true
  default     = null
}

variable "on_valheim_log_filter_contains" {
  description = "Run command hook for log lines containing"
  type        = string
  nullable    = true
  default     = null
}

variable "on_valheim_log_filter_regexp" {
  description = "Run command hook for log lines matching regular expression"
  type        = string
  nullable    = true
  default     = null
}

variable "pre_supervisor_hook" {
  description = "Pre-supervisord hook command"
  type        = string
  nullable    = true
  default     = null
}

variable "pre_bootstrap_hook" {
  description = "Pre-bootstrap hook command"
  type        = string
  nullable    = true
  default     = null
}

variable "post_bootstrap_hook" {
  description = "Post-bootstrap hook command"
  type        = string
  nullable    = true
  default     = null
}

variable "pre_update_check_hook" {
  description = "Pre-update check hook command"
  type        = string
  nullable    = true
  default     = null
}

variable "post_update_check_hook" {
  description = "Post-update check hook command"
  type        = string
  nullable    = true
  default     = null
}

variable "pre_start_hook" {
  description = "Pre-start hook command"
  type        = string
  nullable    = true
  default     = null
}

variable "post_start_hook" {
  description = "Post-start hook command"
  type        = string
  nullable    = true
  default     = null
}

variable "pre_restart_hook" {
  description = "Pre-restart hook command"
  type        = string
  nullable    = true
  default     = null
}

variable "post_restart_hook" {
  description = "Post-restart hook command"
  type        = string
  nullable    = true
  default     = null
}

variable "pre_server_listening_hook" {
  description = "Pre-server listening hook command"
  type        = string
  nullable    = true
  default     = null
}

variable "post_server_listening_hook" {
  description = "Post-server listening hook command"
  type        = string
  nullable    = true
  default     = null
}

variable "pre_server_run_hook" {
  description = "Pre-server run hook command"
  type        = string
  nullable    = true
  default     = null
}

variable "post_server_run_hook" {
  description = "Post-server run hook command"
  type        = string
  nullable    = true
  default     = null
}

variable "pre_server_shutdown_hook" {
  description = "Pre-server shutdown hook command"
  type        = string
  nullable    = true
  default     = null
}

variable "post_server_shutdown_hook" {
  description = "Post-server shutdown hook command"
  type        = string
  nullable    = true
  default     = null
}

variable "pre_bepinex_config_hook" {
  description = "Pre-BepInEx config hook command"
  type        = string
  nullable    = true
  default     = null
}

variable "post_bepinex_config_hook" {
  description = "Post-BepInEx config hook command"
  type        = string
  nullable    = true
  default     = null
}

variable "valheim_plus_config" {
  description = "Valheim Plus config"
  type        = map(map(any))
  nullable    = true
  default     = null
}

variable "bepinex_config" {
  description = "BepInEx config"
  type        = map(map(any))
  nullable    = true
  default     = null
}

locals {
  container_env = merge({
    SERVER_NAME                      = var.server_name
    SERVER_PORT                      = tostring(var.server_port)
    WORLD_NAME                       = var.world_name
    SERVER_PASS                      = var.server_pass
    SERVER_PUBLIC                    = var.server_public ? "1" : "0"
    SERVER_ARGS                      = join(" ", var.server_args)
    ADMINLIST_IDS                    = join(",", var.adminlist_ids)
    BANNEDLIST_IDS                   = join(",", var.bannedlist_ids)
    PERMITTEDLIST_IDS                = join(",", var.permittedlist_ids)
    UPDATE_CRON                      = var.update_cron == null ? "" : var.update_cron
    UPDATE_IF_IDLE                   = tostring(var.update_if_idle)
    RESTART_CRON                     = var.restart_cron == null ? "" : var.restart_cron
    RESTART_IF_IDLE                  = tostring(var.restart_if_idle)
    TIMEZONE                         = var.timezone
    BACKUPS                          = tostring(var.backups)
    BACKUPS_CRON                     = (!var.backups || var.backups_cron == null) ? "" : var.backups_cron
    BACKUPS_DIRECTORY                = var.backups_directory
    BACKUPS_MAX_AGE                  = tostring(var.backups_max_age)
    BACKUPS_MAX_COUNT                = tostring(var.backups_max_count)
    BACKUPS_IF_IDLE                  = tostring(var.backups_if_idle)
    BACKUPS_IDLE_GRACE_PERIOD        = tostring(var.backups_idle_grace_period)
    PERMISSIONS_UMASK                = var.permissions_umask
    STEAMCMD_ARGS                    = join(" ", var.steamcmd_args)
    VALHEIM_PLUS                     = tostring(var.mods_manager == "valheim_plus")
    BEPINEX                          = tostring(var.mods_manager == "bepinex")
    SUPERVISOR_HTTP                  = tostring(var.supervisor_http)
    SUPERVISOR_HTTP_PORT             = tostring(var.supervisor_http_port)
    SUPERVISOR_HTTP_USERNAME         = var.supervisor_http_username
    SUPERVISOR_HTTP_PASSWORD         = var.supervisor_http_password == null ? "" : var.supervisor_http_password
    STATUS_HTTP                      = "true"
    STATUS_HTTP_PORT                 = tostring(var.status_http_port)
    STATUS_HTTP_CONF                 = var.status_http_conf
    STATUS_HTTP_HTDOCS               = var.status_http_htdocs
    SYSLOG_REMOTE_HOST               = var.syslog_remote_host == null ? "" : var.syslog_remote_host
    SYSLOG_REMOTE_PORT               = var.syslog_remote_host == null ? "" : tostring(var.syslog_remote_port)
    SYSLOG_REMOTE_AND_LOCAL          = var.syslog_remote_host == null ? "" : tostring(var.syslog_remote_and_local)
    PUID                             = tostring(var.puid)
    PGID                             = tostring(var.pgid)
    VALHEIM_LOG_FILTER_EMPTY         = tostring(var.valheim_log_filter_empty)
    VALHEIM_LOG_FILTER_UTF8          = tostring(var.valheim_log_filter_utf8)
    VALHEIM_LOG_FILTER_MATCH         = var.valheim_log_filter_match == null ? "" : var.valheim_log_filter_match
    VALHEIM_LOG_FILTER_STARTSWITH    = var.valheim_log_filter_startswith == null ? "" : var.valheim_log_filter_startswith
    VALHEIM_LOG_FILTER_ENDSWITH      = var.valheim_log_filter_endswith == null ? "" : var.valheim_log_filter_endswith
    VALHEIM_LOG_FILTER_CONTAINS      = var.valheim_log_filter_contains == null ? "" : var.valheim_log_filter_contains
    VALHEIM_LOG_FILTER_REGEXP        = var.valheim_log_filter_regexp == null ? "" : var.valheim_log_filter_regexp
    ON_VALHEIM_LOG_FILTER_MATCH      = var.on_valheim_log_filter_match == null ? "" : var.on_valheim_log_filter_match
    ON_VALHEIM_LOG_FILTER_STARTSWITH = var.on_valheim_log_filter_startswith == null ? "" : var.on_valheim_log_filter_startswith
    ON_VALHEIM_LOG_FILTER_ENDSWITH   = var.on_valheim_log_filter_endswith == null ? "" : var.on_valheim_log_filter_endswith
    ON_VALHEIM_LOG_FILTER_CONTAINS   = var.on_valheim_log_filter_contains == null ? "" : var.on_valheim_log_filter_contains
    ON_VALHEIM_LOG_FILTER_REGEXP     = var.on_valheim_log_filter_regexp == null ? "" : var.on_valheim_log_filter_regexp
    PRE_SUPERVISOR_HOOK              = var.pre_supervisor_hook == null ? "" : var.pre_supervisor_hook
    PRE_BOOTSTRAP_HOOK               = var.pre_bootstrap_hook == null ? "" : var.pre_bootstrap_hook
    POST_BOOTSTRAP_HOOK              = var.post_bootstrap_hook == null ? "" : var.post_bootstrap_hook
    PRE_UPDATE_CHECK_HOOK            = var.pre_update_check_hook == null ? "" : var.pre_update_check_hook
    POST_UPDATE_CHECK_HOOK           = var.post_update_check_hook == null ? "" : var.post_update_check_hook
    PRE_START_HOOK                   = var.pre_start_hook == null ? "" : var.pre_start_hook
    POST_START_HOOK                  = var.post_start_hook == null ? "" : var.post_start_hook
    PRE_RESTART_HOOK                 = var.pre_restart_hook == null ? "" : var.pre_restart_hook
    POST_RESTART_HOOK                = var.post_restart_hook == null ? "" : var.post_restart_hook
    PRE_SERVER_LISTENING_HOOK        = var.pre_server_listening_hook == null ? "" : var.pre_server_listening_hook
    POST_SERVER_LISTENING_HOOK       = var.post_server_listening_hook == null ? "" : var.post_server_listening_hook
    PRE_SERVER_RUN_HOOK              = var.pre_server_run_hook == null ? "" : var.pre_server_run_hook
    POST_SERVER_RUN_HOOK             = var.post_server_run_hook == null ? "" : var.post_server_run_hook
    PRE_SERVER_SHUTDOWN_HOOK         = var.pre_server_shutdown_hook == null ? "" : var.pre_server_shutdown_hook
    POST_SERVER_SHUTDOWN_HOOK        = var.post_server_shutdown_hook == null ? "" : var.post_server_shutdown_hook
    PRE_BEPINEX_CONFIG_HOOK          = var.pre_bepinex_config_hook == null ? "" : var.pre_bepinex_config_hook
    POST_BEPINEX_CONFIG_HOOK         = var.post_bepinex_config_hook == null ? "" : var.post_bepinex_config_hook
    }, merge([
      for section, config in coalesce(var.valheim_plus_config, {}) :
      {
        for key, value in config :
        "VPCFG_${replace(replace(replace(replace(section, "+", "_PLUS_"), "_", "_UNDERSCORE_"), "-", "_HYPHEN_"), ".", "_DOT_")}_${key}" => tostring(value)
      }
    ]...),
    merge([
      for section, config in coalesce(var.bepinex_config, {}) :
      {
        for key, value in config :
        "BEPINEXCFG_${replace(replace(replace(replace(section, "+", "_PLUS_"), "_", "_UNDERSCORE_"), "-", "_HYPHEN_"), ".", "_DOT_")}_${key}" => tostring(value)
      }
    ]...)
  )
}
