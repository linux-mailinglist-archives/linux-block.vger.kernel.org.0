Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73FE5174F4C
	for <lists+linux-block@lfdr.de>; Sun,  1 Mar 2020 20:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgCAT4N (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 1 Mar 2020 14:56:13 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:32048 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgCAT4N (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 1 Mar 2020 14:56:13 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 021Ju4b7011200;
        Sun, 1 Mar 2020 20:56:04 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v2 0/6] floppy: make use of the local/global fdc explicit
Date:   Sun,  1 Mar 2020 20:55:49 +0100
Message-Id: <20200301195555.11154-1-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an update to the first minimal cleanup of the floppy driver in
order to make use of the FDC number explicit so as to avoid bugs like
the one fixed by 2e90ca68 ("floppy: check FDC index for errors before
assigning it").

The purpose of this patchset is to rename the "fdc" global variable to
"current_fdc" as Linus suggested and adjust the macros which rely on it
depending on their context.

The most problematic part at this step are the FD_* macros derived
from FD_IOPORT, itself referencing the fdc to get its base address.
These are exclusively used by fd_outb() and fd_inb(). However on ARM
FD_DOR is also used to compare the register based on the port, hence
a small change in the ARM specific code to only check the register
without relying on this hidden memory access.

In order to avoid touching the fd_outb() and fd_inb() macros/functions
on all supported architectures, a new set of fdc_outb()/fdc_inb()
functions was added to the driver to call the former after adding
the register to the FDC's base address.

There are still opportunities for more cleanup, though it's uncertain
they're welcome in this old driver :
  - the base address and register can be passed separately to fd_outb()
    and fd_inb() in order to simplify register retrieval in some archs;

  - a dozen of functions in the driver implicitly depend on current_fdc
    while passing it as an argument makes the driver a bit more readable
    but that represents less than half of the code and doesn't address
    all the readability concerns;

  - a test was done to limit support to a single FDC, but after these
    cleanups it doesn't provide any significant benefit in terms of code
    readability.

These patches are to be applied on top of Denis' floppy-next branch.

v2:
  - CC arch maintainers in ARM patches
  - fixed issues after Denis' review:
      - extra braces in floppy.h in declaration of floppy_selects[]
      - missing parenthesis in fd_outb() macro to silence a warning
      - used the swap() macro in driveswap()

Willy Tarreau (6):
  floppy: remove dead code for drives scanning on ARM
  floppy: remove incomplete support for second FDC from ARM code
  floppy: prepare ARM code to simplify base address separation
  floppy: introduce new functions fdc_inb() and fdc_outb()
  floppy: separate the FDC's base address from its registers
  floppy: rename the global "fdc" variable to "current_fdc"

 arch/arm/include/asm/floppy.h |  88 ++-----------
 drivers/block/floppy.c        | 284 ++++++++++++++++++++++--------------------
 include/uapi/linux/fdreg.h    |  18 +--
 3 files changed, 168 insertions(+), 222 deletions(-)

-- 
2.9.0

