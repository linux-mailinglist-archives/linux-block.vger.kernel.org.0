Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A48388EF6
	for <lists+linux-block@lfdr.de>; Wed, 19 May 2021 15:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353609AbhESNY3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 19 May 2021 09:24:29 -0400
Received: from verein.lst.de ([213.95.11.211]:38334 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353606AbhESNY2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 May 2021 09:24:28 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2610A67373; Wed, 19 May 2021 15:23:06 +0200 (CEST)
Date:   Wed, 19 May 2021 15:23:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Song Liu <song@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/8] block: split __blkdev_get
Message-ID: <20210519132305.GA13174@lst.de>
References: <20210512061856.47075-1-hch@lst.de> <20210512061856.47075-2-hch@lst.de> <YKTYgaL4nAej+jeY@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKTYgaL4nAej+jeY@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 19, 2021 at 05:21:05PM +0800, Ming Lei wrote:
> Nice cleanup, now the blkdev get code becomes more readable than before:

Note that this will need a rebase on top of the partition rescan fix.
I'll send that out once Jens has merged the fix.
