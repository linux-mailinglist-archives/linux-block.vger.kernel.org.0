Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBAF2D3EA
	for <lists+linux-block@lfdr.de>; Wed, 29 May 2019 04:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfE2CmW (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 28 May 2019 22:42:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57384 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbfE2CmV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 May 2019 22:42:21 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6EDC23179157;
        Wed, 29 May 2019 02:42:21 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F1AE1001DE1;
        Wed, 29 May 2019 02:42:07 +0000 (UTC)
Date:   Wed, 29 May 2019 10:42:02 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 5/5] blk-mq: Wait for for hctx inflight requests on
 CPU unplug
Message-ID: <20190529024200.GC21398@ming.t460p>
References: <20190527150207.11372-1-ming.lei@redhat.com>
 <20190527150207.11372-6-ming.lei@redhat.com>
 <45daceb4-fb88-a835-8cc6-cd4c4d7cf42d@huawei.com>
 <20190529022852.GA21398@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529022852.GA21398@ming.t460p>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 29 May 2019 02:42:21 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 29, 2019 at 10:28:52AM +0800, Ming Lei wrote:
> On Tue, May 28, 2019 at 05:50:40PM +0100, John Garry wrote:
> > On 27/05/2019 16:02, Ming Lei wrote:
> > > Managed interrupts can not migrate affinity when their CPUs are offline.
> > > If the CPU is allowed to shutdown before they're returned, commands
> > > dispatched to managed queues won't be able to complete through their
> > > irq handlers.
> > > 
> > > Wait in cpu hotplug handler until all inflight requests on the tags
> > > are completed or timeout. Wait once for each tags, so we can save time
> > > in case of shared tags.
> > > 
> > > Based on the following patch from Keith, and use simple delay-spin
> > > instead.
> > > 
> > > https://lore.kernel.org/linux-block/20190405215920.27085-1-keith.busch@intel.com/
> > > 
> > > Some SCSI devices may have single blk_mq hw queue and multiple private
> > > completion queues, and wait until all requests on the private completion
> > > queue are completed.
> > 
> > Hi Ming,
> > 
> > I'm a bit concerned that this approach won't work due to ordering: it seems
> > that the IRQ would be shutdown prior to the CPU dead notification for the
> 
> Managed IRQ shutdown is run in irq_migrate_all_off_this_cpu(), which is
> called in the callback of takedown_cpu(). And the CPU dead notification
> is always sent after that CPU becomes offline, see cpuhp_invoke_callback().

Hammm, looks we both say same thing.

Yeah, it is too late to drain requests in the cpu hotplug DEAD handler,
maybe we can try to move managed IRQ shutdown after sending the dead
notification.

I need to think of it further.

Thanks,
Ming
