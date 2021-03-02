Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF12B32AE84
	for <lists+linux-block@lfdr.de>; Wed,  3 Mar 2021 03:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhCBXlU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 2 Mar 2021 18:41:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:39242 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235811AbhCBEHs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Mar 2021 23:07:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 59F06AD74;
        Tue,  2 Mar 2021 04:03:00 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-block@vger.kernel.org, axboe@kernel.dk,
        dan.j.williams@intel.com, vishal.l.verma@intel.com, neilb@suse.de
Cc:     antlists@youngman.org.uk, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-nvdimm@lists.01.org,
        Coly Li <colyli@suse.de>
Subject: [RFC PATCH v1 0/6] badblocks improvement for multiple bad block ranges 
Date:   Tue,  2 Mar 2021 12:02:46 +0800
Message-Id: <20210302040252.103720-1-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is the first completed effort to improve badblocks code to handle
multiple ranges in bad block table.

There is neither in-memory nor on-disk format change in this series, all
existing API and data structures are consistent. This series just only
improve the code algorithm to handle more corner cases, the interfaces
are same and consistency to all existing callers (md raid and nvdimm
drivers).

The original motivation of the change is from the requirement from our
customer, that current badblocks routines don't handle multiple ranges.
For example if the bad block setting range covers multiple ranges from
bad block table, only the first two bad block ranges merged and rested
ranges are intact. The expected behavior should be all the covered
ranges to be handled.

All the patches are tested by modified user space code and the code
logic works as expected. Kernel space testing and debugging is on the
way while I am asking help for code review at the same time.

The whole change is divided into 6 patches to make the code review more
clear and easier. If people prefer, I'd like to post a single large
patch finally after the code review accomplished.

Thank you in advance for any review comment and suggestion.

Coly Li (6):
  badblocks: add more helper structure and routines in badblocks.h
  badblocks: add helper routines for badblock ranges handling
  badblocks: improvement badblocks_set() for multiple ranges handling
  badblocks: improve badblocks_clear() for multiple ranges handling
  badblocks: improve badblocks_check() for multiple ranges handling
  badblocks: switch to the improved badblock handling code

 block/badblocks.c         | 1591 ++++++++++++++++++++++++++++++-------
 include/linux/badblocks.h |   32 +
 2 files changed, 1332 insertions(+), 291 deletions(-)

-- 
2.26.2

