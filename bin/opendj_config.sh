#!/usr/bin/env bash

cat <<EOF > /home/opendj/conf/opendj-install.properties
hostname                        =$(hostname)
ldapPort                        =${BASE_PORT}
generateSelfSignedCertificate   =true
enableStartTLS                  =false
ldapsPort                       =1636
jmxPort                         =1689
adminConnectorPort              =${ROOT_PORT}
rootUserDN                      =${ROOT_DN}
rootUserPassword                =${ROOT_PWD}
baseDN                          =${BASE_DN}
EOF

cat /home/opendj/conf/opendj-install.properties

