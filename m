Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E043E551A
	for <lists+linux-block@lfdr.de>; Tue, 10 Aug 2021 10:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238099AbhHJI06 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 10 Aug 2021 04:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238072AbhHJI06 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Aug 2021 04:26:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D954CC061798;
        Tue, 10 Aug 2021 01:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=e2y8vyWZWA6j5xlB4p332zs4uB
        s2xRFSfk/0IR45oC6gCG9Xd2JtWmeflbKk8Q2siaD4VnNPFHEDzIJrsjQN661cWMGJkYogyRCCOkP
        9nO4SGYXOqxqdUkYZTrD4o6umJA47w5yMAFnaz7BPdA/EB/DGRMGmhVE83yHWhr+EomIMYUOxzBKZ
        2GMTAyO+7KDI/oUYAJireEPnaM4cbs8kBeo7KbYGy6yPbIkN1HpOekuPdAzwGELhXSTnqXy8hLcRm
        kkyHf6piJwuL9oYH1gHGrxCwABVVON+1SuzaFCtnmsgHwQoEY45ThzpdpiS1zsybW/xtBkZhBWTfh
        XJOmisRw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDN5K-00BtHU-AB; Tue, 10 Aug 2021 08:26:20 +0000
Date:   Tue, 10 Aug 2021 09:26:06 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 3/4] libata: support concurrent positioning ranges log
Message-ID: <YRI4Hk8uFQ2JF1m+@infradead.org>
References: <20210726013806.84815-1-damien.lemoal@wdc.com>
 <20210726013806.84815-4-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726013806.84815-4-damien.lemoal@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
