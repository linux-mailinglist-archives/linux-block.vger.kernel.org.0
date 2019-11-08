Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B02CF405D
	for <lists+linux-block@lfdr.de>; Fri,  8 Nov 2019 07:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbfKHGal (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 8 Nov 2019 01:30:41 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46566 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfKHGal (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Nov 2019 01:30:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aWZaf3HqZ/JVjp4vj9bwLFYZc9GevfueJy1hq0/ses8=; b=gKGF4Jqb9v0nWfPZ304FSdNXn
        5fO4s8QsanogCFw02yqxmezv1coqymvpUJckO9tsrpmbDwHTRJcM3616iGH6Qa4/US2tpM4kfn/Ht
        b0Oadl6dRWz+CZ4OHbuhkRjLJbugl5CRZiYBQtFnf4tSv+IC/qupsA0VjdhJyp6WqDadYgoG2H5YP
        H8WQ8H5GUzON1m4OcBW4GofUzO7zNE/jnasUPvVedIvpDbRjFEwaLjW1kO3wCm8BHdVwBaF1HXfuo
        Op2iuzEAJ62tKbgqMUqJcSkg7bVo5S9q8c7B5nV79GN13jUk0wc7k69rL5RZn5fIoG5xW/6OnoP/f
        VobS2Iq9Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSxn7-0004jy-91; Fri, 08 Nov 2019 06:30:41 +0000
Date:   Thu, 7 Nov 2019 22:30:41 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Subject: Re: [dm-devel] [PATCH 4/9] block: Remove partition support for zoned
 block devices
Message-ID: <20191108063041.GB12413@infradead.org>
References: <20191108015702.233102-1-damien.lemoal@wdc.com>
 <20191108015702.233102-5-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108015702.233102-5-damien.lemoal@wdc.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Note that this has a conflict with my series that cleans up the area
around rescan_partitions, but that series will only get simpler after
this patch is merged.
