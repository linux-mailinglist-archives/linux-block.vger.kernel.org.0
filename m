Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F5E6E70DE
	for <lists+linux-block@lfdr.de>; Wed, 19 Apr 2023 03:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjDSBzT (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 18 Apr 2023 21:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjDSBzS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Apr 2023 21:55:18 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8FE4ECD
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 18:55:17 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-24762b39b0dso1142176a91.1
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 18:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1681869316; x=1684461316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3yMx5fYxd9C175mfLe8lqRxl1QU04ZvuY5JHAMxvGXI=;
        b=JTClS8+wTrBV1rxVUYS9q8uw6u8dxR78MWe0zSZtLpo7xGsS5N13qILbeTwPfuR0ar
         tn5NCTU/65rxbpjaDHm7RZDl9/mBDWgcHrb1XHuhk9gxZAOWU4UtyHeMdlmWaoivNs6e
         86hhFHd0CBqlgV4YhYI1FCmyfI1hEleIBZvwCGnclJ3ff7ARjN2lP7ffpEFpIn/McnFF
         SEeteH+38HCv4YcfI/54X2QbUFxBS00XVyu3OVNCm8yZ9OhuqIUo3YhTaM9nPs1kgjFr
         2An2ZPym3KKxd6fTJMmim9vYZGlzHgtPqcea3Vx76lWTShqGuRmLCJexaOceORZksQ+Z
         7TZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681869316; x=1684461316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yMx5fYxd9C175mfLe8lqRxl1QU04ZvuY5JHAMxvGXI=;
        b=b8X4/541Ozz2hMnMon1k3w+OX6scLvR9hI7BIWaDV0EP/pqNKw3hhjgRYb172Ul20k
         pMwHhR5/yMxw+iUCmvYnw0cH4b3K74HL5wz43Dfi+PqNiJIVIp65bYhv6EiSaTz9lN5Q
         1FE6v3547VADV6/MteN4Sg36UeDOD6rTnBlaKeINY+w5u4NCa/AXW1fk2vrpMPByY2+N
         T1/MP93gGQt8LctQbE56DEngaqbjZbphijGdz02QrAyShD7PA5sstJF0JRSqHSWXYeFu
         SLFXNYU/43eUmInF9cw0f9vdxgASSqCrnR1P4Y9RPkoNj2KDdrlCjCucyyGvbrGCsuM5
         c3mw==
X-Gm-Message-State: AAQBX9c9eohvZgW3PWnRqqUUyoI3xxerZGGa3fCpMdrcT0GTsk0Tywnk
        7WsoldIOwnmCX7ZY+7S0wDpxJQ==
X-Google-Smtp-Source: AKy350ZkIYBC14VQSQlaDtDhGCzV/AiSdCVbEF8ylA2ILJmqON245CqgcSEfoq2eYAbHZoKwQcxWUg==
X-Received: by 2002:a17:90a:a894:b0:23c:fef0:d441 with SMTP id h20-20020a17090aa89400b0023cfef0d441mr1301184pjq.33.1681869316634;
        Tue, 18 Apr 2023 18:55:16 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-41-174.pa.nsw.optusnet.com.au. [49.180.41.174])
        by smtp.gmail.com with ESMTPSA id k8-20020a634b48000000b0051ba4d6fe4fsm4796613pgl.56.2023.04.18.18.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 18:55:15 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pox2O-0055Sk-P8; Wed, 19 Apr 2023 11:55:12 +1000
Date:   Wed, 19 Apr 2023 11:55:12 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Kyle Sanderson <kyle.leet@gmail.com>
Cc:     linux-btrfs@vger.kernel.org,
        Linux-Kernal <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: btrfs induced data loss (on xfs) - 5.19.0-38-generic
Message-ID: <20230419015512.GI447837@dread.disaster.area>
References: <CACsaVZJGPux1yhrMWnq+7nt3Zz5wZ6zEo2+S2pf=4czpYLFyjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsaVZJGPux1yhrMWnq+7nt3Zz5wZ6zEo2+S2pf=4czpYLFyjg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Apr 16, 2023 at 10:20:45PM -0700, Kyle Sanderson wrote:
> The single btrfs disk was at 100% utilization and a wa of 50~, reading
> back at around 2MB/s. df and similar would simply freeze. Leading up
> to this I removed around 2T of data from a single btrfs disk. I
> managed to get most of the services shutdown and disks unmounted, but
> when the system came back up I had to use xfs_repair (for the first

What exactly was the error messages XFS emitted when it failed to
mount, and what did xfs_repair fix to enable it to boot? Unless you
have a broken disk (i.e. firmware either lies about cache flush
completion or the implementation is broken), there is no reason for
any amount of load on the disk to cause filesystem corruption....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
