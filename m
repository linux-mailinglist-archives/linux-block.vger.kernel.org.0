Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318006BB97B
	for <lists+linux-block@lfdr.de>; Wed, 15 Mar 2023 17:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbjCOQT3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 15 Mar 2023 12:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbjCOQTL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Mar 2023 12:19:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2483D97FE3;
        Wed, 15 Mar 2023 09:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yDBiOEkvjDgg4IR0j4lnPMTMvoAfiMmq7CSmPPL80Uk=; b=IIpyHbVyrtlWCaQlCN4lfFWNuz
        UqJgfh7tj0P0sBr3qwA4Ko1Fz0kAO7EyECokBSkcnp3QNmD4yUaPwvAtCDzoqhWtIiAnhfASaja9h
        5SCYc2r6iuIvp6r13Dhrw0Ujx3zyYbZuFiifYV51ntCNNGOrS3ppHq1upkj+CzB584Y1FytiivBOT
        7IQQ4iMjOmwj0s8aKlwVh3HxjJrXbC+OM28/0+/Rem8qiEAvop90YjvHZgpgLWObu5JeYCyZhVSwV
        GgOO0zmZZrwHn6KMkphje33MlfCHgVF3BBfAJbgIl4u0xQzgr1W45evOcqnKY/S1qO+113vt7LjTH
        LLM9KCUQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pcTpm-00E2cF-29;
        Wed, 15 Mar 2023 16:18:38 +0000
Date:   Wed, 15 Mar 2023 09:18:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Nathan Huckleberry <nhuck@google.com>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-fscrypt@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] blk-mq: release crypto keyslot before reporting
 I/O complete
Message-ID: <ZBHv3m0c9Fzs9DHA@infradead.org>
References: <20230308193645.114069-1-ebiggers@kernel.org>
 <20230308193645.114069-2-ebiggers@kernel.org>
 <CAJkfWY76-fUf92YZid3bOPrufXwCzM-q9L1ezqkLZ+WJiWL3jQ@mail.gmail.com>
 <ZBC63ry7EFMr+Xzk@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBC63ry7EFMr+Xzk@sol.localdomain>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 14, 2023 at 11:20:14AM -0700, Eric Biggers wrote:
> I did notice that attempt_merge() calls elv_merge_requests() (not to be confused
> with elv_merged_request()) if it merges the requests.
> 
> So it seems there is elv_merge_requests() which means the request was merged,
> and elv_merged_request() which means the request was *not* merged...  I have no
> idea what is going on there :-(

The naming looks very confusing, but that is indeed what the code
does.  The elevator code is in massive need of a cleanup, as it often
is that confusing.
