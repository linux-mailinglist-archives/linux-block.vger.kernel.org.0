Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F264FA5D4
	for <lists+linux-block@lfdr.de>; Sat,  9 Apr 2022 10:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241084AbiDIIRq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 9 Apr 2022 04:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiDIIRp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 Apr 2022 04:17:45 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F382DCC83
        for <linux-block@vger.kernel.org>; Sat,  9 Apr 2022 01:15:38 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v2so2350307wrv.6
        for <linux-block@vger.kernel.org>; Sat, 09 Apr 2022 01:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=sw+fQbvS6SFTnotjqrxbhqCVHIPsenv7yxMzOYGId1I=;
        b=swx5mkkbJNix1TPl46oJjK+Fw0+J2z/XHhCyUPh+dcKkTNBekj88xkgZeDCIEgfzZd
         +FA0t7ckuNM4K4OwCilxgo/M+WNIfDm8hTC88nPXmxm39Wp7Y3PlmqfYEyysUU8hQUUf
         QcFmQYaxbOUrhMO1omCXZ8F/Rog5zixS+JPWEUQR0KkNkX4orlWG0JIiavrTh9qI4888
         PfuJYdextltFDNT3Q+47ZPQuPkokUbAa0jhifptu2z1GSQMaUF7eHMsw0ukFDymbedqA
         fJT7coHgReWy+GC/y+kW2UJS/DziuPPZTxFTP9KzlhdtF9p6DIhUJyZVoMiIdhtFkJM+
         cESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sw+fQbvS6SFTnotjqrxbhqCVHIPsenv7yxMzOYGId1I=;
        b=lChPiWPh/tEXnmLP+w4jfNaTCzd84g8duUeeGS/6kd9oGhyVaN2bWyB7336Fxv/FuV
         53+G2pXRnASZfQ4U630EfKRTlHPBaBLUNnwcFoXWsF9Fm+jgQfB+G6vamoJzmyh5/m8i
         E+jTF7dSfkTVJPE/LRYejafZgwRUx429TdAJJZKyfGSxz2ynzQx2hlr84CxCcSijc0lo
         5jd8Q9+QPJlINfUVwnSFthQ7PzDuLulcyFupyJjZIq2GWALGFb6ePXM6e3PDzuAhxV+M
         z/iWyZBI0XwOLltwzua/P56GXHrwxP6WqNsVdE9XBo/LM0RF7eoSUWVCdbaAxnz9zMg9
         gCmA==
X-Gm-Message-State: AOAM532xVT8YRdfGWzYeMg7Sw2417IMqakwngTuFs+vbVfzE4mmQk9cC
        2s/PL1Kq/WQqK7OONKLLkR1g9w==
X-Google-Smtp-Source: ABdhPJzQQyyFsXyXf3Tt03078VjcrkSv2k98fwj9oToPATRHlAVDyH773lIm4bEik17KjObuot5lIg==
X-Received: by 2002:a5d:6c6b:0:b0:1ea:77ea:dde8 with SMTP id r11-20020a5d6c6b000000b001ea77eadde8mr17920640wrz.690.1649492137216;
        Sat, 09 Apr 2022 01:15:37 -0700 (PDT)
Received: from [192.168.169.127] (178.115.52.210.wireless.dyn.drei.com. [178.115.52.210])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c4f5400b0038b5162260csm16809052wmq.23.2022.04.09.01.15.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Apr 2022 01:15:36 -0700 (PDT)
Message-ID: <72e9bd34-3380-e305-65f0-a17306f5bd08@linbit.com>
Date:   Sat, 9 Apr 2022 10:15:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 24/27] block: remove QUEUE_FLAG_DISCARD
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     dm-devel@redhat.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-um@lists.infradead.org,
        linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
        nbd@other.debian.org, ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, Jens Axboe <axboe@kernel.dk>,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org,
        ntfs3@lists.linux.dev, ocfs2-devel@oss.oracle.com,
        linux-mm@kvack.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Coly Li <colyli@suse.de>
References: <20220409045043.23593-1-hch@lst.de>
 <20220409045043.23593-25-hch@lst.de>
From:   =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
In-Reply-To: <20220409045043.23593-25-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 09.04.22 06:50, Christoph Hellwig wrote:
> Just use a non-zero max_discard_sectors as an indicator for discard
> support, similar to what is done for write zeroes.
> 
> The only places where needs special attention is the RAID5 driver,
> which must clear discard support for security reasons by default,
> even if the default stacking rules would allow for it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Acked-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com> [btrfs]

I think you may have a typo there: my ACK was for drbd, not btrfs.

> Acked-by: Coly Li <colyli@suse.de> [bcache]
> ---
>   arch/um/drivers/ubd_kern.c          |  2 --
>   block/blk-core.c                    |  2 +-
