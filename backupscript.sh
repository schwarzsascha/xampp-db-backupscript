#!/bin/bash
set -x
XAMPP_PATH="/Applications/XAMPP"
GIT_PATH="/Applications/GitHub.app/Contents/Resources/git/bin"
DUMP_FILEPREFIX="mysqldump"
DATABASES=("web1" "web2")
MYSQL_USER="root"
MYSQL_PASS=""

function backup {
    for DB_NAME in ${DATABASES}; do
        DUMP_FILENAME=${DUMP_FILEPREFIX}_${DB_NAME}.sql
        ${XAMPP_PATH}/xamppfiles/bin/mysqldump -u${MYSQL_USER} -p${MYSQL_PASS} -l ${DB_NAME} > ${DUMP_FILENAME}
        ${GIT_PATH}/git add ${DUMP_FILENAME}
    done
    ${GIT_PATH}/git add $0
    ${GIT_PATH}/git commit -m "Autocommit durch Script vom `date`"
}

function import {
    for DB_NAME in ${DATABASES}; do
        DUMP_FILENAME=${DUMP_FILEPREFIX}_${DB_NAME}.sql
        ${XAMPP_PATH}/xamppfiles/bin/mysql -u${MYSQL_USER} -p${MYSQL_PASS} ${DB_NAME} < ${DUMP_FILENAME}
    done
}

function usage {
    echo Hier kommt die anleitung rein!!!
}

function menu {
    OPTIONS="Backup Import Cancel"
    select opt in $OPTIONS; do
        if [ "$opt" = "Backup" ]; then
            backup
        elif [ "$opt" = "Import" ]; then
            import
        elif [ "$opt" = "Cancel" ]; then
            exit
        else
            clear
            echo Bad Option
            menu
        fi
    done
}

if [ -z "$1" ]; then
    menu
else
    if [ $1 == "-b" ]; then
        backup
    elif [ $1 == "-i" ]; then
        import
    else
        usage
    fi
fi