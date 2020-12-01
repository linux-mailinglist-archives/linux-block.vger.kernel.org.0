Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654CD2CA169
	for <lists+linux-block@lfdr.de>; Tue,  1 Dec 2020 12:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbgLALbx (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 1 Dec 2020 06:31:53 -0500
Received: from verein.lst.de ([213.95.11.211]:49324 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726832AbgLALbx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 1 Dec 2020 06:31:53 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id D796268B02; Tue,  1 Dec 2020 12:31:09 +0100 (CET)
Date:   Tue, 1 Dec 2020 12:31:09 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Hannes Reinecke <hare@suse.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Can Guo <cang@codeaurora.org>
Subject: Re: [PATCH v4 2/9] block: Introduce BLK_MQ_REQ_PM
Message-ID: <20201201113109.GC32252@lst.de>
References: <20201130024615.29171-1-bvanassche@acm.org> <20201130024615.29171-3-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130024615.29171-3-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
