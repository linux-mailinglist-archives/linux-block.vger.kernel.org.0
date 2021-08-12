Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE5B3EA9A1
	for <lists+linux-block@lfdr.de>; Thu, 12 Aug 2021 19:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhHLRm1 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 12 Aug 2021 13:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236425AbhHLRm0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Aug 2021 13:42:26 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD242C061756
        for <linux-block@vger.kernel.org>; Thu, 12 Aug 2021 10:42:00 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id n1-20020a9d1e810000b0290514da4485e4so5944409otn.4
        for <linux-block@vger.kernel.org>; Thu, 12 Aug 2021 10:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=60yfRd4sojuQKE6S/RBrSfNvNV6kIhsQPId8pEeVRSI=;
        b=P+ernqdhz2CakabaEpmgSKCUwXxfkA6+QDN8eNfNzfO2qClNod32xfqM5wPpNKlMgQ
         RzTu2NNN1Jhx8sZxn0F+kHgQ6V+uzCkN8IUMCTDw6HzESKNsRrRT7Wc2LBZ+sXLTf9qO
         xtPIVyjOisx1w8J7QJnZczR6RHbZaRYm4Y2ELdgVjITeZjlLWfLuyMSIyXMa1+f5dSrF
         nv90WAcYf6264xsuPhYrxAMaOAs9T7meIpKlFLtCjQFyPfLyvmNSU8w4YXazwK54j71I
         WtiSU6XfwmBmzTK6KjNUwP5gWWcByXkCaRM4S/svkUCtq8J5TIJ0Nz6jk8DoLlrBg7xB
         a5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=60yfRd4sojuQKE6S/RBrSfNvNV6kIhsQPId8pEeVRSI=;
        b=iH7eIRi8/Yc5fDrnHBKt5n+euL83KTA2GMCumvEh5PVZKyR3UOxDBSgQ1YOjVyc0pE
         ZpI+0wXr7LEFRgqjdLLgYeTP5rQoj5QyK6RwUPYPwPj+ptNqlaM5hHCdP1NSErOfyCEo
         L+niY7jVGJO115yspTbQuW9DzcAm2C9rzhnQ+LIc4jyN5WldRAl7kX44GsLCpudAtWoy
         u94VjoTNvQTG1VcczRK7xkEj4k4nk38jT1GfBYWKa1k7ufjNeKocyysxjw14U+3SwJ+/
         M1KddKtxroxcn9IFcfXg9Cg+cKVIabBveGMA4WyuVdRkIZL5H+2yDTdYfXyxt0JSGFhG
         MvUw==
X-Gm-Message-State: AOAM532AwkXuL90IjwuwXXwlUIcKcz2uAYYZsoD8mcLIVcN4wBGxBbOf
        s1pxpqcNosWu6Xn1Sj/jGMd/1A==
X-Google-Smtp-Source: ABdhPJyhCw+WpGEcKPi/OlyJ998SVh3UuqAGLj+cV5FGggfsb+fsvyMAatfgkc4AzYFCxAkckt651A==
X-Received: by 2002:a05:6830:4429:: with SMTP id q41mr4451581otv.284.1628790120124;
        Thu, 12 Aug 2021 10:42:00 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id p8sm778918otk.22.2021.08.12.10.41.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 10:41:59 -0700 (PDT)
Subject: Re: [PATCH 4/6] block: clear BIO_PERCPU_CACHE flag if polling isn't
 supported
To:     Keith Busch <kbusch@kernel.org>
Cc:     io-uring@vger.kernel.org, linux-block@vger.kernel.org,
        hch@infradead.org
References: <20210812154149.1061502-1-axboe@kernel.dk>
 <20210812154149.1061502-5-axboe@kernel.dk>
 <20210812173143.GA3138953@dhcp-10-100-145-180.wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b60e0031-77b0-fe27-2b52-437ba21babcb@kernel.dk>
Date:   Thu, 12 Aug 2021 11:41:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210812173143.GA3138953@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/12/21 11:31 AM, Keith Busch wrote:
> On Thu, Aug 12, 2021 at 09:41:47AM -0600, Jens Axboe wrote:
>> -	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
>> +	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags)) {
>> +		/* can't support alloc cache if we turn off polling */
>> +		bio_clear_flag(bio, BIO_PERCPU_CACHE);
>>  		bio->bi_opf &= ~REQ_HIPRI;
>> +	}
> 
> It looks like you should also clear BIO_PERCPU_CACHE if this bio gets
> split in blk_bio_segment_split().

Indeed. Wonder if we should make that a small helper, as any clear of
REQ_HIPRI should clear BIO_PERCPU_CACHE as well.


diff --git a/block/blk-core.c b/block/blk-core.c
index 7e852242f4cc..d2722ecd4d9b 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -821,11 +821,8 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
 		}
 	}
 
-	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags)) {
-		/* can't support alloc cache if we turn off polling */
-		bio_clear_flag(bio, BIO_PERCPU_CACHE);
-		bio->bi_opf &= ~REQ_HIPRI;
-	}
+	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
+		bio_clear_hipri(bio);
 
 	switch (bio_op(bio)) {
 	case REQ_OP_DISCARD:
diff --git a/block/blk-merge.c b/block/blk-merge.c
index f8707ff7e2fc..985ca1116c32 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -285,7 +285,7 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 	 * iopoll in direct IO routine. Given performance gain of iopoll for
 	 * big IO can be trival, disable iopoll when split needed.
 	 */
-	bio->bi_opf &= ~REQ_HIPRI;
+	bio_clear_hipri(bio);
 
 	return bio_split(bio, sectors, GFP_NOIO, bs);
 }
diff --git a/block/blk.h b/block/blk.h
index db6f82bbb683..7dba254b45f2 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -367,4 +367,11 @@ extern struct device_attribute dev_attr_events;
 extern struct device_attribute dev_attr_events_async;
 extern struct device_attribute dev_attr_events_poll_msecs;
 
+static inline void bio_clear_hipri(struct bio *bio)
+{
+	/* can't support alloc cache if we turn off polling */
+	bio_clear_flag(bio, BIO_PERCPU_CACHE);
+	bio->bi_opf &= ~REQ_HIPRI;
+}
+
 #endif /* BLK_INTERNAL_H */

-- 
Jens Axboe

