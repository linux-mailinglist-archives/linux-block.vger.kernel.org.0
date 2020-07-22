Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696442293F9
	for <lists+linux-block@lfdr.de>; Wed, 22 Jul 2020 10:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731050AbgGVIuw (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 22 Jul 2020 04:50:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22375 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731026AbgGVIut (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Jul 2020 04:50:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595407848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H24R8qVAxwYFcsepHzRqkh8E1U4cEvx3I96Wl9ElKtQ=;
        b=HBhs7XXYUsZnZBl5sU85W/BFjxpdKv3ZJLBl+VZZi6Jz+BpzbmYLubLQpkK7iC1n65siEA
        E+D0lsZEdHuwPJ8KiEP8g4W81VUaWNjlz/6O0s+1IOrnpgql/HB4/BQYJCGfTTsCmj351v
        2BlYHpT9z1gt3FknxaYGz9bJ1B4wybU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-M4qKbPESN9G2w4ycP9uygQ-1; Wed, 22 Jul 2020 04:50:46 -0400
X-MC-Unique: M4qKbPESN9G2w4ycP9uygQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13A376C2F3;
        Wed, 22 Jul 2020 08:50:34 +0000 (UTC)
Received: from fedora-32-enviroment (unknown [10.35.206.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3615969317;
        Wed, 22 Jul 2020 08:50:27 +0000 (UTC)
Message-ID: <c9124b5487ed51e02dc9264fa8c87b93313fa68f.camel@redhat.com>
Subject: Re: [PATCH 01/10] block: introduce blk_is_valid_logical_block_size
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        "open list:SCSI CDROM DRIVER" <linux-scsi@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Jason Wang <jasowang@redhat.com>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Colin Ian King <colin.king@canonical.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ajay Joshi <ajay.joshi@wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        "open list:SONY MEMORYSTICK SUBSYSTEM" <linux-mmc@vger.kernel.org>,
        Satya Tangirala <satyat@google.com>,
        "open list:NETWORK BLOCK DEVICE (NBD)" <nbd@other.debian.org>,
        Hou Tao <houtao1@huawei.com>, Jens Axboe <axboe@fb.com>,
        "open list:VIRTIO CORE AND NET DRIVERS" 
        <virtualization@lists.linux-foundation.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Alex Dubov <oakad@yahoo.com>
Date:   Wed, 22 Jul 2020 11:50:26 +0300
In-Reply-To: <20200721151313.GA10620@lst.de>
References: <20200721105239.8270-1-mlevitsk@redhat.com>
         <20200721105239.8270-2-mlevitsk@redhat.com> <20200721151313.GA10620@lst.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2020-07-21 at 17:13 +0200, Christoph Hellwig wrote:
> > +/**
> > + * blk_check_logical_block_size - check if logical block size is
> > supported
> > + * by the kernel
> > + * @size:  the logical block size, in bytes
> > + *
> > + * Description:
> > + *   This function checks if the block layers supports given block
> > size
> > + **/
> > +bool blk_is_valid_logical_block_size(unsigned int size)
> > +{
> > +	return size >= SECTOR_SIZE && size <= PAGE_SIZE &&
> > !is_power_of_2(size);
> 
> Shouldn't this be a ... && is_power_of_2(size)?
Yep. I noticed that few minutes after I sent the patches.

> 
> >  	if (q->limits.io_min < q->limits.physical_block_size)
> >  		q->limits.io_min = q->limits.physical_block_size;
> > +
> >  }
> 
> This adds a pointless empty line.
Will fix.
> 
> > +extern bool blk_is_valid_logical_block_size(unsigned int size);
> 
> No need for externs on function declarations.
I also think so, but I followed the style of all existing function
prototypes in this file. Most of them have 'extern'.

Thanks for the review!

Best regards,
	maxim Levitsky

