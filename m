Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8E230BB2F
	for <lists+linux-block@lfdr.de>; Tue,  2 Feb 2021 10:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbhBBJjE (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 2 Feb 2021 04:39:04 -0500
Received: from verein.lst.de ([213.95.11.211]:45102 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233084AbhBBJgq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Feb 2021 04:36:46 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id C6E0F68CEC; Tue,  2 Feb 2021 10:36:03 +0100 (CET)
Date:   Tue, 2 Feb 2021 10:36:02 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, paolo.valente@linaro.org,
        axboe@kernel.dk, rostedt@goodmis.org, mingo@redhat.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        akpm@linux-foundation.org, aravind.ramesh@wdc.com,
        joshi.k@samsung.com, niklas.cassel@wdc.com, hare@suse.de,
        colyli@suse.de, tj@kernel.org, rdunlap@infradead.org, jack@suse.cz,
        hch@lst.de
Subject: Re: [PATCH 5/7] block: get rid of the trace rq insert wrapper
Message-ID: <20210202093602.GE17771@lst.de>
References: <20210202052544.4108-1-chaitanya.kulkarni@wdc.com> <20210202052544.4108-14-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202052544.4108-14-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 01, 2021 at 09:25:42PM -0800, Chaitanya Kulkarni wrote:
> Get rid of the wrapper for trace_block_rq_insert() and call the function
> directly.

The placement of the EXPORT_TRACEPOINT_SYMBOL_GPL looks very strange,
I'd keep it with the other EXPORT_TRACEPOINT_SYMBOL_GPL instances in
blk-core.c.

Otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
