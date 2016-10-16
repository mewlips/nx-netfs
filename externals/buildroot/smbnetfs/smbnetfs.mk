################################################################################
#
# smbnetfs
#
################################################################################

SMBNETFS_VERSION = 0.6.0
SMBNETFS_SOURCE = smbnetfs-$(SMBNETFS_VERSION).tar.bz2
SMBNETFS_SITE = http://downloads.sourceforge.net/smbnetfs

$(eval $(autotools-package))
