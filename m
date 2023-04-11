Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C436DE2EC
	for <lists+linux-block@lfdr.de>; Tue, 11 Apr 2023 19:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjDKRo6 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 11 Apr 2023 13:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjDKRoy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 13:44:54 -0400
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F024C2B
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 10:44:43 -0700 (PDT)
Received: by mail-pj1-f51.google.com with SMTP id jx2-20020a17090b46c200b002469a9ff94aso6963514pjb.3
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 10:44:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681235083; x=1683827083;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f8vFrGQwqvAGA6FbpOzmkO9xublPirVuP0Cr4PXD7Uw=;
        b=2O1aTBAgvHVfQC+ZLVi7LenfS+aOsbaDpKRH5HdvdXbMex8I6CUWnF9RNeub41KTX0
         I9QiBZ2c7NWeQcEDxVz1uGEtQtFTUx1KrCo7TIiS3AthfUNkisMFnWTNQcGEYk93W5oO
         l+G1NlSVSmBTQHEmQlMwagFUxbZHFvbGcYnRi/WzdN/OzmeBy9vfAO9aXzoypPsu7NyL
         TKe/gHDyqjXCqGCsbuZpGeA7kvc1B2Kh7vJis4zo5zt1vdJltM08MV/Hto3M9H6klvQI
         R388zRtmLnf9UX1F7fyYMkspxQBMPltaaWOBCokF86fDCAoNF5/8E2WnFo7QsHVHT4g5
         otsA==
X-Gm-Message-State: AAQBX9cRnf8U/gZXlJ0w7Kj6OiQ2k2MpuGbZVMdte60eNuxWMe6MusC3
        652bAciZXAJUtnrsozeXic8=
X-Google-Smtp-Source: AKy350a381lY1xLYy2JPFONHMe5VxHAb0jTBJ1JZ6aGZb+D/Cj2V76PAgCixGWdcEujkQ12HI+FE2g==
X-Received: by 2002:a05:6a20:a926:b0:bb:b903:d836 with SMTP id cd38-20020a056a20a92600b000bbb903d836mr2998904pzb.54.1681235083202;
        Tue, 11 Apr 2023 10:44:43 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:646f:c9f7:828a:8b03? ([2620:15c:211:201:646f:c9f7:828a:8b03])
        by smtp.gmail.com with ESMTPSA id j8-20020aa78dc8000000b0062dba4e4706sm10131762pfr.191.2023.04.11.10.44.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 10:44:42 -0700 (PDT)
Message-ID: <f2501db5-d450-e04e-3fa6-63b5e35c55ce@acm.org>
Date:   Tue, 11 Apr 2023 10:44:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 02/16] blk-mq: move more logic into blk_mq_insert_requests
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <20230411133329.554624-1-hch@lst.de>
 <20230411133329.554624-3-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230411133329.554624-3-hch@lst.de>
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
> Move all logic related to the direct insert into blk_mq_insert_requests
> to clean the code flow up a bit, and to allow marking
> blk_mq_try_issue_list_directly static.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
