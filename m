Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3475E4E6782
	for <lists+linux-block@lfdr.de>; Thu, 24 Mar 2022 18:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236380AbiCXRNZ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 24 Mar 2022 13:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239179AbiCXRNY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Mar 2022 13:13:24 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C179BB188E
        for <linux-block@vger.kernel.org>; Thu, 24 Mar 2022 10:11:52 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B71D068B05; Thu, 24 Mar 2022 18:11:48 +0100 (CET)
Date:   Thu, 24 Mar 2022 18:11:48 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        nbd@other.debian.org
Subject: Re: [PATCH 01/13] nbd: use the correct block_device in nbd_ioctl
Message-ID: <20220324171148.GA28007@lst.de>
References: <20220324075119.1556334-1-hch@lst.de> <20220324075119.1556334-2-hch@lst.de> <20220324122041.itc55zladc5sax5p@quack3.lan> <20220324132322.2t3y4evcxunlpvzm@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324132322.2t3y4evcxunlpvzm@quack3.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 24, 2022 at 02:23:22PM +0100, Jan Kara wrote:
> Should't we call __invalidate_device() for the partition bdev here? Because
> if the NBD device has partitions, filesystem will be mounted on this
> partition and we want to invalidate it. Similarly the partition buffer
> cache is different from the buffer cache of the whole device and we should
> invalidate the partition one. In fact in cases like this I think we need
> to invalidate all the partitions and filesystems that are there on this
> disk so neither the old, nor the new code looks quite correct to me. Am I
> missing something?

Well, that assumes just one partition is used, which kinda defeats the
purpose of partitions.  I can exclude the __invalidate_device to not
change from one kind of broken to another, but I suspect the real
question is why we have this __invalidate_device call at all.
