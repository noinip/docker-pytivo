#!/bin/bash

cp -R -u -p /opt/pytivo/lucasnz/pyTivo.conf.dist /config/pyTivo.conf
/opt/pytivo/lucasnz/pyTivo.py -c /config/pyTivo.conf
