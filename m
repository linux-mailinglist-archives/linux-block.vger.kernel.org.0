Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E90D17A49B
	for <lists+linux-block@lfdr.de>; Thu,  5 Mar 2020 12:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgCELxB (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 5 Mar 2020 06:53:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:51156 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbgCELxB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 5 Mar 2020 06:53:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4FA8EAD5F;
        Thu,  5 Mar 2020 11:52:59 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        James Smart <james.smart@broadcom.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH blktests 0/3] ANA and fcloop tests
Date:   Thu,  5 Mar 2020 12:52:36 +0100
Message-Id: <20200305115239.29794-1-hare@suse.de>
X-Mailer: git-send-email 2.13.7
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Omar,

here are two small tests which have been lingering in my repository
for far too long, so I figured it's time to finally post them.
The first is a rather trivial one for testing ANA states, the second
finally adds a test case for the FC Loop driver.
It also serves as a template on how to actually _use_ the FC Loop
driver itself :-)

However, that one uncovered a use-after-free issue in the NVMe-FC
stack; check the 'Fixme' line in the test. As it _might_ be a generic
issue and not something specific to fcloop I'm posting it now to
allow other people (Hi James!) to reproduce and possibly fix it.

As usual, comments and reviews are welcome.

Hannes Reinecke (3):
  nvme: enable ANA support
  nvme/033: add test for ANA state transition
  tests/nvme/034: Add a test for the fcloop driver

 common/fcloop      |  58 ++++++++++++++++++++++
 tests/nvme/033     | 139 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/033.out |  18 +++++++
 tests/nvme/034     | 122 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/034.out |   3 ++
 tests/nvme/rc      |  88 +++++++++++++++++++++++++++++++--
 6 files changed, 425 insertions(+), 3 deletions(-)
 create mode 100644 common/fcloop
 create mode 100644 tests/nvme/033
 create mode 100644 tests/nvme/033.out
 create mode 100644 tests/nvme/034
 create mode 100644 tests/nvme/034.out

-- 
2.13.7

