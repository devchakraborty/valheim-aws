import os
from logging import INFO, basicConfig, getLogger
from typing import Any, Dict

import boto3

logger = getLogger(__name__)
basicConfig(level=INFO)

def main(event: Dict[str, Any], context: Any) -> None:
    DATA_SYNC_TASK_ARN = os.environ.get("DATA_SYNC_TASK_ARN")
    if not DATA_SYNC_TASK_ARN:
        logger.warning("DATA_SYNC_TASK_ARN env var not set, skipping data sync")
        return

    AWS_REGION = os.environ.get("AWS_REGION")
    if not AWS_REGION:
        logger.warning("AWS_REGION env var not set, skipping data sync")
        return

    client = boto3.client("datasync", region_name=AWS_REGION)
    client.start_task_execution(TaskArn=DATA_SYNC_TASK_ARN)
    logger.info(f"Launched data sync task: {DATA_SYNC_TASK_ARN}")
