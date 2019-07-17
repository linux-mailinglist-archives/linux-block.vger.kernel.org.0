Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC9286C01D
	for <lists+linux-block@lfdr.de>; Wed, 17 Jul 2019 19:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731098AbfGQRNO (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 17 Jul 2019 13:13:14 -0400
Received: from ale.deltatee.com ([207.54.116.67]:60178 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731111AbfGQRNO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jul 2019 13:13:14 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hnnUM-00012n-Uz; Wed, 17 Jul 2019 11:13:13 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hnnUJ-0000sJ-W9; Wed, 17 Jul 2019 11:13:08 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Omar Sandoval <osandov@fb.com>
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Michael Moese <mmoese@suse.de>, Theodore Ts'o <tytso@mit.edu>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed, 17 Jul 2019 11:12:47 -0600
Message-Id: <20190717171259.3311-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, osandov@fb.com, chaitanya.kulkarni@wdc.com, tytso@mit.edu, mmoese@suse.de, jthumshirn@suse.de, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_NO_TEXT autolearn=no autolearn_force=no version=3.4.2
Subject: [PATCH blktests v2 00/12] Fix nvme block test issues
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Changes since v1:
 * Use second sed expression instead of another call to grep
   in _filter_discovery() for Patch 2 (per Omar)
 * Redirect error output to $FULL in for nvme/018 in Patch 7
   (Per Johannes)
 * Rework _have_module_param() in Patch 11 so that it supports
   cases where the module is not inserted.

--

This patchset cleans up a number of issues and pain points
I've had with getting the nvme blktests to pass and run cleanly.

The first three patches are meant to fix the Generation Counter
issue that's been discussed before but hasn't been fixed in months.
I primarily use a slightly fixed up patch posted by Michael Moese[1]
but add another patch to properly test the Generation Counter that
would no longer be tested otherwise.

I've also taken it a step further to filter out more of the discovery
information so that we are less fragile against churn and less dependant
on the version of nvme-cli in use. This should also fix the issue discussed
in [2].

Patches 4 through 7 fix a number of smaller issues I've found with
individual tests.

Patches 8 through 10 implement a system to ensure the nvme tests
clean themselves up properly especially when ctrl-c is used to
interrupt a test (working with the tests before this was a huge
pain seeing,  when you ctrl-c, you have to either manually clean
up the nvmet configuration or reboot to get the system in a state
where it's sane to run the tests again).

Patches 11 and 12 make some minor changes that allow running the
tests with the nvme modules built into the kernel.

With these patches, plus a couple I've sent to the nvme list for the
kernel, I can consistently pass the entire nvme suite with the
exception of the lockdep false-positive with nvme/012 that still
seems to be in a bit of contention[3].

[1] https://github.com/osandov/blktests/pull/34
[2] https://lore.kernel.org/linux-block/20190505150611.15776-4-minwoo.im.dev@gmail.com/
[3] https://lore.kernel.org/lkml/20190214230058.196511-22-bvanassche@acm.org/

--

Logan Gunthorpe (11):
  nvme: More agressively filter the discovery output
  nvme: Add new test to verify the generation counter
  nvme/003,004: Add missing calls to nvme disconnect
  nvme/005: Don't rely on modprobing to set the multipath paramater
  nvme/015: Ensure the namespace is flushed not the char device
  nvme/018: Ignore error message generated by nvme read
  check: Add the ability to call a cleanup function after a test ends
  nvme: Cleanup modprobe lines into helper functions
  nvme: Ensure all ports and subsystems are removed on cleanup
  common: Use sysfs instead of modinfo for _have_module_param()
  nvme: Ignore errors when removing modules

Michael Moese (1):
  Add filter function for nvme discover

 check              |    9 +
 common/rc          |   24 +
 tests/nvme/002     |   10 +-
 tests/nvme/002.out | 6003 +-------------------------------------------
 tests/nvme/003     |    6 +-
 tests/nvme/003.out |    1 +
 tests/nvme/004     |    6 +-
 tests/nvme/004.out |    1 +
 tests/nvme/005     |   16 +-
 tests/nvme/006     |    6 +-
 tests/nvme/007     |    6 +-
 tests/nvme/008     |    6 +-
 tests/nvme/009     |    5 +-
 tests/nvme/010     |    6 +-
 tests/nvme/011     |    6 +-
 tests/nvme/012     |    6 +-
 tests/nvme/013     |    6 +-
 tests/nvme/014     |    6 +-
 tests/nvme/015     |    5 +-
 tests/nvme/016     |    6 +-
 tests/nvme/016.out |    9 +-
 tests/nvme/017     |    8 +-
 tests/nvme/017.out |    9 +-
 tests/nvme/018     |    8 +-
 tests/nvme/019     |    6 +-
 tests/nvme/020     |    5 +-
 tests/nvme/021     |    6 +-
 tests/nvme/022     |    6 +-
 tests/nvme/023     |    6 +-
 tests/nvme/024     |    6 +-
 tests/nvme/025     |    6 +-
 tests/nvme/026     |    6 +-
 tests/nvme/027     |    6 +-
 tests/nvme/028     |    6 +-
 tests/nvme/029     |    6 +-
 tests/nvme/030     |   72 +
 tests/nvme/030.out |    2 +
 tests/nvme/rc      |   65 +
 38 files changed, 216 insertions(+), 6162 deletions(-)
 create mode 100755 tests/nvme/030
 create mode 100644 tests/nvme/030.out

--
2.17.1
