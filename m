Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0436596E36
	for <lists+linux-block@lfdr.de>; Wed, 17 Aug 2022 14:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239263AbiHQMH4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 17 Aug 2022 08:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239362AbiHQMHl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Aug 2022 08:07:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CB9883FA
        for <linux-block@vger.kernel.org>; Wed, 17 Aug 2022 05:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660738024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uvED31tz28w3zR0MRsRpAF+4dRa0mrzWJzSKyavcZMM=;
        b=TpOUYd6Nk3jdrpmp41LJCoXXzz5JI0lPMuHGvbxQ6sTqByk9OJe4L9NOMMtf19Q0+199uS
        Ciig3F9XPyTqcSPzLmtZ7JWm2e9FZLzxXtb6M2x6Wh0/lBFL+9kJTe3rCoN6MHU/C35N6U
        RVj+J0HOI2K5sEg29SjG2/0UVRStpr0=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-437-ueJrywy6O5qOtdd6gEiwXQ-1; Wed, 17 Aug 2022 08:07:03 -0400
X-MC-Unique: ueJrywy6O5qOtdd6gEiwXQ-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-329a474c437so150943687b3.18
        for <linux-block@vger.kernel.org>; Wed, 17 Aug 2022 05:07:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=uvED31tz28w3zR0MRsRpAF+4dRa0mrzWJzSKyavcZMM=;
        b=ie0YOaHVLpsfQJ7DpHDcMkI66rNsPBhY445z1dyPCjRfmNurL9b5fxB4BjP8DneZ96
         Cmn4d3B2NkgI66TElci62IldrN815HNW/X3kKmn62R9uSiFVF/dEcQkOdjsDZ021Sohc
         gIOlZi1WEhn152nEkwCxEMzduwcqfUpfSCWlgDTA3ra0PMQzQCo0KvboiJUKyF2/Cjfk
         L6/q0Z5zCpntwFmHRzmFPe8KehgKiI/eDEUx2irhHelr1qfhvOvpYOdZ4W5ew2Rl/Hlm
         DR5cv6QsyHY+5O6j3VqMJ8F+Hp38PMo7AT4JqLX4VBof+7Ug0WH7eWx7Yc4lQC0Ui+xo
         5gCw==
X-Gm-Message-State: ACgBeo2ALudIKYV7cAFPTXuWqts8yMlTlBTHh0yS6yKJrE3n0wapyRRr
        lOUi63l/0XjpAYIbNXy9v/XZY3PBPpAIvfF8yEfbSTFsbWprLmAcGjJrvPIErpW/eei47XGchhQ
        PuVKp3TyChKFA/PJwPm2HxXM9z3vqCfijKvYBK0E=
X-Received: by 2002:a25:e209:0:b0:67c:234a:f08c with SMTP id h9-20020a25e209000000b0067c234af08cmr19261950ybe.19.1660738022541;
        Wed, 17 Aug 2022 05:07:02 -0700 (PDT)
X-Google-Smtp-Source: AA6agR62CJmKIVjjGO862klgBFeJm3NBx72xx36Q9rR58vnUPEUrkGjik0Yn2s8sx5yftCEoPxhb1gkbhMxTvLwwrcg=
X-Received: by 2002:a25:e209:0:b0:67c:234a:f08c with SMTP id
 h9-20020a25e209000000b0067c234af08cmr19261926ybe.19.1660738022293; Wed, 17
 Aug 2022 05:07:02 -0700 (PDT)
MIME-Version: 1.0
References: <e38aa76d-6034-4dde-8624-df1745bb17fc@www.fastmail.com>
 <YvPvghdv6lzVRm/S@localhost.localdomain> <2220d403-e443-4e60-b7c3-d149e402c13e@www.fastmail.com>
 <cb1521d5-8b07-48d8-8b88-ca078828cf69@www.fastmail.com> <ad78a32c-7790-4e21-be9f-81c5848a4953@www.fastmail.com>
 <e36fe80f-a33b-4750-b593-3108ba169611@www.fastmail.com> <CAEzrpqe3rRTvH=s+-aXTtupn-XaCxe0=KUe_iQfEyHWp-pXb5w@mail.gmail.com>
 <d48c7e95-e21e-dcdc-a776-8ae7bed566cb@kernel.dk> <61e5ccda-a527-4fea-9850-91095ffa91c4@www.fastmail.com>
 <4995baed-c561-421d-ba3e-3a75d6a738a3@www.fastmail.com> <dcd8beea-d2d9-e692-6e5d-c96b2d29dfd1@suse.com>
 <2b8a38fa-f15f-45e8-8caa-61c5f8cd52de@www.fastmail.com>
In-Reply-To: <2b8a38fa-f15f-45e8-8caa-61c5f8cd52de@www.fastmail.com>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Wed, 17 Aug 2022 20:06:51 +0800
Message-ID: <CAFj5m9+6Vj3NdSg_n3nw1icscY1qr9f9SOvkWYyqpEtFBb_-1g@mail.gmail.com>
Subject: Re: stalling IO regression since linux 5.12, through 5.18
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>,
        Paolo Valente <paolo.valente@linaro.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux-RAID <linux-raid@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Chris,

On Tue, Aug 16, 2022 at 11:35 PM Chris Murphy <lists@colorremedies.com> wrote:
>
>
>
...
>
> I already reported on that: always happens with bfq within an hour or less. Doesn't happen with mq-deadline for ~25+ hours. Does happen with bfq with the above patches removed. Does happen with cgroup.disabled=io set.
>
> Sounds to me like it's something bfq depends on and is somehow becoming perturbed in a way that mq-deadline does not, and has changed between 5.11 and 5.12. I have no idea what's under bfq that matches this description.
>

blk-mq debugfs log is usually helpful for io stall issue, care to post
the blk-mq debugfs log:

(cd /sys/kernel/debug/block/$disk && find . -type f -exec grep -aH . {} \;)

Thanks,
Ming

