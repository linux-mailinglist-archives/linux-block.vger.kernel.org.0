Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08FED5E7F05
	for <lists+linux-block@lfdr.de>; Fri, 23 Sep 2022 17:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbiIWPyW (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 23 Sep 2022 11:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbiIWPyV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Sep 2022 11:54:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D80146628
        for <linux-block@vger.kernel.org>; Fri, 23 Sep 2022 08:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0V/3fc/31YRZhKH5mxAQEYkI6AxXxZiPPcalq7iJpuA=; b=1SbSm3I29iPtn7m9MDKg3p1cK9
        wZRREwTKqYzQm3epfDjdkt2BUKNJNdCG1o+DRHUn2WKglBq/sI7sQ2JsDVKGugEqvHs4KLcpY+Usx
        IVNXZxGrGeMRWFZ7r6HSIKktOAa2yh8IyevVrEGmD9GcoiemZzubCTJP8ws2YVie+4H4RHrmN6Twf
        82CEyUjNqV07ne1KfJSTbVyTjsVdA8FLlDAkFducr7WVQp2GkQpgn6l1yTQwK8Zx7HltEkhOGwEoO
        7xqFHXyZiWMn0svMrbUtp6Eg9SV9bATRGgGROZS3X4i3UaQpuPUOSzXD5n8QAou44Fw55Qa0OZsf9
        D+UiO7Fg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1obl0N-004tsH-20; Fri, 23 Sep 2022 15:54:19 +0000
Date:   Fri, 23 Sep 2022 08:54:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Zdenek Kabelac <zkabelac@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH v2 4/4] brd: implement secure erase and write zeroes
Message-ID: <Yy3Wq2Hnb8KEbyb3@infradead.org>
References: <alpine.LRH.2.02.2209201350470.26058@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2209201358580.26535@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2209201358580.26535@file01.intranet.prod.int.rdu2.redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 20, 2022 at 01:59:46PM -0400, Mikulas Patocka wrote:
> This patch implements REQ_OP_SECURE_ERASE and REQ_OP_WRITE_ZEROES on brd.
> Write zeroes will free the pages just like discard, but the difference is
> that it writes zeroes to the preceding and following page if the range is
> not aligned on page boundary. Secure erase is just like write zeroes,
> except that it clears the page content before freeing the page.

So while I can see the use case for the simple discard you mentioned,
and maybe even the WRITE_ZEROES, I'd rather have a really good
justification for REQ_OP_SECURE_ERASE.  It is a bad interface,
and there are alsmost no good reasons for ever using it.  So sprinkling
it in random drivers just we can is not helpful.
