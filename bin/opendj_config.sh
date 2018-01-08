#!/usr/bin/env bash

cat <<EOF > /home/opendj/conf/basedn.ldif
dn: dc=sk
objectClass: domain
objectClass: top
dc: sk

dn: dc=st,dc=sk
objectClass: domain
objectClass: top
dc: st
aci: (target ="ldap:///dc=st,dc=sk")(targetattr !=
 "userPassword")(version 3.0;acl "Anonymous read-search access";
 allow (read, search, compare)(userdn = "ldap:///anyone");)
EOF

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
ldifFile                        =/home/opendj/conf/basedn.ldif
EOF

cat /home/opendj/conf/opendj-install.properties

