Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4F069EB9A
	for <lists+linux-block@lfdr.de>; Wed, 22 Feb 2023 01:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjBVAEa (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 21 Feb 2023 19:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjBVAE3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Feb 2023 19:04:29 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5391199F8
        for <linux-block@vger.kernel.org>; Tue, 21 Feb 2023 16:04:28 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id x34so3500172pjj.0
        for <linux-block@vger.kernel.org>; Tue, 21 Feb 2023 16:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1677024268;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7jDnW0HDCFT2WtUuTLrGs+5SaLu9KYOYBtFvqC+x1n0=;
        b=S3qHMX8G5wNBo1EBqlYZwUIXn0KozQaHBf7r5e2eOGRh2LXmzr1Zuz2rOmDuPnRjvT
         P1Y6ExiEuJ4BMlr06EYOniSDpznIhXc4JVXspfmRIVN4wDqyAi35DSTuHx6/08OoBQjl
         0ULw08M6nTQ2LNfLs2ZTsiSlUjFlewfbMTFiPw/YM/vDgw7vUQ44Hsev2oWvcrSlkwCb
         UPkbxKhauCj7H3vmF0LwZ8DJVljks9g0M4xd5pFu28a8nv6qh6iebZEkM3Ww7PLSl5so
         raQX5/vgLHf5SfQfQTjVlzFXlrXEOlO71fycnsLGxPG4MeOaQ+kuEyWGn0gOVQkzN0gI
         PnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677024268;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7jDnW0HDCFT2WtUuTLrGs+5SaLu9KYOYBtFvqC+x1n0=;
        b=eUzTi6iFdk5FHimLfK66R6LosvEHkVJ1CyivrPsUNqbwWt2MJ8qP1YF8+5YBNbko2t
         KSZXzfaelcOiTyJi6g0uIG3fW38xG7m1FnidhA1WQZZrgDnedZB0s2bX9ksyBtPkbyXU
         E9uLQqpeigx6C0V3C7CBzjt5Zz6CUUYW2cTsR3LzSu/VEPiHLgUrsRwqPu8m4svJ6EKO
         0ucbVhNMgTWPPCGax0zOfH0NG8Ctoywe0DAIvQqE9MRDXnKe+YR348W54+L3cPxYbFCB
         83Pw7lMquRJcndS3C9eFGCx0JWF6iOXKCG/XgvAaqiGNuDJIPVL7l9zsX4ZGEiAvofsZ
         g0cw==
X-Gm-Message-State: AO0yUKVYbPPzSuGy5I6jdKB9tGbbxubeIpC5wzQ9MKwOQpfocPYEQase
        uSY6ymvjT19zCFQ424JHGeG87g==
X-Google-Smtp-Source: AK7set/qdwfBKYH2USiO7c/nsZpEm122B8ZpVxecq1Xy3gtCN5c2lxyaQdubSM63b/Ggc7fzx3Z07Q==
X-Received: by 2002:a17:902:e5c1:b0:196:82d5:1ec4 with SMTP id u1-20020a170902e5c100b0019682d51ec4mr7507020plf.0.1677024268027;
        Tue, 21 Feb 2023 16:04:28 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id a24-20020a637058000000b004fcda0e59c3sm3584565pgn.69.2023.02.21.16.04.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 16:04:27 -0800 (PST)
Message-ID: <b63d9061-555d-787a-7759-bcba5313be4d@kernel.dk>
Date:   Tue, 21 Feb 2023 17:04:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] block, bfq: free 'sync_bfqq' after bic_set_bfqq() in
 bfq_sync_bfqq_move()
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz,
        paolo.valente@linaro.org, damien.lemoal@opensource.wdc.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
References: <e2071a24-cd25-e5bd-9166-a3b575b7bf4a@huaweicloud.com>
 <20230221082905.3389012-1-yukuai1@huaweicloud.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230221082905.3389012-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/21/23 1:29 AM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> As explained in commit b600de2d7d3a ("block, bfq: fix uaf for bfqq in
> bic_set_bfqq()"), bfqq should not be freed before bic_set_bfqq().
> However, this is broken while merging commit 9778369a2d6c ("block, bfq:
> split sync bfq_queues on a per-actuator basis") from branch
> for-6.3/block.
> 
> Fixes: 9778369a2d6c ("block, bfq: split sync bfq_queues on a per-actuator basis")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/bfq-cgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index ea3638e06e04..89ffb3aa992c 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -746,8 +746,8 @@ static void bfq_sync_bfqq_move(struct bfq_data *bfqd,
>  		 * old cgroup.
>  		 */
>  		bfq_put_cooperator(sync_bfqq);
> -		bfq_release_process_ref(bfqd, sync_bfqq);
>  		bic_set_bfqq(bic, NULL, true, act_idx);
> +		bfq_release_process_ref(bfqd, sync_bfqq);
>  	}
>  }

This is already in -git, see my reply to Linus. Eg this will apply
to for-6.3/block, but it will not apply to current master that
has it merged because we got that from the 6.2 side.

-- 
Jens Axboe


