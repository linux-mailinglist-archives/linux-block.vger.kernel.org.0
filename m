Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1759130BB1C
	for <lists+linux-block@lfdr.de>; Tue,  2 Feb 2021 10:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbhBBJgg (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 2 Feb 2021 04:36:36 -0500
Received: from verein.lst.de ([213.95.11.211]:45062 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231688AbhBBJf2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Feb 2021 04:35:28 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id A1C5368BFE; Tue,  2 Feb 2021 10:34:45 +0100 (CET)
Date:   Tue, 2 Feb 2021 10:34:45 +0100
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
Subject: Re: [PATCH 3/7] blktrace: fix blk_rq_issue documentation
Message-ID: <20210202093445.GC17771@lst.de>
References: <20210202052544.4108-1-chaitanya.kulkarni@wdc.com> <20210202052544.4108-12-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202052544.4108-12-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 01, 2021 at 09:25:40PM -0800, Chaitanya Kulkarni wrote:
> The commit 881245dcff29 ("Add DocBook documentation for the block tracepoints.")
> added the comment for blk_rq_issue() tracepoint. Remove the duplicate
> word from the tracepoint documentation.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
