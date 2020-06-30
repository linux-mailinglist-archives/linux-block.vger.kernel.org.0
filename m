Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39CE220ED31
	for <lists+linux-block@lfdr.de>; Tue, 30 Jun 2020 07:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgF3FLS (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 30 Jun 2020 01:11:18 -0400
Received: from verein.lst.de ([213.95.11.211]:34467 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbgF3FLS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jun 2020 01:11:18 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 842CB6736F; Tue, 30 Jun 2020 07:11:16 +0200 (CEST)
Date:   Tue, 30 Jun 2020 07:11:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com, jack@suse.czi,
        rdunlap@infradead.org, sagi@grimberg.me, mingo@redhat.com,
        rostedt@goodmis.org, snitzer@redhat.com, agk@redhat.com,
        axboe@kernel.dk, paolo.valente@linaro.org, ming.lei@redhat.com,
        bvanassche@acm.org, fangguoju@gmail.com, colyli@suse.de, hch@lst.de
Subject: Re: [PATCH 05/11] block: get rid of the trace rq insert wrapper
Message-ID: <20200630051116.GC27033@lst.de>
References: <20200629234314.10509-1-chaitanya.kulkarni@wdc.com> <20200629234314.10509-6-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629234314.10509-6-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 29, 2020 at 04:43:08PM -0700, Chaitanya Kulkarni wrote:
> Get rid of the wrapper for trace_block_rq_insert() and call the function
> directly.

I'd mention blk_mq_sched_request_inserted instead of the tracepoint
in the subject and commit message.  Otherwise this looks fine.
