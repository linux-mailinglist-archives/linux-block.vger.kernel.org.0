Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 278AC25BB4D
	for <lists+linux-block@lfdr.de>; Thu,  3 Sep 2020 08:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgICG7x (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 3 Sep 2020 02:59:53 -0400
Received: from verein.lst.de ([213.95.11.211]:36567 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbgICG7x (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 3 Sep 2020 02:59:53 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 30B2968BEB; Thu,  3 Sep 2020 08:59:50 +0200 (CEST)
Date:   Thu, 3 Sep 2020 08:59:50 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Hillf Danton <hdanton@sina.com>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jan Kara <jack@suse.cz>, Ming Lei <ming.lei@redhat.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-block@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees] [PATCH] block: Fix use-after-free in
 bdev_del_partition()
Message-ID: <20200903065950.GA19012@lst.de>
References: <000000000000520ffc05ae2f4fee@google.com> <20200903065534.623691-1-yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903065534.623691-1-yepeilin.cs@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 03, 2020 at 02:55:34AM -0400, Peilin Ye wrote:
> In bdev_del_partition(), `part` is being looked up outside the critical
> section. This is causing bdev_del_partition() to delete the same partition
> more than once. Fix it by reverting commit cddae808aeb7.

We've already fix the problem properly:

https://git.kernel.dk/cgit/linux-block/commit/?h=block-5.9&id=08fc1ab6d748ab1a690fd483f41e2938984ce353
