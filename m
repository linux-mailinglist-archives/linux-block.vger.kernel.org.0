Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307F236A617
	for <lists+linux-block@lfdr.de>; Sun, 25 Apr 2021 11:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbhDYJ20 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 25 Apr 2021 05:28:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31673 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229485AbhDYJ2Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 25 Apr 2021 05:28:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619342865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RjtHhf1h2GPdx4OubhfVpPhMn9ZwNKESK31goEka/aE=;
        b=KTpjcIuWQT92TeE1K02kF6yo/mXlwX01J7bsgOxN8b0Txvi1iL/k5KWtgdzHdMabDEUGk1
        e3kqgpFLBDcx4SjY9dpaXvu4wbaguYovblgUl+9t/QshHfkm/K0foWZFxNcvcVUdL3ZB/Z
        1/MxO6Uf0G/a3H/pApbcuzcvDcq5rBI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-GqeOQ1fnNlejx8ljXbLlEg-1; Sun, 25 Apr 2021 05:27:43 -0400
X-MC-Unique: GqeOQ1fnNlejx8ljXbLlEg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B46610053E7;
        Sun, 25 Apr 2021 09:27:41 +0000 (UTC)
Received: from T590 (ovpn-13-143.pek2.redhat.com [10.72.13.143])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 63BFF5B4A1;
        Sun, 25 Apr 2021 09:27:31 +0000 (UTC)
Date:   Sun, 25 Apr 2021 17:27:34 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Khazhy Kumykov <khazhy@google.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        David Jeffery <djeffery@redhat.com>
Subject: Re: [PATCH 0/8] blk-mq: fix request UAF related with iterating over
 tagset requests
Message-ID: <YIU2BhuYZAAgonN0@T590>
References: <20210425085753.2617424-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210425085753.2617424-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Apr 25, 2021 at 04:57:45PM +0800, Ming Lei wrote:
> Hi Guys,
> 
> Revert 4 patches from Bart which try to fix request UAF issue related
> with iterating over tagset wide requests, because:
> 
> 1) request UAF caused by normal completion vs. async completion during
> iterating can't be covered[1]
> 
> 2) clearing ->rqs[] is added in fast path, which causes performance loss
> by 1% according to Bart's test
> 
> 3) Bart's approach is too complicated, and some changes aren't needed,
> such as adding two versions of tagset iteration

4) synchronize_rcu() is added before shutting down one request queue,
which may slow down reboot/poweroff very much on big systems with lots of
HBAs in which lots of LUNs are attached.

5) freeing request pool in updating nr_requests isn't covered.

Thanks,
Ming

