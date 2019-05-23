Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B72027E4B
	for <lists+linux-block@lfdr.de>; Thu, 23 May 2019 15:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730081AbfEWNjb (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 23 May 2019 09:39:31 -0400
Received: from mga06.intel.com ([134.134.136.31]:39988 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729902AbfEWNjb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 May 2019 09:39:31 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 May 2019 06:39:31 -0700
X-ExtLoop1: 1
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga005.jf.intel.com with ESMTP; 23 May 2019 06:39:30 -0700
Date:   Thu, 23 May 2019 07:34:29 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     "Busch, Keith" <keith.busch@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 2/2] nvme: reset request timeouts during fw activation
Message-ID: <20190523133428.GC14049@localhost.localdomain>
References: <20190522174812.5597-1-keith.busch@intel.com>
 <20190522174812.5597-3-keith.busch@intel.com>
 <20190523101953.GA18805@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523101953.GA18805@ming.t460p>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 23, 2019 at 03:19:54AM -0700, Ming Lei wrote:
> On Wed, May 22, 2019 at 11:48:12AM -0600, Keith Busch wrote:
> > @@ -3605,6 +3606,11 @@ static void nvme_fw_act_work(struct work_struct *work)
> >  				msecs_to_jiffies(admin_timeout * 1000);
> >  
> >  	nvme_stop_queues(ctrl);
> > +	nvme_sync_queues(ctrl);
> > +
> > +	blk_mq_quiesce_queue(ctrl->admin_q);
> > +	blk_sync_queue(ctrl->admin_q);
> 
> blk_sync_queue() may not halt timeout detection completely since the
> timeout work may reset timer again.

Doh! Didn't hit that in testing, but point taken.
 
> Also reset still may come during activating FW, is that a problem?

IO timeout and user initiated resets should be avoided. A state machine
addition may be useful here.
