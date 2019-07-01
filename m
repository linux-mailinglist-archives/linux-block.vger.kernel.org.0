Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B13F5248A8
	for <lists+linux-block@lfdr.de>; Tue, 21 May 2019 09:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbfEUHFP (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 21 May 2019 03:05:15 -0400
Received: from verein.lst.de ([213.95.11.211]:57853 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbfEUHFP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 May 2019 03:05:15 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id B529368B05; Tue, 21 May 2019 09:04:52 +0200 (CEST)
Date:   Tue, 21 May 2019 09:04:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bob Liu <bob.liu@oracle.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, hare@suse.com,
        ming.lei@redhat.com, bvanassche@acm.org, hch@lst.de,
        martin.petersen@oracle.com, jinpuwang@gmail.com, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>
Subject: Re: [RESEND PATCH v4] blk-mq: fix hang caused by freeze/unfreeze
 sequence
Message-ID: <20190521070452.GA30803@lst.de>
References: <20190521032555.31993-1-bob.liu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521032555.31993-1-bob.liu@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 21, 2019 at 11:25:55AM +0800, Bob Liu wrote:
> How to reproduce:
>  - "insmod null_blk.ko shared_tags=1 nr_devices=0 queue_mode=2"
>  - cpu0: python Script.py 0; taskset the corresponding process running on cpu0
>  - cpu1: python Script.py 1; taskset the corresponding process running on cpu1
> 
>  Script.py:

Can you wire this up for blktests?

Otherwise looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
