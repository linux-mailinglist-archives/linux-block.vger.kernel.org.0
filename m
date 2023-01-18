Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65761672C32
	for <lists+linux-block@lfdr.de>; Thu, 19 Jan 2023 00:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjARXCw (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 18 Jan 2023 18:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjARXCu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Jan 2023 18:02:50 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19C53C2B
        for <linux-block@vger.kernel.org>; Wed, 18 Jan 2023 15:02:48 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so3193024pjq.0
        for <linux-block@vger.kernel.org>; Wed, 18 Jan 2023 15:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=07OSw5FmIQ7xXLdCpaMJ2YrxM41emfDFK9D8MsKkq8M=;
        b=zq2N4WrKYZfksw4OJ5HtwizKo1VarEriJOuecPceQLTn6xFyO5y3qnCR4TnpbXg8u4
         xo1XHvkvAHpi15WGwuQ7IQvMTQx1JUOyrNtgYM5H9+GXw02jL2XKSND+JMKZ0oQ3j62z
         EH0p418lWAsVP0OJP6UgVzus76ocox/OGzSFdqe9PjaH5UCJ0L31YLofs+AE+cuB5hj7
         MAMgAGa00GPb8s7XCwSgFnZSh7ssNGe2DQcZLv17hdqY8c6Bza9qZD/9+T4zIdnrKu86
         KtLZ6n3QyczTmPm44ESNP0wcYTpfxzq0Hy5t7lG/FNSQsyogC2ekIZJgsBSYMWTiqgjt
         yNbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=07OSw5FmIQ7xXLdCpaMJ2YrxM41emfDFK9D8MsKkq8M=;
        b=RphDXfSSK5jmQez6zbc4De2U6Wo6QvhL8+kOaWOn62awd5TzJFmtZRhX/URbMUMPFY
         NTyyNJFF6vyIOuDuGyZUuVwM6T6Im32I0129khWVlq+XDpgtVJ3yg/EhTkMZQvj/Lhym
         5BJa6In28LHUx9H4kMaEhuBnI1c4WzsifTV2aoBFPcrt02pHBsIU7uF9zNr5rHwrBy7s
         QIbenQNa9Jyne4VSqVg9F4+sDUTs/BmSqGVANcqJOpldc23Jn6pgzx//GTkAQ9h9xB5P
         wc1ekFsN20JAwIBUMEb7+x+craLKdvTwmWh81lPGmYPg4HE7WfyjIdAkA4nzRvgQ5BUN
         5OOg==
X-Gm-Message-State: AFqh2krMqcrLs77rjdSbLLLWzrEUSSneory4AUzC/Sb36BLcvk3h6xW9
        Sa0MjAYiMdezAwjyJdJ8lFmo0A==
X-Google-Smtp-Source: AMrXdXvDv5AwrPXgKuAokTxyziBbKpue7MJv/IAdgGNI4xoTM3/KrTc3+qwAkAsD4lO4plESqF3NGg==
X-Received: by 2002:a05:6a20:e685:b0:b6:3e6e:af95 with SMTP id mz5-20020a056a20e68500b000b63e6eaf95mr1986348pzb.2.1674082968107;
        Wed, 18 Jan 2023 15:02:48 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id n15-20020a170902d2cf00b00194bea457e7sm1507551plc.292.2023.01.18.15.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 15:02:47 -0800 (PST)
Message-ID: <4f308b47-e08c-efa6-6a86-965ba6761350@kernel.dk>
Date:   Wed, 18 Jan 2023 16:02:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 1/9] block: Introduce QUEUE_FLAG_SUB_PAGE_SEGMENTS and
 CONFIG_BLK_SUB_PAGE_SEGMENTS
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Keith Busch <kbusch@kernel.org>
References: <20230118225447.2809787-1-bvanassche@acm.org>
 <20230118225447.2809787-2-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230118225447.2809787-2-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/18/23 3:54 PM, Bart Van Assche wrote:
> Prepare for introducing support for segments smaller than the page size
> by introducing the request queue flag QUEUE_FLAG_SUB_PAGE_SEGMENTS.
> Introduce CONFIG_BLK_SUB_PAGE_SEGMENTS to prevent that performance of
> block drivers that support segments >= PAGE_SIZE would be affected.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/Kconfig          | 9 +++++++++
>  include/linux/blkdev.h | 7 +++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/block/Kconfig b/block/Kconfig
> index 5d9d9c84d516..e85061d2175b 100644
> --- a/block/Kconfig
> +++ b/block/Kconfig
> @@ -35,6 +35,15 @@ config BLOCK_LEGACY_AUTOLOAD
>  	  created on demand, but scripts that manually create device nodes and
>  	  then call losetup might rely on this behavior.
>  
> +config BLK_SUB_PAGE_SEGMENTS
> +       bool "Support segments smaller than the page size"
> +       default n
> +       help
> +	  Most storage controllers support DMA segments larger than the typical
> +	  size of a virtual memory page. Some embedded controllers only support
> +	  DMA segments smaller than the page size. Enable this option to support
> +	  such controllers.

This should not be a visible option at all, affected drivers should just
select it.

-- 
Jens Axboe


