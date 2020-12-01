Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789702CA173
	for <lists+linux-block@lfdr.de>; Tue,  1 Dec 2020 12:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbgLALdp (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 1 Dec 2020 06:33:45 -0500
Received: from verein.lst.de ([213.95.11.211]:49374 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727378AbgLALdo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 1 Dec 2020 06:33:44 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7575E68B05; Tue,  1 Dec 2020 12:33:02 +0100 (CET)
Date:   Tue, 1 Dec 2020 12:33:02 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org, Can Guo <cang@codeaurora.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: Re: [PATCH v4 8/9] block: Remove RQF_PREEMPT and BLK_MQ_REQ_PREEMPT
Message-ID: <20201201113302.GG32252@lst.de>
References: <20201130024615.29171-1-bvanassche@acm.org> <20201130024615.29171-9-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130024615.29171-9-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
