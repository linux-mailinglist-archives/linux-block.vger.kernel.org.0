Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB16FE8B86
	for <lists+linux-block@lfdr.de>; Tue, 29 Oct 2019 16:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389890AbfJ2PLu (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 29 Oct 2019 11:11:50 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45511 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389819AbfJ2PLt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Oct 2019 11:11:49 -0400
Received: by mail-io1-f68.google.com with SMTP id s17so8025222iol.12
        for <linux-block@vger.kernel.org>; Tue, 29 Oct 2019 08:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4YnjIYB79xoPchtokdcH2f/f3xnIpmJqjbutIlZJijM=;
        b=EyylrsDiBy9pvOSEDSXvFIlbB19kXS7Ed3PmwJjln74inw56j1lqj+hDpY1afL7x3p
         PNvY0iXYkLjOrWXVzaHFf9qGJlh0mYId+izkwGsF9kzIGWA12LlWOec4GxKjTbelwPnt
         l6a27RsQEP4XPKzvHAkD4dyqtlT0H1FTNx2xoWqM2ONk6PThOdyVBUqqurNDASZHX5QV
         vu5lWyg1cowUyH1emufjsz0h2oDTmyXGaHeV/6HorXhuYavJclMPXt/CoaPXXehe2Vhk
         L64ECadWJx5wANdqTYf1azGK+4hysVMFqr6nGIteKyc05N1XtVgnCLgYVwdbU26XHl8H
         /LlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4YnjIYB79xoPchtokdcH2f/f3xnIpmJqjbutIlZJijM=;
        b=kZUTHeQLR8wIR2cVa6bXN6y3TYBsyo/ytBRWiLSM5MO8AckZOFVt+9/4Gq4vCDbnXW
         c7z+WYNihUEbBC4wS3m+St6Nk4pOSu2QmyWR1W60uGTQ34JQRbjR3RjOeluNYUNhjtZl
         vscvCi6PR1Cu3/KRycWbqy7LIBS4/4Z8gHKInnwsf9s5uNzAT1xYtC0EngfpU0OYW7RF
         PZaOFD+vxnxmxf3uhrPWWmrTnheMhSX2cICAJhVHh9jRi6mjnwv5I0fKhYzYv/Pcv8Xq
         nlo3L8+MYusEvKv8mClAuslY8Aq2CwiCNFiSpL7WU8SDxtCQRRM28O7dWMXjkFxmjxrP
         KpYw==
X-Gm-Message-State: APjAAAWaL4udKI8HFClhxcRRcfwJmy3aoHpTlSoySjBwWvcO+NF/3aNn
        wT46lL5t+JhBXwCAMiCdnsjMDg==
X-Google-Smtp-Source: APXvYqzHF5+e1CumZA7cvobKZo+j0CjsLqjgjgUwfpicOokwoBr3mhOQIFVr8EPeYpyEakucBx/WbQ==
X-Received: by 2002:a02:6508:: with SMTP id u8mr24094985jab.28.1572361908903;
        Tue, 29 Oct 2019 08:11:48 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c11sm484096ioi.85.2019.10.29.08.11.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 08:11:47 -0700 (PDT)
Subject: Re: [PATCH V3] block: optimize for small block size IO
To:     Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>,
        Keith Busch <kbusch@kernel.org>, linux-bcache@vger.kernel.org
References: <20191029105125.12928-1-ming.lei@redhat.com>
 <20191029110425.GA4382@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cb19bfd1-a751-3f2b-a9fb-c6bd1c562648@kernel.dk>
Date:   Tue, 29 Oct 2019 09:11:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191029110425.GA4382@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/29/19 5:04 AM, Christoph Hellwig wrote:
> I still haven't seen an explanation why this simple thing doesn't work
> just as well:
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 48e6725b32ee..f3073700166f 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -309,6 +309,11 @@ void __blk_queue_split(struct request_queue *q, struct bio **bio,
>   				nr_segs);
>   		break;
>   	default:
> +		if ((*bio)->bi_vcnt == 1 &&
> +		    (*bio)->bi_io_vec[0].bv_len <= PAGE_SIZE) {
> +			*nr_segs = 1;
> +			return;
> +		}
>   		split = blk_bio_segment_split(q, *bio, &q->bio_split, nr_segs);
>   		break;
>   	}

I used that as a hack months ago for testing, but never ran it full through
testing.

As a reference, either one of these bumps my poll performance by 3% on a
fast device that's core limited.

-- 
Jens Axboe

