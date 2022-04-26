#!/bin/bash

# shellcheck disable=SC1090,SC1091

set -o errexit
set -o nounset
set -o pipefail
# set -o xtrace # Uncomment this line for debugging purpose

# Load JasperReports environment
. /opt/bitnami/scripts/jasperreports-env.sh

# Load MySQL Client environment for 'mysql_remote_execute' (after 'jasperreports-env.sh' so that MODULE is not set to a wrong value)
if [[ "$JASPERREPORTS_DATABASE_TYPE" = "pgsql" ]]; then
    # Load PostgreSQL Client environment for 'postgresql_remote_execute'
    if [[ -f /opt/bitnami/scripts/postgresql-client-env.sh ]]; then
        . /opt/bitnami/scripts/postgresql-client-env.sh
    elif [[ -f /opt/bitnami/scripts/postgresql-env.sh ]]; then
        . /opt/bitnami/scripts/postgresql-env.sh
    fi
else
    if [[ -f /opt/bitnami/scripts/mysql-client-env.sh ]]; then
        . /opt/bitnami/scripts/mysql-client-env.sh
    elif [[ -f /opt/bitnami/scripts/mysql-env.sh ]]; then
        . /opt/bitnami/scripts/mysql-env.sh
    elif [[ -f /opt/bitnami/scripts/mariadb-env.sh ]]; then
        . /opt/bitnami/scripts/mariadb-env.sh
    fi
fi


# Load libraries
. /opt/bitnami/scripts/libjasperreports.sh

# Ensure JasperReports environment variables are valid
jasperreports_validate

# Ensure JasperReports is initialized
jasperreports_initialize
