Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D009F4058
	for <lists+linux-block@lfdr.de>; Fri,  8 Nov 2019 07:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfKHG2g (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 8 Nov 2019 01:28:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46490 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfKHG2g (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Nov 2019 01:28:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=h9BdY6flpzJVQHfll79Lih1Mj
        qx6uOJVDKqXalN5XLPyt6QNS+zgyhPe9iT5XdVzVebNXQq2tRteSyk9T7ENfNlQ6l/qm+JPNioxOq
        ycdxPk7BgyjaRjqADDUpBw/RdxoPfYwPXsrFjEITAGQAiB0ziIp+ZjWUNOsZ/ZGcIPLXvK9iqVCjf
        pROrBs5yzj/2xLPU5YP3oUf9m+zoS2fDho0ixua8A3THp5V2e27cPTgSnkQAOf2FjP2xHqBMYJqea
        VVf4rgF7ahdg6ASsZ391Gpozo9QNft9ZTSaXm9UQy8fhAKQ1qt2sMeFy3zqhhocKM969QRAFFWZUC
        OduB4uVNw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSxl4-0003Oe-3b; Fri, 08 Nov 2019 06:28:34 +0000
Date:   Thu, 7 Nov 2019 22:28:34 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Subject: Re: [dm-devel] [PATCH 1/9] block: Enhance blk_revalidate_disk_zones()
Message-ID: <20191108062834.GA12413@infradead.org>
References: <20191108015702.233102-1-damien.lemoal@wdc.com>
 <20191108015702.233102-2-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108015702.233102-2-damien.lemoal@wdc.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
