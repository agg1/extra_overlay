#!/bin/sh

mkdir -p extra_overlay/{metadata,profiles}
echo 'extra' > extra_overlay/profiles/repo_name
echo 'masters = gentoo' > extra_overlay/metadata/layout.conf
chown -R portage:portage extra_overlay
# version bump with new ebuild script
#repoman --digest=y -d full
