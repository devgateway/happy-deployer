#!/bin/bash

echo 'Removing installed puppet modules (if any):'
find /etc/puppet/modules -depth -mindepth 1 -maxdepth 1 -type d -not -name site -print -exec rm -rf {} \;
