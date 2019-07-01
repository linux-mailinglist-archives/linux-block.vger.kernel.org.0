Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C63C55B48A
	for <lists+linux-block@lfdr.de>; Mon,  1 Jul 2019 08:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfGAGRr (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 1 Jul 2019 02:17:47 -0400
Received: from verein.lst.de ([213.95.11.211]:58356 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbfGAGRr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Jul 2019 02:17:47 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id EFF0B68C7B; Mon,  1 Jul 2019 08:17:45 +0200 (CEST)
Date:   Mon, 1 Jul 2019 08:17:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V6 3/4] sd_zbc: Fix report zones buffer allocation
Message-ID: <20190701061745.GC20073@lst.de>
References: <20190701050918.27511-1-damien.lemoal@wdc.com> <20190701050918.27511-4-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701050918.27511-4-damien.lemoal@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
