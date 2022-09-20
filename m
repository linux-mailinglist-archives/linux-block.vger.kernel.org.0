Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D195BDE9A
	for <lists+linux-block@lfdr.de>; Tue, 20 Sep 2022 09:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbiITHnN (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 20 Sep 2022 03:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbiITHms (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Sep 2022 03:42:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E23647CF
        for <linux-block@vger.kernel.org>; Tue, 20 Sep 2022 00:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MDeVPMRsS/Cko4BzJoeRZAwUcGaoKeje3sdyWxXTOiU=; b=C1zx5Z+/qQNufixXqyeydnlK7x
        Co8y3XKw7PHyQuOAHRk/yiLeBmbpp9Wi7RtIu+mGnbk356Rm5IDlCCdcmxqWaBlr/ipNjugCFXquI
        DYda1e6e14dcF5n5N5rTCXH2oNVtZkwvRjwgiHX5DV4o0FAQ90EGF05UmH88BXfLHx0O4Qkq8FNy1
        +lsKQ55JakABnlkhkYwBK+ZUQEarejjsDyTd+1+t+rZonCxUlOstNktYJfniP/6NswJUhzxuHDpAf
        RUdH9aOLHonkPTq6tbL6LgPnZLx8KSG+rdY81ko8nJNP9/6SOr65A+8OVF3IbhyIMX5yYFJ1aq7z2
        k/uufDmw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oaXsV-001RbH-7E; Tue, 20 Sep 2022 07:41:11 +0000
Date:   Tue, 20 Sep 2022 00:41:11 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph =?iso-8859-1?Q?B=F6hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Coly Li <colyli@suse.de>,
        David Sterba <dsterba@suse.com>, Chao Yu <chao@kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH] blk-lib: fix blkdev_issue_secure_erase
Message-ID: <Yylul0OSW4G8yjVt@infradead.org>
References: <alpine.LRH.2.02.2209141549480.28100@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2209141549480.28100@file01.intranet.prod.int.rdu2.redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 14, 2022 at 04:55:51PM -0400, Mikulas Patocka wrote:
> +	/* make sure that "len << SECTOR_SHIFT" doesn't overflow */
> +	if (max_sectors > UINT_MAX >> SECTOR_SHIFT)
> +		max_sectors = UINT_MAX >> SECTOR_SHIFT;

This should use max / max_t:

	max_sectors = max(max_sectors, UINT_MAX >> SECTOR_SHIFT) & ~bs_mask;

