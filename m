Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B0172A4C3
	for <lists+linux-block@lfdr.de>; Fri,  9 Jun 2023 22:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjFIUcd (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 9 Jun 2023 16:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjFIUcc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Jun 2023 16:32:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1F7D8
        for <linux-block@vger.kernel.org>; Fri,  9 Jun 2023 13:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686342704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kqBodWvsMAtzK0roMuBBNkvevtML0piZ6ybEx/MweaE=;
        b=QTdgM9lVtL4CFMnYLPm5bLxb+YopEa1Dn5HSuGxRP9fg79EoMsJdDtSSQALeb40gtBbjPU
        zx7r6f/HNtf1HH9tTxshaDEn7t5BKGis2Ecf/Gwy53Qq/muj/dEKsUTUTc74o/Z4HkHutK
        4+oPCzAH0QdrSoG+hVVe87EJZ1YyIvw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-j1--QvWQNKel36TenMpnBg-1; Fri, 09 Jun 2023 16:31:43 -0400
X-MC-Unique: j1--QvWQNKel36TenMpnBg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6261a0b2391so23977396d6.1
        for <linux-block@vger.kernel.org>; Fri, 09 Jun 2023 13:31:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686342703; x=1688934703;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kqBodWvsMAtzK0roMuBBNkvevtML0piZ6ybEx/MweaE=;
        b=MabS/3JwhCKw8Wiejy6ZVvDbKN4B10FxwhPX8gvoO5ef9UFwyjMGCq0/PVVM+slWxV
         x7zv8QWfiOtWi4OyUzaaaTumhy+QmbQxq+Sr1AXD5maFTUMCXRqMfQUI6xwFp6Zn1pDe
         El5Zt/Tbzb/CA1xmZ2WFnAxVaZeyXdcFM/KlRozB4rMMu382Y+ZNA7s60oHX33EiqdEj
         OLcV3OPabYx7ABVWQyDpmGMQEyVBK2IOGL3Ru5VwMmeIdSKFobYixo9VJLAlIKtOgmNt
         OXyvvOJjqCczz0pv+MRZEWh+QoWN5eLy93r+BuRxc7JSTr47IRo5zOxo7kRjQzdAywn4
         s1EQ==
X-Gm-Message-State: AC+VfDxe5aNI32l0a8kBmccDxul7sHCL0cXLnbD3KnepdQE4H+v372Wa
        +GV96Y3YVQ/HVQsG112RBKmZQS9MXyp+IgvWPqDFAFqF8l96ZVOOWcLNof8Dv5MkNqzjR4B0lv4
        ByiLY+2X+gO4QFM9yHvEZBA==
X-Received: by 2002:a05:6214:124a:b0:626:3a5a:f8dc with SMTP id r10-20020a056214124a00b006263a5af8dcmr3512872qvv.57.1686342703126;
        Fri, 09 Jun 2023 13:31:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ78w0WDf0o6qhufepqm2d8bEB8MBtf2WH2t9YiWbkCms2QdUrQ0M7FAIP95SCC+cHOEnZuU1A==
X-Received: by 2002:a05:6214:124a:b0:626:3a5a:f8dc with SMTP id r10-20020a056214124a00b006263a5af8dcmr3512845qvv.57.1686342702858;
        Fri, 09 Jun 2023 13:31:42 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id m24-20020ae9e718000000b007578622c861sm1250201qka.108.2023.06.09.13.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 13:31:42 -0700 (PDT)
Date:   Fri, 9 Jun 2023 16:31:41 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Joe Thornber <thornber@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        Dave Chinner <david@fromorbit.com>,
        linux-kernel@vger.kernel.org, Joe Thornber <ejt@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        linux-ext4@vger.kernel.org, Brian Foster <bfoster@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v7 0/5] Introduce provisioning primitives
Message-ID: <ZIOMLfMjugGf4C2T@redhat.com>
References: <ZHFEfngPyUOqlthr@dread.disaster.area>
 <CAJ0trDZJQwvAzngZLBJ1hB0XkQ1HRHQOdNQNTw9nK-U5i-0bLA@mail.gmail.com>
 <ZHYB/6l5Wi+xwkbQ@redhat.com>
 <CAJ0trDaUOevfiEpXasOESrLHTCcr=oz28ywJU+s+YOiuh7iWow@mail.gmail.com>
 <ZHYWAGmKhwwmTjW/@redhat.com>
 <CAG9=OMMnDfN++-bJP3jLmUD6O=Q_ApV5Dr392_5GqsPAi_dDkg@mail.gmail.com>
 <ZHqOvq3ORETQB31m@dread.disaster.area>
 <ZHti/MLnX5xGw9b7@redhat.com>
 <CAG9=OMNv80fOyVixEY01XESnOFzYyfj9j8etHMq_Ap52z4UWNQ@mail.gmail.com>
 <ZIESXNF5anyvJEjm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZIESXNF5anyvJEjm@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 07 2023 at  7:27P -0400,
Mike Snitzer <snitzer@kernel.org> wrote:

> On Mon, Jun 05 2023 at  5:14P -0400,
> Sarthak Kukreti <sarthakkukreti@chromium.org> wrote:
> 
> > On Sat, Jun 3, 2023 at 8:57 AM Mike Snitzer <snitzer@kernel.org> wrote:
> > >
> > > We all just need to focus on your proposal and Joe's dm-thin
> > > reservation design...
> > >
> > > [Sarthak: FYI, this implies that it doesn't really make sense to add
> > > dm-thinp support before Joe's design is implemented.  Otherwise we'll
> > > have 2 different responses to REQ_OP_PROVISION.  The one that is
> > > captured in your patchset isn't adequate to properly handle ensuring
> > > upper layer (like XFS) can depend on the space being available across
> > > snapshot boundaries.]
> > >
> > Ack. Would it be premature for the rest of the series to go through
> > (REQ_OP_PROVISION + support for loop and non-dm-thinp device-mapper
> > targets)? I'd like to start using this as a reference to suggest
> > additions to the virtio-spec for virtio-blk support and start looking
> > at what an ext4 implementation would look like.
> 
> Please drop the dm-thin.c and dm-snap.c changes.  dm-snap.c would need
> more work to provide the type of guarantee XFS requires across
> snapshot boundaries. I'm inclined to _not_ add dm-snap.c support
> because it is best to just use dm-thin.
> 
> And FYI even your dm-thin patch will be the starting point for the
> dm-thin support (we'll keep attribution to you for all the code in a
> separate patch).
> 
> > Fair points, I certainly don't want to derail this conversation; I'd
> > be happy to see this work merged sooner rather than later.
> 
> Once those dm target changes are dropped I think the rest of the
> series is fine to go upstream now.  Feel free to post a v8.

FYI, I've made my latest code available in this
'dm-6.5-provision-support' branch (based on 'dm-6.5'):
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/log/?h=dm-6.5-provision-support

It's what v8 should be plus the 2 dm-thin patches (that I don't think
should go upstream yet, but are theoretically useful for Dave and
Joe).

The "dm thin: complete interface for REQ_OP_PROVISION support" commit
establishes all the dm-thin interface I think is needed.  The FIXME in
process_provision_bio() (and the patch header) cautions against upper
layers like XFS using this dm-thinp support quite yet.

Otherwise we'll have the issue where dm-thinp's REQ_OP_PROVISION
support initially doesn't provide the guarantee that XFS needs across
snapshots (which is: snapshots inherit all previous REQ_OP_PROVISION).

Mike

