Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7EBC2B57E0
	for <lists+linux-block@lfdr.de>; Tue, 17 Nov 2020 04:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgKQD2Q (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 16 Nov 2020 22:28:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57397 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725804AbgKQD2Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Nov 2020 22:28:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605583695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D1JMcZkYm/tW0U9C5vpqVtKrUD6GkwmK9QMSbjO2MYE=;
        b=hQUBcqY8YFjGfAgvgfQ/AFe0L2FmUX4+CnjnDPU4nGbdLHKBsJRdRbL2p+12bTm5c3YCR9
        cSoRbb3ln6JZfRSELVRp1DvCIopFyNXbEDtpGetZKosBDp6Xdyyu2bGVeCHnAHJCfAXNV+
        53V5qV96BTn6UXoo+E2zo5Zo0sdTgY8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-7Q3vdcxKMCakuCAFeD2ciw-1; Mon, 16 Nov 2020 22:28:11 -0500
X-MC-Unique: 7Q3vdcxKMCakuCAFeD2ciw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09BFB802B6C;
        Tue, 17 Nov 2020 03:28:10 +0000 (UTC)
Received: from T590 (ovpn-12-215.pek2.redhat.com [10.72.12.215])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A78655B4B0;
        Tue, 17 Nov 2020 03:28:00 +0000 (UTC)
Date:   Tue, 17 Nov 2020 11:27:56 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Weiping Zhang <zwp10758@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
        mpatocka@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH v5 0/2] fix inaccurate io_ticks
Message-ID: <20201117032756.GE56247@T590>
References: <20201027045411.GA39796@192.168.3.9>
 <CAA70yB7bepwNPAMtxth8qJCE6sQM9vxr1A5sU8miFn3tSOSYQQ@mail.gmail.com>
 <CAA70yB6caVcKjJOTkEZa9ZBzZAHPgYrsr9nZWDgm-tfPMLGXHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA70yB6caVcKjJOTkEZa9ZBzZAHPgYrsr9nZWDgm-tfPMLGXHQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 17, 2020 at 11:01:49AM +0800, Weiping Zhang wrote:
> Hi Jens,
> 
> Ping

Hello Weiping,

Not sure we have to fix this issue, and adding blk_mq_queue_inflight()
back to IO path brings cost which turns out to be visible, and I did
get soft lockup report on Azure NVMe because of this kind of cost.

BTW, suppose the io accounting issue needs to be fixed, just wondering
why not simply revert 5b18b5a73760 ("block: delete part_round_stats and
switch to less precise counting"), and the original way had been worked
for decades.


Thanks,
Ming

