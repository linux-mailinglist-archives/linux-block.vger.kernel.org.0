Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E4624EC57
	for <lists+linux-block@lfdr.de>; Sun, 23 Aug 2020 11:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgHWJJU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 23 Aug 2020 05:09:20 -0400
Received: from verein.lst.de ([213.95.11.211]:51686 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbgHWJJT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 23 Aug 2020 05:09:19 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9836468AFE; Sun, 23 Aug 2020 11:09:15 +0200 (CEST)
Date:   Sun, 23 Aug 2020 11:09:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     =?utf-8?B?55Sw?= <xianting_tian@126.com>
Cc:     Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>,
        Justin Sanders <justin@coraid.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nbd@other.debian.org" <nbd@other.debian.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>
Subject: Re: [PATCH 2/2] block: fix locking for struct block_device size
 updates
Message-ID: <20200823090915.GA2764@lst.de>
References: <20200821085600.2395666-1-hch@lst.de> <20200821085600.2395666-3-hch@lst.de> <4df016bc-570c-d166-47dd-36a9f21fad13@suse.de> <133efc8b.1649.17410784734.Coremail.xianting_tian@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <133efc8b.1649.17410784734.Coremail.xianting_tian@126.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 21, 2020 at 06:02:32PM +0800, 田 wrote:
> thanks Hellwig for your kindly reply and your fix and add report by me :)

I found an issue with the patch, and will send a new version in a bit.
If this works for your reproducer, can you add a Tested-by: tag?
