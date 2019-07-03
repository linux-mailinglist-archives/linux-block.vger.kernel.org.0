Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9C615D0BA
	for <lists+linux-block@lfdr.de>; Tue,  2 Jul 2019 15:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfGBNeI (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 2 Jul 2019 09:34:08 -0400
Received: from verein.lst.de ([213.95.11.211]:42682 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbfGBNeI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Jul 2019 09:34:08 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 84B6868B20; Tue,  2 Jul 2019 15:34:06 +0200 (CEST)
Date:   Tue, 2 Jul 2019 15:34:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Matias Bjorling <mb@lightnvm.io>,
        linux-block@vger.kernel.org
Subject: Re: remove bi_phys_segments and related cleanups
Message-ID: <20190702133406.GC15874@lst.de>
References: <20190606102904.4024-1-hch@lst.de> <a703a5cb-1e39-6194-698a-56dbc4577f25@fb.com> <bbc9baba-19f2-03ec-59dc-adab225eb3b2@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbc9baba-19f2-03ec-59dc-adab225eb3b2@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 01, 2019 at 10:46:12AM -0600, Jens Axboe wrote:
> No console on that system, but that's OK since the trace itself
> isn't that interesting. We end up crashing in nvme_queue_rq(),
> here:

Weird.  Is that a nvme device with our without a volativle write
cache?  Can you send me your .config?
