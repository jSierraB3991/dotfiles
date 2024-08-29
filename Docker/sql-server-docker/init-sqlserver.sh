#!/bin/bash
mkdir -p /.system
chown -R mssql:mssql /.system /var/opt/mssql
exec /opt/mssql/bin/sqlservr
