// Note: We use this variable because terraform does not support "count" for module resources
// https://github.com/hashicorp/terraform/issues/953
variable "enabled" {
  default     = true
  description = "If true, the Lambda function and all associated components will be created"
}

variable "function_name" {
  description = "Name of the Lambda function"
}

variable "description" {
  default     = ""
  description = "Description of the Lambda function"
}

variable "runtime" {
  default     = "python2.7"
  description = "Function runtime environment"
}

variable "handler" {
  description = "Entry point for the function"
}

variable "memory_size_mb" {
  default     = 128
  description = "Memory allocated to the function. CPU and network are allocated proportionally."
}

variable "timeout_sec" {
  default     = 30
  description = "Maximum duration before execution is terminated"
}

variable "source_bucket" {
  description = "S3 bucket containing function source code"
}

variable "source_object_key" {
  description = "S3 object key pointing to the function source code"
}

// NOTE: Due to https://github.com/terraform-providers/terraform-provider-aws/issues/3803,
// 0 is interpreted as "disable reserve concurrency," and is the default value in Terraform.
// (You can set reserve concurrency to 0 in the AWS console to stop all invocations.)
// This could change in a future release of the AWS provider.
variable "concurrency_limit" {
  default     = 0
  description = "Optional reserved concurrency. By default, there is no function-specific concurrency limit."
}

variable "environment_variables" {
  type        = "map"
  description = "Map of environment variables available to the running Lambda function"
}

variable "vpc_subnet_ids" {
  type        = "list"
  default     = []
  description = "Optional list of VPC subnet IDs"
}

variable "vpc_security_group_ids" {
  type        = "list"
  default     = []
  description = "Optional list of security group IDs (for VPC)"
}

variable "name_tag" {
  default     = "StreamAlert"
  description = "The value for the Name cost tag associated with all applicable components"
}

variable "auto_publish_versions" {
  default     = false
  description = "Whether Terraform should automatically publish new versions of the function"
}

variable "alias_name" {
  default     = "production"
  description = "An alias with this name is automatically created which points to aliased_version"
}

variable "aliased_version" {
  default     = ""
  description = "Alias points to this version (or the latest published version if not specified)"
}

variable "schedule_expression" {
  default     = ""
  description = "Optional rate() or cron() expression to schedule the Lambda function at regular intervals"
}

variable "log_retention_days" {
  default     = 14
  description = "CloudWatch logs for the Lambda function will be retained for this many days"
}

variable "log_metric_filter_namespace" {
  default     = "StreamAlert"
  description = "Namespace for metrics generated from metric filters"
}

variable "log_metric_filters" {
  type        = "list"
  default     = []
  description = "Metric filters applied to the log group. Each filter should be in the format \"filter_name,filter_pattern,value\""
}

// ***** CloudWatch metric alarms *****

variable "alarm_actions" {
  type        = "list"
  default     = []
  description = "Optional list of CloudWatch alarm actions (e.g. SNS topic ARNs)"
}

variable "errors_alarm_enabled" {
  default     = true
  description = "Enable CloudWatch metric alarm for invocation errors"
}

variable "errors_alarm_threshold" {
  default     = 0
  description = "Alarm if Lambda invocation errors exceed this value in the specified period(s)"
}

variable "errors_alarm_evaluation_periods" {
  default     = 1
  description = "Consecutive periods the errors threshold must be breached before triggering an alarm"
}

variable "errors_alarm_period_secs" {
  default     = 120
  description = "Period over which to count the number of invocation errors"
}

variable "throttles_alarm_enabled" {
  default     = true
  description = "Enable CloudWatch metric alarm for throttled executions"
}

variable "throttles_alarm_threshold" {
  default     = 0
  description = "Alarm if Lambda throttles exceed this value in the specified period(s)"
}

variable "throttles_alarm_evaluation_periods" {
  default     = 1
  description = "Consecutive periods the throttles threshold must be breached before triggering an alarm"
}

variable "throttles_alarm_period_secs" {
  default     = 120
  description = "Period over which to count the number of throttles"
}

variable "iterator_age_alarm_enabled" {
  default     = false
  description = "Enable IteratorAge alarm (applicable only for stream-based invocations like Kinesis)"
}

variable "iterator_age_alarm_threshold_ms" {
  default     = 3600000
  description = "Alarm if the Lambda IteratorAge (ms) exceeds this value in the specified period(s)"
}

variable "iterator_age_alarm_evaluation_periods" {
  default     = 1
  description = "Consecutive periods the IteratorAge threshold must be breached before triggering an alarm"
}

variable "iterator_age_alarm_period_secs" {
  default     = 120
  description = "Period over which to evaluate the maximum IteratorAge"
}
