Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE7569B071
	for <lists+linux-block@lfdr.de>; Fri, 17 Feb 2023 17:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjBQQRE (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 17 Feb 2023 11:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjBQQRD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Feb 2023 11:17:03 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C66C71196
        for <linux-block@vger.kernel.org>; Fri, 17 Feb 2023 08:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HtC79M6gfoTbeYz9ewr/uHjJ5JvDIH+6EYOxmfcgdPs=; b=tJnnwJydWv0tmiRmFs7CyiPk6S
        jAzXGtFeVlYcJqNcOJkEof0t5OXIw1lcGNjDMlMnXrTk+roEcqlcChPpZd67yXACsZWEyAg1E64+H
        CQYlBTCpYOXn5Ct1vGHDM92WBwN/C2egAsZShRq8fV9Un13n5CAAy9Ivh81d33nqDPLZ5gISyk47r
        z5oHYxVrxxMCDIB40H64H+c23CVS/CbpWq70+eqT/6+8ICiI9gAlA+ruNove9P6BRFAMtlwlJ6pws
        PC8DdnlDum4jC+L+RZbRprZx22EU3R8CEtAAo5899wbKOkt+xLesDjTAyNn0pGH4W615gXzAU2Mle
        iMqzvSqA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pT3PD-00F0il-Ve; Fri, 17 Feb 2023 16:16:15 +0000
Date:   Fri, 17 Feb 2023 08:16:15 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Uday Shankar <ushankar@purestorage.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, linux-block@vger.kernel.org,
        dm-devel@redhat.com
Subject: Re: [PATCH] blk-mq: enforce op-specific segment limits in
 blk_insert_cloned_request
Message-ID: <Y++oTz0ck9OGE4Se@infradead.org>
References: <20230215201507.494152-1-ushankar@purestorage.com>
 <Y+3IoOd02iFGNLnC@infradead.org>
 <20230216192702.GA801590@dev-ushankar.dev.purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216192702.GA801590@dev-ushankar.dev.purestorage.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 16, 2023 at 12:27:02PM -0700, Uday Shankar wrote:
>  * Description:
>  *    @rq may have been made based on weaker limitations of upper-level queues
>  *    in request stacking drivers, and it may violate the limitation of @q.
>  *    Since the block layer and the underlying device driver trust @rq
>  *    after it is inserted to @q, it should be checked against @q before
>  *    the insertion using this generic function.
>  *
>  *    Request stacking drivers like request-based dm may change the queue
>  *    limits when retrying requests on other queues. Those requests need
>  *    to be checked against the new queue limits again during dispatch.
>  */.
> 
> Is this concern no longer relevant?

The concern is still valid, but it does not refer to the debug check.
It refers to recalculating nr_phys_segments using
blk_recalc_rq_segments, and the fact that any driver using this
interface needs to stack its limits properly.
