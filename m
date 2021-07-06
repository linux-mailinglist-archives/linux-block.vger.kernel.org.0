Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53AFA3BC52C
	for <lists+linux-block@lfdr.de>; Tue,  6 Jul 2021 06:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhGFETo (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 6 Jul 2021 00:19:44 -0400
Received: from verein.lst.de ([213.95.11.211]:58972 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229550AbhGFETo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Jul 2021 00:19:44 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 53A6E68BEB; Tue,  6 Jul 2021 06:17:04 +0200 (CEST)
Date:   Tue, 6 Jul 2021 06:17:04 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     axboe@kernel.dk, tim@cyberelk.net, hch@lst.de,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] pd: fix order of cleaning up the queue and freeing the
 tagset
Message-ID: <20210706041704.GA11174@lst.de>
References: <20210706010734.1356066-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706010734.1356066-1-guoqing.jiang@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 06, 2021 at 09:07:34AM +0800, Guoqing Jiang wrote:
> From: Guoqing Jiang <jiangguoqing@kylinos.cn>
> 
> We must release the queue before freeing the tagset.
> 
> Fixes: 262d431f9000 ("pd: use blk_mq_alloc_disk and blk_cleanup_disk")
> Signed-off-by: Guoqing Jiang <jiangguoqing@kylinos.cn>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
