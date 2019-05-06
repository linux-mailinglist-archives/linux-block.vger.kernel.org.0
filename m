Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9F8814AEC
	for <lists+linux-block@lfdr.de>; Mon,  6 May 2019 15:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbfEFNaq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 6 May 2019 09:30:46 -0400
Received: from verein.lst.de ([213.95.11.211]:52418 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbfEFNaq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 6 May 2019 09:30:46 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id B32EF68AFE; Mon,  6 May 2019 15:30:27 +0200 (CEST)
Date:   Mon, 6 May 2019 15:30:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 8/8] block: never take page references for ITER_BVEC
Message-ID: <20190506133027.GA5810@lst.de>
References: <20190502233332.28720-1-hch@lst.de> <20190502233332.28720-9-hch@lst.de> <20190506081952.GA24702@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506081952.GA24702@ming.t460p>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 06, 2019 at 04:19:54PM +0800, Ming Lei wrote:
> I remember that this way is the initial version of Jens' patch, however
> kernel bug is triggered:
> 
> https://lore.kernel.org/linux-block/20190226034613.GA676@sol.localdomain/
> 
> Or maybe I miss some recent changes, could you explain it a bit?

I'm not even sure how the original would crash..  When I run the
rest locally it gets and EBUSY from ioctl LOOP_SET_FD, so I'm
not sure what it tends up testing in the end.
