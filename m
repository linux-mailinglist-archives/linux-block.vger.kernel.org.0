Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B08A3BC52E
	for <lists+linux-block@lfdr.de>; Tue,  6 Jul 2021 06:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhGFET7 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 6 Jul 2021 00:19:59 -0400
Received: from verein.lst.de ([213.95.11.211]:58978 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229550AbhGFET7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Jul 2021 00:19:59 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3A12B68BEB; Tue,  6 Jul 2021 06:17:19 +0200 (CEST)
Date:   Tue, 6 Jul 2021 06:17:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, hch@lst.de,
        chaitanya.kulkarni@wdc.com, linux-block@vger.kernel.org,
        nbd@other.debian.org
Subject: Re: [PATCH V2] nbd: fix order of cleaning up the queue and freeing
 the tagset
Message-ID: <20210706041718.GB11174@lst.de>
References: <1625477143-18716-1-git-send-email-wangqing@vivo.com> <20210706040016.1360412-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706040016.1360412-1-guoqing.jiang@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 06, 2021 at 12:00:16PM +0800, Guoqing Jiang wrote:
> From: Wang Qing <wangqing@vivo.com>
> 
> We must release the queue before freeing the tagset.
> 
> Fixes: 4af5f2e03013 ("nbd: use blk_mq_alloc_disk and blk_cleanup_disk")
> Reported-and-tested-by: syzbot+9ca43ff47167c0ee3466@syzkaller.appspotmail.com
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> Signed-off-by: Guoqing Jiang <jiangguoqing@kylinos.cn>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
