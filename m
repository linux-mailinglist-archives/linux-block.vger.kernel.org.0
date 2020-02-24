Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7779B16B2C9
	for <lists+linux-block@lfdr.de>; Mon, 24 Feb 2020 22:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgBXVkm (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 24 Feb 2020 16:40:42 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:31498 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727554AbgBXVkl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Feb 2020 16:40:41 -0500
X-Greylist: delayed 986 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Feb 2020 16:40:39 EST
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 01OLO4kA008691;
        Mon, 24 Feb 2020 22:24:04 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 00/10] floppy driver cleanups (deobfuscation)
Date:   Mon, 24 Feb 2020 22:23:42 +0100
Message-Id: <20200224212352.8640-1-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As indicated in commit 2e90ca6 ("floppy: check FDC index for errors
before assigning it") there are some surprising effects in the floppy
driver due to some macros referencing global or local variables while
at first glance being inoffensive.

This patchset aims at removing these macros and replacing all of their
occurrences by the equivalent code. Most of the work was done under
Coccinelle's assistance, and it was verified that the resulting binary
code is exactly the same as the original one.

The aim is not to make the driver prettier, as Linus mentioned it's
already not pretty. It only aims at making potential bugs more visible,
given almost all latest changes to this driver were fixes for out-of-
bounds and similar bugs.

As a side effect, some lines got longer, causing checkpatch to complain
a bit, but I preferred to let it complain as I didn't want to break them
apart as I'm already seeing the trap of going too far here.

The patches are broken by macro (or sets of macros when relevant) so
that each of them remains reviewable.

I can possibly go a bit further in the cleanup but I haven't used
floppies for a few years now and am not interested in doing too much
on this driver by lack of use cases.

Willy Tarreau (10):
  floppy: cleanup: expand macro FDCS
  floppy: cleanup: expand macro UFDCS
  floppy: cleanup: expand macro UDP
  floppy: cleanup: expand macro UDRS
  floppy: cleanup: expand macro UDRWE
  floppy: cleanup: expand macro DP
  floppy: cleanup: expand macro DRS
  floppy: cleanup: expand macro DRWE
  floppy: cleanup: expand the R/W / format command macros
  floppy: cleanup: expand the reply_buffer macros

 drivers/block/floppy.c | 971 +++++++++++++++++++++++++------------------------
 1 file changed, 499 insertions(+), 472 deletions(-)

-- 
2.9.0

