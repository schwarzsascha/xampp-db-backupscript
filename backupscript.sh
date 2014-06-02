#!/bin/bash
XAMPP_PATH="/Applications/XAMPP"
GIT_PATH="/Applications/GitHub.app/Contents/Resources/git/bin"
DUMP_FILENAME="mysqldump.sql"

${XAMPP_PATH}/xamppfiles/bin/mysqldump -l --all-databases > ${DUMP_FILENAME}
${GIT_PATH}/git add ${DUMP_FILENAME}
${GIT_PATH}/git add $0
${GIT_PATH}/git commit