Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4AE354CF4
	for <lists+linux-block@lfdr.de>; Tue,  6 Apr 2021 08:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238210AbhDFGat (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 6 Apr 2021 02:30:49 -0400
Received: from verein.lst.de ([213.95.11.211]:53118 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237859AbhDFGas (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Apr 2021 02:30:48 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C34BA68BEB; Tue,  6 Apr 2021 08:30:38 +0200 (CEST)
Date:   Tue, 6 Apr 2021 08:30:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] block: shutdown blktrace in case of fatal signal
 pending
Message-ID: <20210406063038.GA6337@lst.de>
References: <20210323081440.81343-1-ming.lei@redhat.com> <20210323081440.81343-2-ming.lei@redhat.com> <20210330165330.GA13829@lst.de> <YGO/cpalyGevAJjn@T590> <20210402172730.GA22923@lst.de> <YGgi6FOr6cEiei+7@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGgi6FOr6cEiei+7@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Apr 03, 2021 at 04:10:16PM +0800, Ming Lei wrote:
> We still may shutdown blktrace if current is the last opener, otherwise
> new blktrace can't be started and memory should be leaked forever, and
> what do you think of the revised version?

I don't think this works.  For one there might be users of the blktrace
ioctl that explicitly rely on this not happening as difference processes
might start the tracing vs actually consume the trace data.  Second this
might not actually work as another process could be the last opener.

If you want to fix this for the blktrace tool (common) case I think we
need a new ioctl that explicitly ties the buffer lifetime to the fd.
