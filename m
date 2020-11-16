Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9CA2B4C6B
	for <lists+linux-block@lfdr.de>; Mon, 16 Nov 2020 18:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731776AbgKPRQI (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 16 Nov 2020 12:16:08 -0500
Received: from verein.lst.de ([213.95.11.211]:55240 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727499AbgKPRQI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Nov 2020 12:16:08 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 70CBE68BEB; Mon, 16 Nov 2020 18:16:06 +0100 (CET)
Date:   Mon, 16 Nov 2020 18:16:06 +0100
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
Subject: Re: [PATCH v2 3/9] scsi: Pass a request queue pointer to
 __scsi_execute()
Message-ID: <20201116171606.GC22007@lst.de>
References: <20201116030459.13963-1-bvanassche@acm.org> <20201116030459.13963-4-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116030459.13963-4-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Nov 15, 2020 at 07:04:53PM -0800, Bart Van Assche wrote:
> This patch does not change any functionality but makes a later patch easier
> to read.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
