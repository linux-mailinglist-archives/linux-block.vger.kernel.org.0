Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB91407303
	for <lists+linux-block@lfdr.de>; Fri, 10 Sep 2021 23:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbhIJVm4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 10 Sep 2021 17:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhIJVm4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Sep 2021 17:42:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990B3C061574;
        Fri, 10 Sep 2021 14:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=leZ9gAJesxiaYyECvXAC95tfjrMi+xyfNBHPusNmXhc=; b=jOxNEkflIY8q+uoW+nXRu9FQ7U
        nFWTvXtl1dJ9Pdrc9LEPeJMj6UZYxV45Kbrks3XU1zNWuNHv7P/xx3oeYZ5zY0wPTPNZm8YiNSbKJ
        /I/GJbGoeqCrx83c/VDLP24V7Wy9FePPlXS4m4OP8fOma/KSJ9QB9Hd5bpc1cPbw2zEDp25wMk66X
        pWz6S+8VNX+Mv6ePijXJdLrwWLLnj/jzSXs8gP5kG/k/4HSmFmY08LNzNIWtTKAiCGeLYH7077uX8
        PdaX1OJM0a/1qAxKBUkSIjZyAsN2m3eOTA3c/rSQyjB4vNt2zLcj9/gjYCNOuIdF/9wS2gSs+DvBq
        e/wW9kow==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOoHH-00DtxH-El; Fri, 10 Sep 2021 21:41:43 +0000
Subject: Re: [PATCH v3] drivers/cdrom: improved ioctl for media change
 detection
To:     Lukas Prediger <lumip@lumip.de>, phil@philpotter.co.uk
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, hch@infradead.org
References: <20210910211600.5663-1-lumip@lumip.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e3efb5ea-0884-c02a-cb81-408ec421463d@infradead.org>
Date:   Fri, 10 Sep 2021 14:41:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210910211600.5663-1-lumip@lumip.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Lukas,

Just a minor nit:

On 9/10/21 2:16 PM, Lukas Prediger wrote:
> +#define MEDIA_CHANGED_FLAG	0x1	/* Last detected media change was more \
> +					 * recent than last_media_change set by\
> +					 * caller.                             \
> +					 */

Drop the "continuation" backslashes.
They are not needed.

thanks.
-- 
~Randy

