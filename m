Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4538B9D50D
	for <lists+linux-block@lfdr.de>; Mon, 26 Aug 2019 19:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730835AbfHZRix (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 26 Aug 2019 13:38:53 -0400
Received: from vsmx012.vodafonemail.xion.oxcs.net ([153.92.174.90]:32865 "EHLO
        vsmx012.vodafonemail.xion.oxcs.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729466AbfHZRix (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Aug 2019 13:38:53 -0400
Received: from vsmx004.vodafonemail.xion.oxcs.net (unknown [192.168.75.198])
        by mta-8-out.mta.xion.oxcs.net (Postfix) with ESMTP id E3171F34CCC;
        Mon, 26 Aug 2019 17:38:50 +0000 (UTC)
Received: from lazy.lzy (unknown [87.157.113.162])
        by mta-8-out.mta.xion.oxcs.net (Postfix) with ESMTPA id 4A10119A968;
        Mon, 26 Aug 2019 17:38:35 +0000 (UTC)
Received: from lazy.lzy (localhost [127.0.0.1])
        by lazy.lzy (8.15.2/8.14.5) with ESMTPS id x7QHcYGp004219
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 26 Aug 2019 19:38:34 +0200
Received: (from red@localhost)
        by lazy.lzy (8.15.2/8.15.2/Submit) id x7QHcXtE004218;
        Mon, 26 Aug 2019 19:38:33 +0200
Date:   Mon, 26 Aug 2019 19:38:33 +0200
From:   Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
To:     Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jens Axboe <axboe@kernel.dk>,
        USB list <linux-usb@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: reeze while write on external usb 3.0 hard disk [Bug 204095]
Message-ID: <20190826173833.GA4166@lazy.lzy>
References: <20190817095422.GA4200@lazy.lzy>
 <Pine.LNX.4.44L0.1908191009490.1506-100000@iolanthe.rowland.org>
 <20190820072326.GD28968@lst.de>
 <20190820163722.GA2991@lazy.lzy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820163722.GA2991@lazy.lzy>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-VADE-STATUS: LEGIT
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 20, 2019 at 06:37:22PM +0200, Piergiorgio Sartor wrote:
> On Tue, Aug 20, 2019 at 09:23:26AM +0200, Christoph Hellwig wrote:
> > On Mon, Aug 19, 2019 at 10:14:25AM -0400, Alan Stern wrote:
> > > Let's bring this to the attention of some more people.
> > > 
> > > It looks like the bug that was supposed to be fixed by commit
> > > d74ffae8b8dd ("usb-storage: Add a limitation for
> > > blk_queue_max_hw_sectors()"), which is part of 5.2.5, but apparently
> > > the bug still occurs.
> > 
> > Piergiorgio,
> > 
> > can you dump the content of max_hw_sectors_kb file for your USB storage
> > device and send that to this thread?
> 
> Hi all,
> 
> for both kernels, 5.1.20 (working) and 5.2.8 (not working),
> the content of /sys/dev/x:y/queue/max_hw_sectors_kb is 512
> for USB storage devices (2.0 and 3.0).
> 
> This is for the PC showing the issue.
> 
> In an other PC, which does not show the issus at the moment,
> the values are 120, for USB2.0, and 256, for USB3.0.

Hi again,

any news on this?

Is there anything I can do to help?

Should I report this somewhere else too?

Currently this is quite a huge problem for me,
since the only working external storage is an
old 1394 HDD...

Thanks,

bye,

-- 

piergiorgio
