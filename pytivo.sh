#!/bin/bash

/sbin/setuser nobody cp -R -u -p /opt/pytivo/lucasnz/pyTivo.conf.dist /config/pyTivo.conf
exec /sbin/setuser nobody python /opt/pytivo/lucasnz/pyTivo.py -c /config/pyTivo.conf
