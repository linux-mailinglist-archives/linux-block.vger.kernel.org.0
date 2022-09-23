Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E6E5E7E18
	for <lists+linux-block@lfdr.de>; Fri, 23 Sep 2022 17:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiIWPTW (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 23 Sep 2022 11:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiIWPTV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Sep 2022 11:19:21 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384EF12ED86
        for <linux-block@vger.kernel.org>; Fri, 23 Sep 2022 08:19:20 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id q83so164204iod.7
        for <linux-block@vger.kernel.org>; Fri, 23 Sep 2022 08:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=nBzYZNxiqwS8B8wtF4j5G6kTvhawC1R2E1pDH0ol8Ww=;
        b=3AqQfBjqICcqKiJzARi6Ht6xdhsQCR/4z6U3qHkqScv6uM+HA45gS2X8NBuWb3jgWz
         UD8Bgz1t4OyYKJkV3589UzKLmx/DgimVWPSEye6926Q6Qp8Vk1YQmNe82cINdpFnNtJB
         0VFuIs8p0OTxciJLSxRnQirk4BlMvqu2yCzPDFrXFfOMGRs5Vo+Ojwz/IS34FfH4a7BB
         koppDnm7VDGJoSC23AO6M0g5efy8ksMb1JoU8svDAx/JBIApYJd/PxR20rjk33p7xfaU
         xNTOplNxnzppTFfF3SHwtwm9j7du6/52Fj9zB4BpVwCqKI6JX55fYi1xHNvWUE/KHU3n
         oFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nBzYZNxiqwS8B8wtF4j5G6kTvhawC1R2E1pDH0ol8Ww=;
        b=Icq5GRFhTSZAYSW0GYx45u50JzHZSyWom2kNNELRu4mO3EnhCMw566ePOWtFICK1nI
         pkRb/KxEEv0wg7nbWy4Vz7hgokdgSljyDbL1/JsVViqHfDWNxJcvgMotOSGT3HrnIVII
         vfhKu0KQGB5rJsI9EmB+qtj2gY7B3n/N3Bex8yDPmnsC/+EwXKxRTAWpZuYr2d7O9y2k
         yKrIhnmWXBX9hWDk30VUsKF5wAY2s5XoeTAvQtwXyk3DS1by4GA39sKAWrP0VOYFluCq
         dwh82UyyKuYvIzNPg8Xue1yRUuLUzhdnrx7QMLL44A7FEhsmXJsDncKCh6PMCSXP7GMI
         EqMg==
X-Gm-Message-State: ACrzQf17KsFBmWJpB4lSwrgj6nMainbwhCVaXs+G4/87cvzeHeLK+W79
        YmURBAFq2MfM3G+xTfsLO4XxqHQfRudq5w==
X-Google-Smtp-Source: AMsMyM5Tai736JME3Hle0FFNp1nDrUfTShe7bOnunKGGouTOODQqiIsYwkfT8nwAo0WOQGmx1dFrFg==
X-Received: by 2002:a05:6638:43:b0:359:543e:a7d6 with SMTP id a3-20020a056638004300b00359543ea7d6mr4886375jap.166.1663946359509;
        Fri, 23 Sep 2022 08:19:19 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id j188-20020a0263c5000000b0035b0d6f3219sm3376200jac.75.2022.09.23.08.19.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 08:19:19 -0700 (PDT)
Message-ID: <6f7600be-d4b9-aeac-7dd1-71992a4dd5e8@kernel.dk>
Date:   Fri, 23 Sep 2022 09:19:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCHSET 0/5] Enable alloc caching and batched freeing for
 passthrough
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20220922182805.96173-1-axboe@kernel.dk>
 <Yy3NyACongSfayY+@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yy3NyACongSfayY+@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/23/22 9:16 AM, Christoph Hellwig wrote:
> On Thu, Sep 22, 2022 at 12:28:00PM -0600, Jens Axboe wrote:
>> This is good for a 10% improvement for passthrough performance. For
>> a non-drive limited test case, passthrough IO is now more efficient
>> than the regular bdev O_DIRECT path.
> 
> How so?  If it ends up faster we are doing something wrong in the
> normal path as there should be no fundamental difference in the work
> that is being done.

There's no fundamental difference, but the bdev path is more involved
than the simple passthrough path.

-- 
Jens Axboe


