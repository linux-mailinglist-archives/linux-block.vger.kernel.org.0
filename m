Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E462B4C74
	for <lists+linux-block@lfdr.de>; Mon, 16 Nov 2020 18:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732573AbgKPRSA (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 16 Nov 2020 12:18:00 -0500
Received: from verein.lst.de ([213.95.11.211]:55266 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730843AbgKPRSA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Nov 2020 12:18:00 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 42EC868BEB; Mon, 16 Nov 2020 18:17:56 +0100 (CET)
Date:   Mon, 16 Nov 2020 18:17:55 +0100
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
Subject: Re: [PATCH v2 4/9] scsi: Rework scsi_mq_alloc_queue()
Message-ID: <20201116171755.GD22007@lst.de>
References: <20201116030459.13963-1-bvanassche@acm.org> <20201116030459.13963-5-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116030459.13963-5-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Nov 15, 2020 at 07:04:54PM -0800, Bart Van Assche wrote:
> Do not modify sdev->request_queue. Remove the sdev->request_queue
> assignment. That assignment is superfluous because scsi_mq_alloc_queue()
> only has one caller and that caller calls scsi_mq_alloc_queue() as follows:
> 
> 	sdev->request_queue = scsi_mq_alloc_queue(sdev);

This looks ok to me.  But is there any good to keep scsi_mq_alloc_queue
around at all?  It is so trivial that it can be open coded in the
currently only caller, as well as a new one if added.
