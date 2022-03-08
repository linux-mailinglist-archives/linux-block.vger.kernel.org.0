Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A5A4D1077
	for <lists+linux-block@lfdr.de>; Tue,  8 Mar 2022 07:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiCHGsw (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 8 Mar 2022 01:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240464AbiCHGsv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Mar 2022 01:48:51 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE601C134
        for <linux-block@vger.kernel.org>; Mon,  7 Mar 2022 22:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rWaGfJOb8k+G4KCujP8YQRKcVRi2TRnGT2LfPV4aMeM=; b=IsD2wEtPH4INCnW9Q7MuP9Wekd
        3ssdQo6zlRQMkgU7WF4moBaUclzsL6lnalcDyZTqXTcJ45BS4EKdm0L8+78VXaYfBiZ89FHxXuhtb
        9YmcKQJxp7WQIher/zDNvJ+P3P1idGumnJyASdCjQ+WCTuU8foBEZdlxQQTOD3MHeh00rs785f9VJ
        sy/V375YVZUkassaCB3bynQmQuyDaNPXD/VrlFTTEJk2mpgMWB+XzaJwPxmdscUmVsSydujAP7Gvz
        LeLrnipcZRLhunnKuiyizAD4uMfhbqBg0Iwi2+YP2MztdJgbWbl7Dv2hr2qkLgVH96irOFHC8orU9
        +Vu9hhiA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRTdS-002x3f-1m; Tue, 08 Mar 2022 06:47:54 +0000
Date:   Mon, 7 Mar 2022 22:47:54 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Uday Shankar <ushankar@purestorage.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] block: emit disk ro uevent in device_add_disk()
Message-ID: <Yib8GqCA5e3SQYty@infradead.org>
References: <20220303175219.272938-1-ushankar@purestorage.com>
 <6f24cfc9-09b9-67bc-d15b-d3aff238d923@suse.de>
 <20220307205451.GA1765432@dev-ushankar.dev.purestorage.com>
 <4f035ae3-6bc9-ce89-abd4-50c82f2b237d@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f035ae3-6bc9-ce89-abd4-50c82f2b237d@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 08, 2022 at 07:42:40AM +0100, Hannes Reinecke wrote:
> Most rules relating to storage devices test for both, 'add' _and_ 'change'
> as DM devices are only usable after a 'change' event.
> In particular multipath has been coded with that in mind, so I don't see any
> issues with just adding the RO setting to the 'add' event.

We don't even need that.  An application needs to look at the initial
device state at add time.  We can't add extra arguments to the add
event for every bit of state.

And in this case - if you're using dm-multipath on nvme you're already
doing something horribly wrong, and no amount of tweaking uevents is
going to fix that.
