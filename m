Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C075D95837
	for <lists+linux-block@lfdr.de>; Tue, 20 Aug 2019 09:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbfHTHXa (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 20 Aug 2019 03:23:30 -0400
Received: from verein.lst.de ([213.95.11.211]:54275 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbfHTHXa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Aug 2019 03:23:30 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A3E8168B02; Tue, 20 Aug 2019 09:23:26 +0200 (CEST)
Date:   Tue, 20 Aug 2019 09:23:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        USB list <linux-usb@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: reeze while write on external usb 3.0 hard disk [Bug 204095]
Message-ID: <20190820072326.GD28968@lst.de>
References: <20190817095422.GA4200@lazy.lzy> <Pine.LNX.4.44L0.1908191009490.1506-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1908191009490.1506-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 19, 2019 at 10:14:25AM -0400, Alan Stern wrote:
> Let's bring this to the attention of some more people.
> 
> It looks like the bug that was supposed to be fixed by commit
> d74ffae8b8dd ("usb-storage: Add a limitation for
> blk_queue_max_hw_sectors()"), which is part of 5.2.5, but apparently
> the bug still occurs.

Piergiorgio,

can you dump the content of max_hw_sectors_kb file for your USB storage
device and send that to this thread?
