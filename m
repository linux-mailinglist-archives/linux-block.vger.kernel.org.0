Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720CA4B658C
	for <lists+linux-block@lfdr.de>; Tue, 15 Feb 2022 09:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiBOIMS (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 15 Feb 2022 03:12:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiBOIMS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 03:12:18 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C116AAE71
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 00:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wN1ohe3FohE4ulYTIjSeUHfACbMKtM4XH7C4hxGzDZg=; b=BklhPorZstrPHymE/GD/zzS2LJ
        81aP9gDE2IsMiFtHBDjg+DbCFw050Ve/0kDDoPWx7lCItbUiR6DIS4tzYA1Ll/BRNuY1nC57eh62a
        6vkPBuVv387vIY1h9tcEO5fnbR50+OQ7rGAt8LezdGlsfMGeSDwvTDZMWH7frWPLMhwLa9d+fuAjK
        4LBSfi+F5ejzi4MEQvZE+CdR0os9DX27rzr7fIltKiZMfUUg3qK9Dtc7BsezCrlSJFPWzzgurng3T
        W1KYo1NJ+u6fxpXSM7dkzd2HgF5UypYa5ohwfMb4kSrlBs69SH99oRRtM1d36bVluOpF5U1/3piaS
        XcF0y0+w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJswF-001Ylv-EM; Tue, 15 Feb 2022 08:11:55 +0000
Date:   Tue, 15 Feb 2022 00:11:55 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Li Ning <lining2020x@163.com>, Tejun Heo <tj@kernel.org>,
        Chunguang Xu <brookxu@tencent.com>
Subject: Re: [PATCH V3 4/8] block: don't check bio in
 blk_throtl_dispatch_work_fn
Message-ID: <YgtgS3aluiQtl/Aw@infradead.org>
References: <20220215033050.2730533-1-ming.lei@redhat.com>
 <20220215033050.2730533-5-ming.lei@redhat.com>
 <Ygtc2rIGVZkLRgTp@infradead.org>
 <Ygtfyq7s0sx6vkJ8@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ygtfyq7s0sx6vkJ8@T590>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 15, 2022 at 04:09:46PM +0800, Ming Lei wrote:
> The wrapper is for avoiding to add extra function call code in fast
> path since submit_bio_noacct_nocheck is global and can't be inlined.

It absolutle can be inlined if the compiler deems it worthwhile.  But
givn that it is a trivial and cheap tail call is not worth it, so no
sensible compiler will do it and we should not force it into that
suboptimal decision.
