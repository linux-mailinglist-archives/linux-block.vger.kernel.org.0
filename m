Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742DF1B4ACA
	for <lists+linux-block@lfdr.de>; Wed, 22 Apr 2020 18:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgDVQq0 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 22 Apr 2020 12:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgDVQqZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Apr 2020 12:46:25 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F78FC03C1AB
        for <linux-block@vger.kernel.org>; Wed, 22 Apr 2020 09:46:25 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id q10so2603216ile.0
        for <linux-block@vger.kernel.org>; Wed, 22 Apr 2020 09:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1cV4OuPmkRZ6+zxhfjx8VUKHzAPPELWDKUnr+i1Zl2E=;
        b=vxrw4X12UbXuE8+hKgIRfqbehXZCbT3g1S5XxQ+LVjc5pBkTlst1hlpCAKpWhhZuRu
         veFMvmN+TdYJoobKQlAcPw6JABkRX/KE0oY7sokc0O3Ubt/H9HZmiPyMcH7mA95pj6Mv
         hsbcYkcLl9TIpZJkeOuziDN9U6KahUNlKAIvHBxipbOf4/3GY6HNpcM5h/0atEYHfS1J
         5TnA8z0aXlRNGp/PDhj068qQJeSm366/rYglsOfDgkjlAbyg23I3BhZcaQGv49KdWiYT
         nagOCmHMaULGJBLasMsxEUo6OJAP6KBFFCvGx1AX1CdYZDUtp8pnaisywCFpPZkRJfya
         i9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1cV4OuPmkRZ6+zxhfjx8VUKHzAPPELWDKUnr+i1Zl2E=;
        b=reZnIYS1TRawPMTTs9JgJzPAvJCyFJ04mT840ByiWxSjm+wc7K5L3GazhY41kvugTE
         Spi8w5xGchy6xmv7tuw8cKJHDpBH3+wwg/4mBNRdyrq8bjIl3Ry6ny9vq8uPfefbjhPd
         gxAcVVE/7RD2U1RbxzFUDIwu3SsM2OpC0SnjafJ+A4ER1GQxNdIrDBfpczhAbdS6r9zx
         NoRdimEgjOAq7tVzloy5eQxEskT+N3OEZC/U/3jgru5PleLRNrvmWRhpfo7sPpVibknJ
         lNCB3f9nWC1p1TxQsx+/1UwwW8Z9cUrJzbbdkCzSzpipZdMbbAssrUyjROM/bgjk1Do6
         MQ0w==
X-Gm-Message-State: AGi0PuYZB0X9UyMwGcDEPgFDXKovUAgP5CvHZwIjxD2wthEaPiHI1yel
        1rEdbO6MgBCeJiJ52CN6V7rvUkjMxc/c/w==
X-Google-Smtp-Source: APiQypIBWtVOQSTuiObuI0NSKLZhoSwUm3Bnp61Fd89wZTmPr1Njs/VncynYhJfgmsOlad6tANPNUA==
X-Received: by 2002:a92:cece:: with SMTP id z14mr26155375ilq.147.1587573983733;
        Wed, 22 Apr 2020 09:46:23 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c18sm2251436ilr.37.2020.04.22.09.46.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2020 09:46:23 -0700 (PDT)
Subject: Re: clean up DMA draining
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20200414074225.332324-1-hch@lst.de>
 <20200422064151.GA23271@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f969685b-6547-2e93-f288-d2b1d5ec4dc4@kernel.dk>
Date:   Wed, 22 Apr 2020 10:46:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200422064151.GA23271@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/22/20 12:41 AM, Christoph Hellwig wrote:
> On Tue, Apr 14, 2020 at 09:42:20AM +0200, Christoph Hellwig wrote:
>> Hi all,
>>
>> currently the dma draining and alignining specific to ATA CDROMs
>> and the UFS driver has its ugly hooks in core block code.  Move
>> this out into the scsi and ide drivers instead.
> 
> Any commens?

Looks OK to me, and I think the idea is sound.


-- 
Jens Axboe

