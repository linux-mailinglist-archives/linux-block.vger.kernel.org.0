Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46EDE1F3D6F
	for <lists+linux-block@lfdr.de>; Tue,  9 Jun 2020 15:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729560AbgFIN7d (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 9 Jun 2020 09:59:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59812 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728196AbgFIN7c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 9 Jun 2020 09:59:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591711170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PU0wugIUDqvMdTUsJ3AZiwm1jKkCLEkGcJUR3JJu+Uw=;
        b=S3wuWeX2aZyPOuLm2+9zoHuND/geUTArlL5EY0I54IivATcggmZ0hXK5ngwUs6ZBvkbsUK
        wuJkBLZRpG/CmRL2FFFm1gYI+A018yknNPiBv46WEgsM43zH3efPH5QP8TKJHRSy04eCF6
        2RKnNb+buxFruig5h9C65/6sJCgicW8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-Y2pdaTT-No6etut69bClBw-1; Tue, 09 Jun 2020 09:59:26 -0400
X-MC-Unique: Y2pdaTT-No6etut69bClBw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2EA30107ACCD;
        Tue,  9 Jun 2020 13:59:24 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C96B4768AE;
        Tue,  9 Jun 2020 13:59:20 +0000 (UTC)
Date:   Tue, 9 Jun 2020 09:59:19 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Dmitry Baryshkov <dmitry_baryshkov@mentor.com>,
        Eric Biggers <ebiggers@google.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        Martin Wilck <mwilck@suse.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>
Subject: [git pull v3] device mapper changes for 5.8
Message-ID: <20200609135919.GA26994@redhat.com>
References: <20200605145124.GA31972@redhat.com>
 <20200605191613.GA621@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605191613.GA621@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

[resending as v3 due to my From: email addr in v2 being inexplicably wrong]

Hi Linus,

I had some miscommunication with Mikulas on his -ENOMEM sleep and retry
changes for dm-crypt and dm-integrity, he no longer thinks them
appropriate: https://www.redhat.com/archives/dm-devel/2020-June/msg00061.html
So I dropped them via rebase and updated the tag (to avoid any
potential for linux-stable churn due to Mikulas' commits having
cc'd linux-stable).  Hope that was the correct way forward...

For the following changes there is one dm-zoned-metadata.c conflict that
linux-next has been carrying for a while.  See commit d77e96f277 ("Merge
remote-tracking branch 'device-mapper/for-next'") from next-20200605.
It resolves conflict from linux-block's commit 9398554fb3 ("block:
remove the_error_sector argument to blkdev_issue_flush").

The following changes since commit 2ef96a5bb12be62ef75b5828c0aab838ebb29cb8:

  Linux 5.7-rc5 (2020-05-10 15:16:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.8/dm-changes

for you to fetch changes up to 64611a15ca9da91ff532982429c44686f4593b5f:

  dm crypt: avoid truncating the logical block size (2020-06-05 14:59:59 -0400)

Please pull, thanks!
Mike

----------------------------------------------------------------
- Largest change for this cycle is the DM zoned target's metadata
  version 2 feature that adds support for pairing regular block
  devices with a zoned device to ease performance impact associated
  with finite random zones of zoned device.  Changes came in 3
  batches: first prepared for and then added the ability to pair a
  single regular block device, second was a batch of fixes to improve
  zoned's reclaim heuristic, third removed the limitation of only
  adding a single additional regular block device to allow many
  devices.  Testing has shown linear scaling as more devices are
  added.

- Add new emulated block size (ebs) target that emulates a smaller
  logical_block_size than a block device supports.  Primary use-case
  is to emulate "512e" devices that have 512 byte logical_block_size
  and 4KB physical_block_size.  This is useful to some legacy
  applications otherwise wouldn't be ablee to be used on 4K devices
  because they depend on issuing IO in 512 byte granularity.

- Add discard interfaces to DM bufio.  First consumer of the interface
  is the dm-ebs target that makes heavy use of dm-bufio.

- Fix DM crypt's block queue_limits stacking to not truncate
  logic_block_size.

- Add Documentation for DM integrity's status line.

- Switch DMDEBUG from a compile time config option to instead use
  dynamic debug via pr_debug.

- Fix DM multipath target's hueristic for how it manages
  "queue_if_no_path" state internally.  DM multipath now avoids
  disabling "queue_if_no_path" unless it is actually needed (e.g. in
  response to configure timeout or explicit "fail_if_no_path"
  message).  This fixes reports of spurious -EIO being reported back
  to userspace application during fault tolerance testing with an NVMe
  backend.  Added various dynamic DMDEBUG messages to assist with
  debugging queue_if_no_path in the future.

- Add a new DM multipath "Historical Service Time" Path Selector.

- Fix DM multipath's dm_blk_ioctl() to switch paths on IO error.

- Improve DM writecache target performance by using explicit
  cache flushing for target's single-threaded usecase and a small
  cleanup to remove unnecessary test in persistent_memory_claim.

- Other small cleanups in DM core, dm-persistent-data, and DM integrity.

----------------------------------------------------------------
Dmitry Baryshkov (1):
      dm crypt: support using encrypted keys

Eric Biggers (1):
      dm crypt: avoid truncating the logical block size

Gabriel Krisman Bertazi (1):
      dm mpath: pass IO start time to path selector

Gustavo A. R. Silva (1):
      dm: replace zero-length array with flexible-array

Hannes Reinecke (38):
      dm zoned: add 'status' callback
      dm zoned: add 'message' callback
      dm zoned: store zone id within the zone structure and kill dmz_id()
      dm zoned: use array for superblock zones
      dm zoned: store device in struct dmz_sb
      dm zoned: move fields from struct dmz_dev to dmz_metadata
      dm zoned: introduce dmz_metadata_label() to format device name
      dm zoned: Introduce dmz_dev_is_dying() and dmz_check_dev()
      dm zoned: remove 'dev' argument from reclaim
      dm zoned: replace 'target' pointer in the bio context
      dm zoned: use dmz_zone_to_dev() when handling metadata I/O
      dm zoned: add metadata logging functions
      dm zoned: Reduce logging output on startup
      dm zoned: ignore metadata zone in dmz_alloc_zone()
      dm zoned: metadata version 2
      dm: use dynamic debug instead of compile-time config option
      dm zoned: remove spurious newlines from debugging messages
      dm zoned: return NULL if dmz_get_zone_for_reclaim() fails to find a zone
      dm zoned: separate random and cache zones
      dm zoned: reclaim random zones when idle
      dm zoned: start reclaim with sequential zones
      dm zoned: terminate reclaim on congestion
      dm zoned: remove leftover hunk for switching to sequential zones
      dm zoned: add debugging message for reading superblocks
      dm zoned: avoid unnecessary device recalulation for secondary superblock
      dm zoned: improve logging messages for reclaim
      dm zoned: add a 'reserved' zone flag
      dm zoned: convert to xarray
      dm zoned: allocate temporary superblock for tertiary devices
      dm zoned: add device pointer to struct dm_zone
      dm zoned: add metadata pointer to struct dmz_dev
      dm zoned: per-device reclaim
      dm zoned: move random and sequential zones into struct dmz_dev
      dm zoned: support arbitrary number of devices
      dm zoned: allocate zone by device index
      dm zoned: select reclaim zone based on device index
      dm zoned: prefer full zones for reclaim
      dm zoned: check superblock location

Heinz Mauelshagen (2):
      dm: add emulated block size target
      dm ebs: pass discards down to underlying device

Khazhismel Kumykov (1):
      dm mpath: add Historical Service Time Path Selector

Martin Wilck (1):
      dm mpath: switch paths in dm_blk_ioctl() code path

Mike Snitzer (5):
      dm: use DMDEBUG macros now that they use pr_debug variants
      dm mpath: simplify __must_push_back
      dm mpath: restrict queue_if_no_path state machine
      dm mpath: enhance queue_if_no_path debugging
      dm mpath: add DM device name to Failing/Reinstating path log messages

Mikulas Patocka (8):
      dm bufio: implement discard
      dm writecache: remove superfluous test in persistent_memory_claim
      dm writecache: improve performance on DDR persistent memory (Optane)
      dm bufio: delete unused and inefficient dm_bufio_discard_buffers
      dm integrity: add status line documentation
      dm bufio: clean up rbtree block ordering
      dm bufio: introduce forget_buffer_locked
      dm ebs: use dm_bufio_forget_buffers

Nathan Chancellor (1):
      dm zoned: Avoid 64-bit division error in dmz_fixup_devices

YueHaibing (1):
      dm integrity: remove set but not used variables

Zhiqiang Liu (1):
      dm persistent data: switch exit_ro_spine to return void

 Documentation/admin-guide/device-mapper/dm-ebs.rst |   51 +
 .../admin-guide/device-mapper/dm-integrity.rst     |    8 +
 .../admin-guide/device-mapper/dm-zoned.rst         |   62 +-
 drivers/md/Kconfig                                 |   20 +
 drivers/md/Makefile                                |    3 +
 drivers/md/dm-bufio.c                              |  109 +-
 drivers/md/dm-crypt.c                              |   80 +-
 drivers/md/dm-ebs-target.c                         |  471 +++++++++
 drivers/md/dm-historical-service-time.c            |  561 +++++++++++
 drivers/md/dm-integrity.c                          |    6 +-
 drivers/md/dm-log-writes.c                         |    2 +-
 drivers/md/dm-mpath.c                              |  123 ++-
 drivers/md/dm-path-selector.h                      |    2 +-
 drivers/md/dm-queue-length.c                       |    2 +-
 drivers/md/dm-raid.c                               |    2 +-
 drivers/md/dm-raid1.c                              |    2 +-
 drivers/md/dm-service-time.c                       |    2 +-
 drivers/md/dm-stats.c                              |    2 +-
 drivers/md/dm-stripe.c                             |    2 +-
 drivers/md/dm-switch.c                             |    2 +-
 drivers/md/dm-writecache.c                         |   42 +-
 drivers/md/dm-zoned-metadata.c                     | 1046 +++++++++++++++-----
 drivers/md/dm-zoned-reclaim.c                      |  210 ++--
 drivers/md/dm-zoned-target.c                       |  463 ++++++---
 drivers/md/dm-zoned.h                              |  113 ++-
 drivers/md/dm.c                                    |   11 +-
 drivers/md/persistent-data/dm-btree-internal.h     |    4 +-
 drivers/md/persistent-data/dm-btree-spine.c        |    6 +-
 include/linux/device-mapper.h                      |    9 +-
 include/linux/dm-bufio.h                           |   12 +
 30 files changed, 2779 insertions(+), 649 deletions(-)
 create mode 100644 Documentation/admin-guide/device-mapper/dm-ebs.rst
 create mode 100644 drivers/md/dm-ebs-target.c
 create mode 100644 drivers/md/dm-historical-service-time.c

