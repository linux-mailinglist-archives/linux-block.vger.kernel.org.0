Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81264B52A7
	for <lists+linux-block@lfdr.de>; Mon, 14 Feb 2022 15:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237179AbiBNODB (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 14 Feb 2022 09:03:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354852AbiBNOC7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Feb 2022 09:02:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2219D
        for <linux-block@vger.kernel.org>; Mon, 14 Feb 2022 06:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rj6C33iz9CPtFnBqhCCaHdbyPr4QjpyN8OA7hTDTqik=; b=q2G074nXQa2o7b+Lb7V5ARhs72
        fkRghjHw09wK1ZGmtXCF1TR8p5W3njdCpR0RBtCX9AR3og6rr2uBBJA4gTaJ1Y35uevjnPfkb4yWZ
        aYzyo0Tp9PZ2mY2Z64YEbJTgRcmBeahFFP/xthmrXmWLGL85sDPE31xbqpWKuQxP8RqgpOjj0YzUe
        8igx6bSe7lb/NENwMc5lOTevMDSKfggBv5pRX1GXoweuc7MWMvfW5ro479oCoYE/zL8m0U0mgYl2d
        dqempMFR32w/N49k2usikHbWYHy3qX4euQWKd4fExmvxuQf0DdbSfFWaSqdvHe0MUVjvniGTaVPU5
        dbNQwvtw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJbwJ-00FYY2-PT; Mon, 14 Feb 2022 14:02:51 +0000
Date:   Mon, 14 Feb 2022 06:02:51 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 10/14] block: add bio_start_io_acct_remapped for the
 benefit of DM
Message-ID: <YgphC67SVZIWfhhs@infradead.org>
References: <20220211214057.40612-1-snitzer@redhat.com>
 <20220211214057.40612-11-snitzer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211214057.40612-11-snitzer@redhat.com>
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

On Fri, Feb 11, 2022 at 04:40:53PM -0500, Mike Snitzer wrote:
> DM needs the ability to account a clone bio's IO to the original
> block_device. So add @orig_bdev argument to bio_start_io_acct_time.
> 
> Rename bio_start_io_acct_time to bio_start_io_acct_remapped.
> 
> Also, follow bio_end_io_acct and bio_end_io_acct_remapped pattern by
> moving bio_start_io_acct to blkdev.h and have it call
> bio_start_io_acct_remapped.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
