Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D66E3ED114
	for <lists+linux-block@lfdr.de>; Mon, 16 Aug 2021 11:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbhHPJeK (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 16 Aug 2021 05:34:10 -0400
Received: from verein.lst.de ([213.95.11.211]:53673 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230506AbhHPJeK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Aug 2021 05:34:10 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 69EB467373; Mon, 16 Aug 2021 11:33:36 +0200 (CEST)
Date:   Mon, 16 Aug 2021 11:33:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+aa0801b6b32dca9dda82@syzkaller.appspotmail.com>,
        axboe@kernel.dk, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] general protection fault in wb_timer_fn
Message-ID: <20210816093336.GA3950@lst.de>
References: <00000000000072e53a05c983ab22@google.com> <20210816091041.3313-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816091041.3313-1-hdanton@sina.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 16, 2021 at 05:10:41PM +0800, Hillf Danton wrote:
> Remove and free all qos callbacks added, with cb->timer deleted in
> blk_stat_remove_callback().
> 
> only for thoughts.
> 
> +++ x/block/blk-sysfs.c
> @@ -800,9 +800,7 @@ static void blk_release_queue(struct kob
>  
>  	might_sleep();
>  
> -	if (test_bit(QUEUE_FLAG_POLL_STATS, &q->queue_flags))
> -		blk_stat_remove_callback(q, q->poll_cb);
> -	blk_stat_free_callback(q->poll_cb);
> +	rq_qos_exit(q);

rq_qos_exit is already called in blk_cleanup_queue, and the blk-mq
pollig doesn't even use the qos framework.  So I'm not sure what this
is supposed to help.
