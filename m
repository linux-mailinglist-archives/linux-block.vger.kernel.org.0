Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6C1FF2B6A
	for <lists+linux-block@lfdr.de>; Thu,  7 Nov 2019 10:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387638AbfKGJvN (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 7 Nov 2019 04:51:13 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34256 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfKGJvM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Nov 2019 04:51:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=MA/EnxYRFKTGzvGmqcj7nx/Cw
        ldJTNRC+q1PfZY0BOEZxgbpDgaiqPzxVL8me8uXoHOTvEKrsXuepQulVni9T1ICOoV4jqaVpFZEfy
        dtYMii2PitAxpMLXXO2BZReR5heU4ql6KcvGhiEXdGpap8QCXagi4Ou2kadmkXB1Jn94hDJbwVV9r
        5BGC70w7k7spmQo6fahySDofI/c2Otpx9nCvvHxfYQEnFlvSCEzk1mrhX+TJMIqeCNN76nUjNHTOV
        3GQBVLRNy7YVZo2PtNA5TByxNlxWihrpCxEnai577l4yFpjD9ROcF8RFiHam2iFfhLC1Xg+GyZ9tV
        7W2qKJCdw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSeRc-0002Lv-C9; Thu, 07 Nov 2019 09:51:12 +0000
Date:   Thu, 7 Nov 2019 01:51:12 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        Ajay Joshi <ajay.joshi@wdc.com>,
        Matias Bjorling <matias.bjorling@wdc.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/8] block: Simplify REQ_OP_ZONE_RESET_ALL handling
Message-ID: <20191107095112.GB2024@infradead.org>
References: <20191027140549.26272-1-damien.lemoal@wdc.com>
 <20191027140549.26272-3-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191027140549.26272-3-damien.lemoal@wdc.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
