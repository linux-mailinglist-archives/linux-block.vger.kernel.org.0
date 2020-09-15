Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2A026A884
	for <lists+linux-block@lfdr.de>; Tue, 15 Sep 2020 17:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgIOPN5 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 15 Sep 2020 11:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbgIOPNJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Sep 2020 11:13:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B94C06174A;
        Tue, 15 Sep 2020 08:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=BlHEt+Eizy6lsmnlgqyEhn5/iG
        wSSN6Ck0YGLPMIQSEWFr2IRx3WE7nBaWCW5RnWao7E4JhynIjHotshnu/4ijs7ydjrWappPJCWpyZ
        4Cri8dQ8hK6YUNFNEdYJGrt+nD1oPo/uFSkolhgubuNeRONQRV1pbsVprmPMkGMzNGhxR5xxNz85u
        ePBAGhip2vFU3/KkRfswHs+hLb3F4PHGy/IUfhIlkIOu/p8mjT4rQe+on4oZckgShLDsiSole6lA6
        iYvRGStchOL2lj+yNNzeB+6pgkuvOtZwBofgLKUojnP6+DuWgfTLFsEnfyMxnjO+AHTBqSSOU25oz
        6ItdJJsA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kICdg-0000Nl-Qn; Tue, 15 Sep 2020 15:13:00 +0000
Date:   Tue, 15 Sep 2020 16:13:00 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Borislav Petkov <bp@suse.de>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v3 1/2] scsi: Fix handling of host-aware ZBC disks
Message-ID: <20200915151300.GA1266@infradead.org>
References: <20200915073347.832424-1-damien.lemoal@wdc.com>
 <20200915073347.832424-2-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915073347.832424-2-damien.lemoal@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
