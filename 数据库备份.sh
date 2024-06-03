#!/bin/bash

# 设置 MySQL 用户名、密码、数据库名和备份目录
MYSQL_USER="your_username"
MYSQL_PASSWORD="your_password"
DATABASE_NAME="your_database_name"
BACKUP_DIR="/path/to/your/backup/directory"

# 生成备份文件名，包含日期
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="$BACKUP_DIR/$DATABASE_NAME_$DATE.sql"

# 使用 mysqldump 创建数据库备份
mysqldump -u $MYSQL_USER -p$MYSQL_PASSWORD $DATABASE_NAME > $BACKUP_FILE

# 检查备份操作是否成功
if [ $? -eq 0 ]; then
  echo "数据库备份成功: $BACKUP_FILE"
else
  echo "备份出错了！"
fi
