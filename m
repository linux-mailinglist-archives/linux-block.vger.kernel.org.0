Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C43957DBC3
	for <lists+linux-block@lfdr.de>; Fri, 22 Jul 2022 10:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiGVIJK (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 22 Jul 2022 04:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234770AbiGVIJH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jul 2022 04:09:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83B39B576
        for <linux-block@vger.kernel.org>; Fri, 22 Jul 2022 01:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1EWm2eQpZb7JaKku7rtOBSRLGhLS3YZjz7V1a5+qD20=; b=vF47N6i6srrceqt2xP0wa36ja3
        iU8B01mBGWBXuXo92f9+hJBmRlW9tS5u0velb6yKxm8jH/Q33PvaUtcHZdsqBovpI8YIuY0j0wyDT
        5i8AcVH1siXYMt8MiuKTnZpDBZetvMcFxTAq2iZu8XD1zSlfJegtHHyVmnbxvmDux08mj3K7owDCD
        CtTkLSotS89KkgoMX3VSqPTyVwmUV96ZdlyUtEyBFesy/5wRs+b7UIe4fB9yhgzK+bkYAVdv8bjxq
        V//PRb5y4OUBJIDTiWtmb1o7wqO/X9XUywCouSRLMFrGp11BgjqJPOoTI6xOreyFCx+l5yMwoCmDL
        RwMqikYg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEniW-000tFK-BJ; Fri, 22 Jul 2022 08:09:00 +0000
Date:   Fri, 22 Jul 2022 01:09:00 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: Re: [PATCH V2 2/2] ublk_drv: make sure that correct flags(features)
 returned to userspace
Message-ID: <YtpbHPJDgwi3gMho@infradead.org>
References: <20220722050930.611232-1-ming.lei@redhat.com>
 <20220722050930.611232-3-ming.lei@redhat.com>
 <Yto6s09YN1FK2Zi6@infradead.org>
 <YtpSCX5ZC3cnWakM@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtpSCX5ZC3cnWakM@T590>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 22, 2022 at 03:30:17PM +0800, Ming Lei wrote:
> > > +enum ublk_flag_bits {
> > > +	__UBLK_F_SUPPORT_ZERO_COPY,
> > > +	__UBLK_F_URING_CMD_COMP_IN_TASK,
> > > +	__UBLK_F_NR_BITS,
> > > +};
> > 
> > Please make these #defines so that userspace can detect if they
> > exist in a header using #ifdef.
> 
> userspace is supposed to only use UBLK_F_* instead of __UBLK_F_*, one
> benefit of using enum is that UBLK_F_NR_BITS can be figured out
> automatically, otherwise how can we figure out the max bits?

Oh, indeed.  But I don't think the automatic max index is really
that useful.  Just use a manually maintained in-kernel UBLK_F_ALL,
that is just as little overhead to maintain as the extra enum.
And if you forget to add a flag that code will never see it as it
gets cleared before the device is added.
