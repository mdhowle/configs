# Creates and updates a local CentOS7 repository 

/usr/bin/reposync -q -d -c /etc/yum/yum.conf --repoid=CentOS-Base --repoid=CentOS-updates --repoid=CentOS-extras -m -p /var/storage/repos/centos

/usr/bin/curl -s -o /var/storage/repos/centos/repodata/comps.xml https://git.centos.org/raw/sig-core!comps.git/HEAD/c7-x86_64-comps.xml

/usr/bin/createrepo -q -g /var/storage/repos/centos/repodata/comps.xml /var/storage/repos/centos/

