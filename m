Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3732064CE7F
	for <lists+linux-block@lfdr.de>; Wed, 14 Dec 2022 17:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239186AbiLNQ5H (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 14 Dec 2022 11:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239195AbiLNQ46 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Dec 2022 11:56:58 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759F81AF20
        for <linux-block@vger.kernel.org>; Wed, 14 Dec 2022 08:56:57 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id v2so3713942ioe.4
        for <linux-block@vger.kernel.org>; Wed, 14 Dec 2022 08:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+IqN/UFmzZrEibODg3m/L1J+2MIkf8gPpvi4AhxE0rI=;
        b=Tr9KjKxPfOrvyg/SlAr3G0wYWAk1UreVI+Jp0ogHuK9sYGPI6TLN2bdwSO7JE9YN5P
         ksq36k620RJublNfl2UgV0rcqufHvRy3WPZ1/DwJY5mEzTkXsKBQpFeYNSQafVJs/g5m
         bddWHvyIRkWIjk6XLgscQ22NQRzC1MS/db8GVzT3NAYZmp4T13GzoGp9XmQLdGHWALMt
         0WokKjmKiiOxdGDB4hkRHUOCnT/AeUKWtXKcLAEmpX/i/FeNibZqDKuK34fXQ4DdD9lX
         kMHALlS4FAY2jJZj/5A9zLlipomJ24/3huviN/0VKdXs7IKs+uzS51RYhIZDc3VLHkem
         1LiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+IqN/UFmzZrEibODg3m/L1J+2MIkf8gPpvi4AhxE0rI=;
        b=CcOjLwCQ6YqzjdrKocqEIn80nMhbzp5ezosmiZRi8qDpvyYftzjaSuucbdmQ+hhNAr
         neTcRS9lM3i8QKhVIK/28fLs+WaKYUaA9obrLrdEKQ0IzUcvoSj++WXmwWse/Hhhuk7u
         DYcCxYair74P64KbeGiikHumUcaeVaJZ58zLXjEokyqo1qevoYlzv4YnPKMDqrinBdSr
         fOlkoHPBWaAnlE9kBPKaofQHvz7MKq+NmxZ5MsuezMY93b15MaF4llqXav4yTP7HvZ2Z
         c9vLaXydswoDw/G405O3AyitZyZxEhpiXzLY/EoRVj66H6NN9zMRunuoQ6fE/SohT19m
         moKg==
X-Gm-Message-State: ANoB5pngu0A+ExGCSQjIKcg6jVP3pH4KteGdVDwpmAkQO/MQ5bdAjy/a
        kJ1HRdfqL0va+TGc1MB5Uy2yaA==
X-Google-Smtp-Source: AA0mqf6hY/cxfbLGBy5lpJsAXpenWJGKz6PStcJNLjvFqomX4RsJ7597HGshXcMaRC/vLki1ccjSeg==
X-Received: by 2002:a5d:9496:0:b0:6da:6978:29bd with SMTP id v22-20020a5d9496000000b006da697829bdmr2713516ioj.0.1671037016734;
        Wed, 14 Dec 2022 08:56:56 -0800 (PST)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id j21-20020a0566022cd500b006bbddd49984sm102876iow.9.2022.12.14.08.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 08:56:56 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     paolo.valente@linaro.org, tj@kernel.org, josef@toxicpanda.com,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
In-Reply-To: <20221214033155.3455754-1-yukuai1@huaweicloud.com>
References: <20221214033155.3455754-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH 0/2] block, bfq: minor cleanups
Message-Id: <167103701587.7871.17006883057809106433.b4-ty@kernel.dk>
Date:   Wed, 14 Dec 2022 09:56:55 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.0-dev-50ba3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Wed, 14 Dec 2022 11:31:53 +0800, Yu Kuai wrote:
> Yu Kuai (2):
>   block, bfq: don't return bfqg from __bfq_bic_change_cgroup()
>   block, bfq: replace 0/1 with false/true in bic apis
> 
> block/bfq-cgroup.c  | 16 +++++++---------
>  block/bfq-iosched.c |  4 ++--
>  2 files changed, 9 insertions(+), 11 deletions(-)
> 
> [...]

Applied, thanks!

[1/2] block, bfq: don't return bfqg from __bfq_bic_change_cgroup()
      commit: 452af7dc59033a76372d51a24682503377872b11
[2/2] block, bfq: replace 0/1 with false/true in bic apis
      commit: 337366e02b370d2800110fbc99940f6ddddcbdfa

Best regards,
-- 
Jens Axboe


