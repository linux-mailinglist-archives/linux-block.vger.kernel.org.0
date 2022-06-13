Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714B4549B6C
	for <lists+linux-block@lfdr.de>; Mon, 13 Jun 2022 20:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236857AbiFMSYd (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 13 Jun 2022 14:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245232AbiFMSX2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Jun 2022 14:23:28 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E390CABE5A
        for <linux-block@vger.kernel.org>; Mon, 13 Jun 2022 07:32:19 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4821368AFE; Mon, 13 Jun 2022 16:32:10 +0200 (CEST)
Date:   Mon, 13 Jun 2022 16:32:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ron Economos <w6rz@comcast.net>
Cc:     linux-block@vger.kernel.org, hch@lst.de
Subject: Re: loop device failure on 5.19-rc1 RISC-V
Message-ID: <20220613143210.GB4110@lst.de>
References: <849cea40-4665-14fe-fa46-e555af730214@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <849cea40-4665-14fe-fa46-e555af730214@comcast.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Jun 11, 2022 at 02:46:33AM -0700, Ron Economos wrote:
> The following error messages occur on 5.19-rc1 RISC-V Ubuntu 22.04:
>
> Jun 08 21:00:20 riscv64 kernel: Dev loop0: unable to read RDB block 8
> Jun 08 21:00:20 riscv64 kernel:� loop0: unable to read partition table
> Jun 08 21:00:20 riscv64 kernel: loop0: partition table beyond EOD, truncated
>
> This happens when the snapd daemon tries to mount loop0.
>
> Reverting commit b9684a71fca793213378dd410cd11675d973eaa1
>
> block, loop: support partitions without scanning

In which case the snapd daemon explicitly asks for a partitions scan,
and we fixed a regression that makes it behave like it did in 5.16
and earlier.  But why do you have support for Amiga partitions enabled
on RISC-V anyway?
