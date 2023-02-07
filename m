Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D4F68CC4F
	for <lists+linux-block@lfdr.de>; Tue,  7 Feb 2023 02:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjBGBut (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 6 Feb 2023 20:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjBGBus (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Feb 2023 20:50:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A53E212A
        for <linux-block@vger.kernel.org>; Mon,  6 Feb 2023 17:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675734601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O8DZ8iSeO9bLrBIvE+gAMVfN6gh24WjhqTIL1ablpZ4=;
        b=jJ97za5I79qwOP+YCqTpjuDBVBG9lKr5RinEfY25mnUTH8bh67zfRwJA1rUVrEIsC4/VeK
        Hz3lTkCjKU016cv9CkZo1xQEQWzllIcikk1KmQ+96IVjoIuoJeiiUsfhjvODuxbV2h3K5f
        KPxwx36BZoeELovKplSkiJS7MQwUqik=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-505-1Tr4hzxCOPygJLi2GPaZlQ-1; Mon, 06 Feb 2023 20:43:39 -0500
X-MC-Unique: 1Tr4hzxCOPygJLi2GPaZlQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 26F6E3813F20;
        Tue,  7 Feb 2023 01:43:39 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A4DD40398A0;
        Tue,  7 Feb 2023 01:43:28 +0000 (UTC)
Date:   Tue, 7 Feb 2023 09:43:23 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     axboe@kernel.dk, hch@lst.de, mcgrof@kernel.org,
        gost.dev@samsung.com, linux-block@vger.kernel.org
Subject: Re: [PATCH 0/1] improve brd performance with blk-mq
Message-ID: <Y+Gsu0PiXBIf8fFU@T590>
References: <CGME20230203103122eucas1p161c0f0b674d26e23cf38466d5415420e@eucas1p1.samsung.com>
 <20230203103005.31290-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203103005.31290-1-p.raghav@samsung.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 03, 2023 at 04:00:05PM +0530, Pankaj Raghav wrote:
> Hi Jens,
>  brd is one of the few block drivers that still uses submit_bio instead
>  of blk-mq framework. The following patch converts brd to start using
>  blk-mq framework. Performance gains are pretty evident for read workloads.
>  The performance numbers are also attached as a part of
>  the commit log.
> 
>  Performance (WD=[read|randread|write|randwrite]):
>  $ modprobe brd rd_size=1048576 rd_nr=1
>  $ echo "none" > /sys/block/ram0/queue/scheduler
>  $ fio --name=<WD>  --ioengine=io_uring --iodepth=64 --rw=<WD> --size=1G \
>    --io_size=20G --loop=4 --cpus_allowed=1 --filename=/dev/ram0 --iodepth=64
>    --direct=[0/1]
> 
>   --direct=0

Can you share perf data on other non-io_uring engine often used? The
thing is that we still have lots of non-io_uring workloads, which can't
be hurt now.


Thanks
Ming

