refspec = master
EXTRA_VARS := refspec=$(refspec)

ifneq ($(vers),)
	EXTRA_VARS += version=$(vers)
endif

ifneq ($(arch),)
	EXTRA_VARS += arch=$(arch)
endif

ifneq ($(git_repo_url),)
	EXTRA_VARS += git_repo_url=$(git_repo_url)
endif

ifneq ($(ceph_repo_base_url),)
	EXTRA_VARS += ceph_repo_base_url=$(ceph_repo_base_url)
endif

ifneq ($(ceph_repo_gpgkey),)
	EXTRA_VARS += ceph_repo_gpgkey=$(ceph_repo_gpgkey)
endif

ifneq ($(vendor_dist_suffix),)
	EXTRA_VARS += vendor_dist_suffix=$(vendor_dist_suffix)
endif

prep.dirs:
	@ansible-playbook --inventory localhost, ./ansible/prep.dirs.yml

tarball:
	@ansible-playbook --inventory localhost, ./ansible/make.tarball.yml --extra-vars "$(EXTRA_VARS)"

srpm:
	@ansible-playbook --inventory localhost, ./ansible/build.srpm.yml --extra-vars "$(EXTRA_VARS)"


rpms.centos:
	@ansible-playbook --inventory localhost, ./ansible/build.rpms.centos.yml --extra-vars "$(EXTRA_VARS)"

test.rpms.centos:
	@ansible-playbook --inventory localhost, ./ansible/test.rpms.centos.yml --extra-vars "$(EXTRA_VARS)"


rpms.rhel:
	@ansible-playbook --inventory localhost, ./ansible/build.rpms.rhel.yml --extra-vars "$(EXTRA_VARS)"

test.rpms.rhel:
	@ansible-playbook --inventory localhost, ./ansible/test.rpms.rhel.yml --extra-vars "$(EXTRA_VARS)"


rpms.fedora:
	@ansible-playbook --inventory localhost, ./ansible/build.rpms.fedora.yml --skip-tags repos --extra-vars "$(EXTRA_VARS)"

test.rpms.fedora:
	@ansible-playbook --inventory localhost, ./ansible/test.rpms.fedora.yml --skip-tags repos --extra-vars "$(EXTRA_VARS)"
