Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 564AF309BCD
	for <lists+linux-block@lfdr.de>; Sun, 31 Jan 2021 13:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbhAaL5l (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 31 Jan 2021 06:57:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55792 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231629AbhAaLz3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 Jan 2021 06:55:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612094011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WG13qxzAHqFe1MQbE7W/8kC+O/GfX1klD+C5fHLEO/o=;
        b=ausI93Acu3HQQTU38ytECXI+m+2Faz/GXYapaCf3VsGQK7BQVMT8ffy9t24LHD/njbaUdz
        YM3QsKeVUJES6ovooNbw70J74Fk21D4sODPHl5R2N1imDp5Uxz0w+Fx/XrKMn25nxt4QQP
        9nDMFppifia4FvzKW/YZoJvLVmKWXyg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-Zn9-5MhqM_CXRJJafohhmw-1; Sun, 31 Jan 2021 06:53:27 -0500
X-MC-Unique: Zn9-5MhqM_CXRJJafohhmw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC098107ACE6;
        Sun, 31 Jan 2021 11:53:25 +0000 (UTC)
Received: from T590 (ovpn-12-51.pek2.redhat.com [10.72.12.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 293A460C17;
        Sun, 31 Jan 2021 11:53:17 +0000 (UTC)
Date:   Sun, 31 Jan 2021 19:52:45 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumanesh Samanta <sumanesh.samanta@broadcom.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V7 00/13] blk-mq/scsi: tracking device queue depth via
 sbitmap
Message-ID: <20210131115245.GA1979183@T590>
References: <20210122023317.687987-1-ming.lei@redhat.com>
 <yq1a6sr1v87.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1a6sr1v87.fsf@ca-mkp.ca.oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 29, 2021 at 01:02:12PM -0500, Martin K. Petersen wrote:
> 
> Ming,
> 
> > The last four patches changes SCSI for switching to track device queue
> > depth via sbitmap.
> >
> > The patchset have been tested by Broadcom, and obvious performance boost
> > can be observed on megaraid_sas.
> 
> This series deadlocks SCSI scanning for me on every system I have in my
> test setup (mpt2sas, mpt3sas, megaraid_sas, qla2xxx, lpfc).

Martin, thanks for your test.

BTW, which tree are you based for applying this patchset?

I apply the patchset against for-5.12/block, and run it on kvm with
'megasas' device(LSI MegaRAID SAS 1078), looks it works well, and not
see the hang issue.


Thanks,
Ming

