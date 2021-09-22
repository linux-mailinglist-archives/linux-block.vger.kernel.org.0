Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735C2414D8E
	for <lists+linux-block@lfdr.de>; Wed, 22 Sep 2021 17:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236330AbhIVP60 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 22 Sep 2021 11:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236321AbhIVP6Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Sep 2021 11:58:25 -0400
Received: from lounge.grep.be (lounge.grep.be [IPv6:2a01:4f8:200:91e8::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BC2C061574
        for <linux-block@vger.kernel.org>; Wed, 22 Sep 2021 08:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=uter.be;
        s=2021.lounge; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=vX6Qu+emXOBeX55x21xlP5yK5xuZNhWOHbJG5PTxsow=; b=dXaiMB7WWoz7Zu09KijKcG32EI
        lhOXgJPMh3ProOjEwiW4/7buxU03QPvqXH40kT5kMxKFBQDHotzs10cUIJaE8AUBDiGff3jw17bkA
        uQRRJcUNymBuDycw8begbgGE3pYl9x0P6sfUBufEbuyKuRITWt1bng+7y0y4SmFY9jXdPnvwUCZbs
        a0J9KO1HWoqJhZOB6WQXmtZo/zE280weWx7kNi/36CP5QAPdonVU6IJ0gOTp1o2ZWL9j7sYZUeUAU
        W8ZSa4AhBEu5VQkPY8mgxuFcgB4r4Cjn3hXgrYJrpIChOhu+sB64WrzRyDtI2mylC5WotcPzIhYcN
        358GTTTQ==;
Received: from 197-101-72-171.ip.broadband.is ([197.101.72.171] helo=pc181009)
        by lounge.grep.be with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <w@uter.be>)
        id 1mT4bu-00Cfvr-R2; Wed, 22 Sep 2021 17:56:38 +0200
Received: from wouter by pc181009 with local (Exim 4.95-RC2)
        (envelope-from <w@uter.be>)
        id 1mT4bg-0003l5-0I;
        Wed, 22 Sep 2021 17:56:24 +0200
Date:   Wed, 22 Sep 2021 17:56:23 +0200
From:   Wouter Verhelst <w@uter.be>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     "yukuai (C)" <yukuai3@huawei.com>, josef@toxicpanda.com,
        axboe@kernel.dk, hch@infradead.org, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [patch v8 3/7] nbd: check sock index in nbd_read_stat()
Message-ID: <YUtSJ/bfKZ9QJUaY@pc181009.grep.be>
References: <20210916093350.1410403-1-yukuai3@huawei.com>
 <20210916093350.1410403-4-yukuai3@huawei.com>
 <7e2913ca-1089-9ab7-cfdb-5e8837d36034@huawei.com>
 <YUr1v8zylPOFFXTO@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUr1v8zylPOFFXTO@T590>
X-Speed: Gates' Law: Every 18 months, the speed of software halves.
Organization: none
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 22, 2021 at 05:22:07PM +0800, Ming Lei wrote:
> On Sun, Sep 19, 2021 at 06:34:28PM +0800, yukuai (C) wrote:
> > On 2021/09/16 17:33, Yu Kuai wrote:
> > > The sock that clent send request in nbd_send_cmd() and receive reply
> > > in nbd_read_stat() should be the same.
> > > 
> > > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> > > ---
> > >   drivers/block/nbd.c | 4 ++++
> > >   1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> > > index 614c6ab2b8fe..c724a5bd7fa4 100644
> > > --- a/drivers/block/nbd.c
> > > +++ b/drivers/block/nbd.c
> > > @@ -746,6 +746,10 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
> > >   		ret = -ENOENT;
> > >   		goto out;
> > >   	}
> > > +	if (cmd->index != index) {
> > > +		dev_err(disk_to_dev(nbd->disk), "Unexpected reply %d from different sock %d (expected %d)",
> > > +			tag, index, cmd->index);
> > > +	}
> > >   	if (cmd->cmd_cookie != nbd_handle_to_cookie(handle)) {
> > >   		dev_err(disk_to_dev(nbd->disk), "Double reply on req %p, cmd_cookie %u, handle cookie %u\n",
> > >   			req, cmd->cmd_cookie, nbd_handle_to_cookie(handle));
> > > 
> > 
> > Hi, Ming
> > 
> > Any suggestions about this patch?
> 
> I think this one relies on nbd protocol between server and client, and
> does the protocol require both request and reply xmitted via same
> socket?

As Eric already answered: yes, the request and reply are specified such
that they must be transmitted over the same socket.

For more details, you can find the protocol specification at
https://github.com/NetworkBlockDevice/nbd/blob/master/doc/proto.md

Please note that the protocol defined there has some options that are
not currently supported by the Linux nbd implementation -- specifically
the "structured reply" message format (and all that requires it) is not
implemented (yet?).

-- 
     w@uter.{be,co.za}
wouter@{grep.be,fosdem.org,debian.org}
