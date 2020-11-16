Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF772B4C78
	for <lists+linux-block@lfdr.de>; Mon, 16 Nov 2020 18:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731218AbgKPRS3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 16 Nov 2020 12:18:29 -0500
Received: from verein.lst.de ([213.95.11.211]:55273 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730775AbgKPRS3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Nov 2020 12:18:29 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id BEFC968BEB; Mon, 16 Nov 2020 18:18:27 +0100 (CET)
Date:   Mon, 16 Nov 2020 18:18:27 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Can Guo <cang@codeaurora.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Ming Lei <ming.lei@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v2 5/9] scsi: Do not wait for a request in
 scsi_eh_lock_door()
Message-ID: <20201116171827.GE22007@lst.de>
References: <20201116030459.13963-1-bvanassche@acm.org> <20201116030459.13963-6-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116030459.13963-6-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Nov 15, 2020 at 07:04:55PM -0800, Bart Van Assche wrote:
> scsi_eh_lock_door() is the only function in the SCSI error handler that
> calls blk_get_request(). It is not guaranteed that a request is available
> when scsi_eh_lock_door() is called. Hence pass the BLK_MQ_REQ_NOWAIT flag
> to blk_get_request(). This patch has a second purpose, namely preventing
> that scsi_eh_lock_door() deadlocks if sdev->request_queue is frozen and if
> a SCSI command is submitted to a SCSI device through a second request
> queue that has not been frozen. A later patch will namely modify the SPI
> DV code such that sdev->requeust_queue is frozen during domain validation.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
