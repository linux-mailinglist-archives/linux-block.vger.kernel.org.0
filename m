Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A846DE2D7
	for <lists+linux-block@lfdr.de>; Tue, 11 Apr 2023 19:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjDKRlx (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 11 Apr 2023 13:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjDKRlx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 13:41:53 -0400
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37EF40EE
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 10:41:32 -0700 (PDT)
Received: by mail-pj1-f42.google.com with SMTP id c10-20020a17090abf0a00b0023d1bbd9f9eso11802545pjs.0
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 10:41:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681234887; x=1683826887;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ikH3I4G7dimPi++wdeQsGfDrb4B9wt6ZAgxKXJ2q3n8=;
        b=Y5nlx/H9np9Z5KbrxcJ/mwwNntzXaBvkITvFOIggxpMWTwmJ0ECJJw6L8hLMXdj3oa
         HL2KTJ5nj5p66EUczkD20zsQ+V0Ze/V8xioEc/fBH5pBqTeHjbgOrUNMNh/LMSuqwNzr
         OdXL6YOQHoQI8pcjNrYNXzfhoCVzigSkmFVpKN7VwEaB/9Nvt+8g7BNyc9zFuhPxuwJl
         7RrtKzv5NcZTqCCtYm2Uzp0mgYlL+pemWRj4FSbvvuHQQhKXSN+QBv/iWyY7b2qn2tal
         QjCGmLJ1iWdqOE8rIFySIgTeM23PjR+Su8EU2OmY3N0/fxKH/qk7SLqZSXkIS8e18Hdr
         Z0Jw==
X-Gm-Message-State: AAQBX9eSvCKZd6O6a3eNIZjfehkPxWdyNWlmyXGctgX5UVYfwdQE6nxU
        5OHY6dR1/rvXS0SoshPk7Jw=
X-Google-Smtp-Source: AKy350Ybju0hrphSfjL29yMWT/ZQCqvwh5PSCRfoFxxSOoPnpmH5RmILfnaLntikRz/1OKkyajbGIw==
X-Received: by 2002:a17:90b:3892:b0:246:c223:14ba with SMTP id mu18-20020a17090b389200b00246c22314bamr7566134pjb.28.1681234887169;
        Tue, 11 Apr 2023 10:41:27 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:646f:c9f7:828a:8b03? ([2620:15c:211:201:646f:c9f7:828a:8b03])
        by smtp.gmail.com with ESMTPSA id c19-20020a170902849300b001a520f9071dsm7319813plo.7.2023.04.11.10.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 10:41:26 -0700 (PDT)
Message-ID: <01e4e078-3f2b-1c04-44a1-93af36c6ef32@acm.org>
Date:   Tue, 11 Apr 2023 10:41:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 01/16] blk-mq: don't plug for head insertations in
 blk_execute_rq_nowait
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <20230411133329.554624-1-hch@lst.de>
 <20230411133329.554624-2-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230411133329.554624-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/11/23 06:33, Christoph Hellwig wrote:
> Plugs never insert at head, so don't plug for head insertations.

insertations -> insertions

Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
