#!/bin/bash

set -e

subscription-manager register --org "${ORG_ID}" --activationkey "${ACT_KEY}"

dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-${OS_VERS}.noarch.rpm

dnf -y install mock rpm-build

if [ -z "$VENDOR_DIST_SUFFIX" ]; then
	mock --root "${MOCK_DIR}/rhel-${OS_VERS}-${OS_ARCH}.cfg" --resultdir "${RPMS_DIR}/${SAMBA_VERS}/rhel/${OS_VERS}/${OS_ARCH}" --rebuild "${SRPM_DIR}/${SAMBA_SRPM}"
else
	mock --root "${MOCK_DIR}/rhel-${OS_VERS}-${OS_ARCH}.cfg" --resultdir "${RPMS_DIR}/${SAMBA_VERS}/rhel/${OS_VERS}/${OS_ARCH}" --define "vendor_dist ${VENDOR_DIST_SUFFIX}" --rebuild "${SRPM_DIR}/${SAMBA_SRPM}"
fi

subscription-manager unregister
