Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA9954B6CA
	for <lists+linux-block@lfdr.de>; Tue, 14 Jun 2022 18:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344778AbiFNQwZ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 14 Jun 2022 12:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346696AbiFNQvz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 12:51:55 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE0544A0F
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 09:51:54 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id f8so8211609plo.9
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 09:51:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=t83AYSlzSApM9nN7I9alCqcQKbV28raP6GborJR/Amc=;
        b=QROL8zsy/qLoJljA2EfuCExl/ZV9dMBmCEAUoVNakZfiuz4O3ZvWAtG41TebR9QxSf
         qs7DZd/Z1GZNOam991EDR+GDLtI6+ZW39DMVqB/cZasfea6MMlMklVSqnGH5H6hnE8yf
         dbFStvST+f6FN6TBe9aHLriLIE1QLxnghpHaa8xEKnjZD/+PyDahf70qbTQl2f5ijmUu
         b3PnDVv50DMGzrzm3ihYFCqy8cgOZkWPpzh2ZRk2p7bc9IVFYgCnjNiMkbTVfUyXq5Om
         f/9R461ckKMDORrvMgXfnjt3aY/U+My8LYb0RhXQewdCmBtsIrAHitEvCAMUEaTnROI4
         FlXQ==
X-Gm-Message-State: AJIora/zvMCR5TrEMfDlAeXnTsUeA6LIA/lsFKbVJgR+3Ns8BfZlJWAl
        byfGt8mosobfygXsG2J+5mY=
X-Google-Smtp-Source: AGRyM1tOVC0y3KN8th4nAQ9ARAtBJYthGH8OTKQsbaJOi+L4VnA8dzugaAeEIDnpN4lXIixQ2w+otg==
X-Received: by 2002:a17:90b:4c4a:b0:1e3:3b3:8800 with SMTP id np10-20020a17090b4c4a00b001e303b38800mr5662384pjb.6.1655225513748;
        Tue, 14 Jun 2022 09:51:53 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ab60:e1ea:e2eb:c1b6? ([2620:15c:211:201:ab60:e1ea:e2eb:c1b6])
        by smtp.gmail.com with ESMTPSA id p127-20020a62d085000000b0050dc7628137sm8169880pfg.17.2022.06.14.09.51.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 09:51:53 -0700 (PDT)
Message-ID: <6ed896d6-0167-9501-ab68-01d979c1d98c@acm.org>
Date:   Tue, 14 Jun 2022 09:51:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 5/6] block: fold blk_max_size_offset into get_max_io_size
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
References: <20220614090934.570632-1-hch@lst.de>
 <20220614090934.570632-6-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220614090934.570632-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/14/22 02:09, Christoph Hellwig wrote:
> Now that blk_max_size_offset has a single caller left, fold it into that
> and clean up the naming convention for the local variables there.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
