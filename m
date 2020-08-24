Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4BE250161
	for <lists+linux-block@lfdr.de>; Mon, 24 Aug 2020 17:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgHXPor (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 24 Aug 2020 11:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728070AbgHXPoo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Aug 2020 11:44:44 -0400
Received: from gardel.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3758C061573;
        Mon, 24 Aug 2020 08:44:43 -0700 (PDT)
Received: from gardel-login.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by gardel.0pointer.net (Postfix) with ESMTP id 810BCE80E9F;
        Mon, 24 Aug 2020 17:44:36 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id 2FBAB16155C; Mon, 24 Aug 2020 17:44:36 +0200 (CEST)
Date:   Mon, 24 Aug 2020 17:44:36 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     Martijn Coenen <maco@android.com>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Subject: LOOP_CONFIGURE ioctl doesn't work if lo_offset/lo_sizelimit are set
Message-ID: <20200824154436.GA255257@gardel-login>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi!

Even with fe6a8fc5ed2f0081f17375ae2005718522c392c6 the LOOP_CONFIGURE
ioctl doesn't work correctly. It gets confused if the
lo_offset/lo_sizelimit fields are set to non-zero.

In a quick test I ran (on Linux 5.8.3) I call LOOP_CONFIGURE with
.lo_offset=3221204992 and .lo_sizelimit=50331648 and immediately
verify the size of the block device with BLKGETSIZE64. It should of
course return 50331648, but actually returns 3271557120. (the precise
values have no particular relevance, it's just what I happened to use
in my test.) If I instead use LOOP_SET_STATUS64 with the exact same
parameters, everything works correctly. In either case, if I use
LOOP_GET_STATUS64 insted of BLKGETSIZE64 to verify things, everything
looks great.

My guess is that the new ioctl simply doesn't properly propagate the
size limit into the underlying block device like it should. I didn't
have the time to investigate further though.

Lennart
