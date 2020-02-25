Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED3FC16EEBC
	for <lists+linux-block@lfdr.de>; Tue, 25 Feb 2020 20:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730411AbgBYTM3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 25 Feb 2020 14:12:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54336 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730222AbgBYTM3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Feb 2020 14:12:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=rp45Vp3X3f9JOZYoYwnHcSnai8pNgV6sfc45s8fO6bw=; b=eR6m2y21F4fNmObw5l/ZZRxypU
        MuUElhJEF5AuRUSFNozGG+O794ZQIreVKIBi2eP6Nok5L4W2bIRfmghX0rOW7G1dV3aAo8ECLa6eq
        yGICA8kcCMDgpny0GPiIsJ87qs9YaYmvSdV5EWFSBytUfLKOJl3MVHB/W+j8JL7O2astInhewpppt
        TRguVp1uYuCW05mpn8nLMKJg782Z8B5sXA7I/QKockf9zXLYg9l2HOtOnAiKqgI23rzoFQa5Y4/Yv
        056bwJJOpDM0lRc7fFQ/PoLQx2hnkDSOSG8BzXixvhq/7H710Wgx7NwE42PluApvFXaRLimBsYsXk
        RSDvwXpA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6fd0-0001Yv-M6; Tue, 25 Feb 2020 19:12:22 +0000
Date:   Tue, 25 Feb 2020 11:12:22 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Daniel =?iso-8859-1?Q?Gl=F6ckner?= <dg@emlix.com>
Cc:     Mike Snitzer <snitzer@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [dm-devel] [PATCH] dm integrity: reinitialize __bi_remaining
 when reusing bio
Message-ID: <20200225191222.GA3908@infradead.org>
References: <20200225170744.10485-1-dg@emlix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200225170744.10485-1-dg@emlix.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 25, 2020 at 06:07:44PM +0100, Daniel Gl�ckner wrote:
> In cases where dec_in_flight has to requeue the integrity_bio_wait work
> to transfer the rest of the data, the __bi_remaining field of the bio
> might already have been decremented to zero. Reusing the bio without
> reinitializing that counter to 1 can then result in integrity_end_io
> being called too early when the BIO_CHAIN flag is set, f.ex. due to
> blk_queue_split. In our case this triggered the BUG() in
> blk_mq_end_request when the hardware signalled completion of the bio
> after integrity_end_io had modified it.
> 
> Signed-off-by: Daniel Gl�ckner <dg@emlix.com>

Drivers have no business poking into these internals.  If a bio is
reused the caller needs to use bio_reset instead.
