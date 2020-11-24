Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDDB2C20F4
	for <lists+linux-block@lfdr.de>; Tue, 24 Nov 2020 10:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbgKXJOm (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 24 Nov 2020 04:14:42 -0500
Received: from verein.lst.de ([213.95.11.211]:53518 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727131AbgKXJOm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Nov 2020 04:14:42 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id DBA7967373; Tue, 24 Nov 2020 10:14:38 +0100 (CET)
Date:   Tue, 24 Nov 2020 10:14:38 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Can Guo <cang@codeaurora.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v3 4/9] scsi: Inline scsi_mq_alloc_queue()
Message-ID: <20201124091438.GA11515@lst.de>
References: <20201123031749.14912-1-bvanassche@acm.org> <20201123031749.14912-5-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123031749.14912-5-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
