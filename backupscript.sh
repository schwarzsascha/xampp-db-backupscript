#!/bin/bash
XAMPP_PATH="/Applications/XAMPP"
GIT_PATH="/Applications/GitHub.app/Contents/Resources/git/bin"
DUMP_FILEPREFIX="mysqldump"
DATABASES=("web1" "web2")
MYSQL_USER="root"
MYSQL_PASS=""

function backup {
    for DB_NAME in ${DATABASES}; do
        DUMP_FILENAME=${DUMP_FILEPREFIX}_${DB_NAME}.sql
        ${XAMPP_PATH}/xamppfiles/bin/mysqldump -l ${DB_NAME} > ${DUMP_FILENAME}
        ${GIT_PATH}/git add ${DUMP_FILENAME}
    done
    ${GIT_PATH}/git add $0
    ${GIT_PATH}/git commit -m "Autocommit durch Script vom `date`"
}

function import {
    for DB_NAME in ${DATABASES}; do
        DUMP_FILENAME=${DUMP_FILEPREFIX}_${DB_NAME}.sql
        ${XAMPP_PATH}/xamppfiles/bin/mysql -u${MYSQL_USER} -p${MYSQL_USER} ${DB_NAME}  > ${DUMP_FILENAME}
    done
}