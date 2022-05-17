Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED06F52A140
	for <lists+linux-block@lfdr.de>; Tue, 17 May 2022 14:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345873AbiEQMNe (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 17 May 2022 08:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345713AbiEQMN0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 May 2022 08:13:26 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0554578A
        for <linux-block@vger.kernel.org>; Tue, 17 May 2022 05:13:23 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id gg20so7123265pjb.1
        for <linux-block@vger.kernel.org>; Tue, 17 May 2022 05:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=0CFZi2WdHh+fWnk2m1bIXH7l+E5jrgN/oQfn0swAlk0=;
        b=J1JomReZIjMEXQobTzVFw7ummBWdomtyzdyFFet3/kcc/jM+gvVqVpq2Vc/6ULmkci
         TrdzxzJOgkhyPeKaEB8TyJ7GUYbqXaJZChg1Rzz1OPOY2zKD77e7B0Ud/Ct9XzPpczfQ
         yUdrdQGcMoQGHU1XbBhSp/qOlzwdGZgqOReniRcnAHlJWwroi239fLHrS611gIYdCqsQ
         s1AQKsJqLq7O3ZWsoslHYwzyf+cl8QKLKbhwG54yFd7Xi3PMk4WPr07FuzlA155FlJn/
         w1x8iegRjjG7bDocm0Y6wTLVG0E4NoUC9hTcL58Y6RzIYndo/yNAwrJ53a0ICDcGifsf
         mAVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=0CFZi2WdHh+fWnk2m1bIXH7l+E5jrgN/oQfn0swAlk0=;
        b=KLHRGPHMm4yIBKpeKo3s0E2YLcVdxZhov8O+C7H0c4zxlJXJd+aVwH4PD6es0hVnEX
         Bv/A+SXydfrzInqFKmkXxl1Q2knTJqyPykqaKFDzuy//PQtFvGuqCuCIGPpO42Cz4Uug
         FUTwmz5cSN8p8CWnrcKKkGRocsQk8jEArhNYqE/3gPN/zZ3+ETq6v6Rcf5mq6xNsp11k
         PPgJ4DHjALgR2qAzCyv3SX9fsnE2fCw0EhadWjPmwgvRuUGjzsP0oTJHs0ha4X18iss4
         5IzQIIpnCrc4mjSFCBG/syavdQgrDgb5ScjNHBTKJGeHXbxnRyR1kVXCJvWybqrouK+p
         c4IA==
X-Gm-Message-State: AOAM531EAgvqHcCQYf/UmyVPsEtiTA+UH7A+F1xuyPYESjeBoyqy0dyc
        ztr8PfihZIYfTlyrUNp9PTdTvyVKhKIO/g==
X-Google-Smtp-Source: ABdhPJyDx71heU0gfcxf+CGzQq7lXgAi5h3sMUNbGKzfQW4j5ZJ5G1UoPX9LPtNbpGfbEUenH6f63w==
X-Received: by 2002:a17:903:1248:b0:151:9708:d586 with SMTP id u8-20020a170903124800b001519708d586mr22127846plh.15.1652789603163;
        Tue, 17 May 2022 05:13:23 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b10-20020a170902650a00b0015e8d4eb269sm8754436plk.179.2022.05.17.05.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 05:13:21 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org, bh1scw@gmail.com
Cc:     songmuchun@bytedance.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220516173930.159535-1-bh1scw@gmail.com>
References: <20220516173930.159535-1-bh1scw@gmail.com>
Subject: Re: [PATCH] blk-cgroup: Remove unnecessary rcu_read_lock/unlock()
Message-Id: <165278960081.13853.15178111681664943346.b4-ty@kernel.dk>
Date:   Tue, 17 May 2022 06:13:20 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 17 May 2022 01:39:30 +0800, bh1scw@gmail.com wrote:
> From: Fanjun Kong <bh1scw@gmail.com>
> 
> spin_lock_irq/spin_unlock_irq contains preempt_disable/enable().
> Which can serve as RCU read-side critical region, so remove
> rcu_read_lock/unlock().
> 
> 
> [...]

Applied, thanks!

[1/1] blk-cgroup: Remove unnecessary rcu_read_lock/unlock()
      commit: 77c570a1ea85ba4ab135c61a028420a6e9fe77f3

Best regards,
-- 
Jens Axboe


