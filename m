Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00132D37E6
	for <lists+linux-block@lfdr.de>; Fri, 11 Oct 2019 05:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfJKDe1 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 10 Oct 2019 23:34:27 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35169 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfJKDe0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Oct 2019 23:34:26 -0400
Received: by mail-pg1-f195.google.com with SMTP id p30so4959834pgl.2
        for <linux-block@vger.kernel.org>; Thu, 10 Oct 2019 20:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FCEx2rep6SSwb9uqOObCKvNr66GAHYmED/+8v214jmY=;
        b=PlcKksLXjvONNmpg4Y+UyevV18/mjEorNYRdKxThFdvUiOprOJcj++l8FEF2lx2U+/
         TA8Q5S639AsF3DoldgPwYI/j2E+BTFNfpEfEp4IXywshug8uNxpOLdwPnKZsQ4RwiZt8
         oRuVaQJ8I6X5wBXk1IBpdxnCy4tCbMY8AFk6TGUtE7nJagMAJUmks1BW8ccgJrUlSqXE
         27r3xp4qMYxNJyjiiwNjCnx1QIPR7dbPml3d4Fc6dQsJLvwnU0u51s7ejzYo0Y6t45Es
         L3u7YSb1alaI4NpkWdxx3ANXzv0mlTocn8fCfSXdREGIA5fwDvcY6/7lem7p28+tdbG/
         fD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FCEx2rep6SSwb9uqOObCKvNr66GAHYmED/+8v214jmY=;
        b=oYuyyA9X5SPzsUqGv81Q6J1YUYQ5GrjVnN4Q1waMyFRDymvkuN0Muzwq+r2z7fLsEl
         DygRLi6tnsqdOFhVqQ3Whd2On0ZvNnxoSdDH8Ut1EOhx9jP8/vIMT5LMKPsfH3joY7Ny
         RDvLxEPGohLHKcWLO1FJc2BQE6TKh4nuF7NO5xPAsJLmQT+KUktNeaaoxqm5foPPsIPv
         lNqoyskLTQK+DU+vTsTHpIaPyLlmOltXtd+6ADpkQzZ8pHi4+9Y9MvYCMkJP+pSJ/JR5
         zoLEH1p3MU9c5gvIinB501bP2/cIIQ1kMIcRsvN76FOgEl3oZd3VRcgMDsXl1KvXrAdT
         0qtw==
X-Gm-Message-State: APjAAAX/XIJ2Jw5BD1gx9dwE0xXu/E0+PW3oqhTVpPRT1+f+COIeuxN5
        8x/qzKS81iSZQ9y+TGKWKsquRdVycWJ0dg==
X-Google-Smtp-Source: APXvYqyzgi7JA16c1dE8TIx96f+TAxQeBeCl+0UK9JT1UGIrM/C2nzCSzmEfvGILETwYSuDNeBsxXw==
X-Received: by 2002:a62:2581:: with SMTP id l123mr14356753pfl.197.1570764864840;
        Thu, 10 Oct 2019 20:34:24 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id cx22sm8184337pjb.19.2019.10.10.20.34.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 20:34:24 -0700 (PDT)
Subject: Re: [PATCH 1/2] io_uring: make the logic clearer for
 io_sequence_defer
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     yangerkun <yangerkun@huawei.com>, linux-block@vger.kernel.org
References: <20191009011959.2203-1-liuyun01@kylinos.cn>
 <7af32ce6-dc8f-6683-2b99-95eefb598bff@huawei.com>
 <597dc8a4-b9db-f0b7-21b5-12050f07e766@kernel.dk>
 <544E51DB-7774-4DDF-A897-7A957AE2CDEB@kylinos.cn>
 <6e1c1450-4317-7acf-dfa0-40977de4b8ea@kernel.dk>
 <543C3771-8956-40C4-B477-6B0F2FF477F5@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ccdcd63c-e811-fbcb-3329-2e779e69fe76@kernel.dk>
Date:   Thu, 10 Oct 2019 21:34:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <543C3771-8956-40C4-B477-6B0F2FF477F5@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/10/19 9:27 PM, Jackie Liu wrote:
> 
> 
>> 2019年10月11日 11:17，Jens Axboe <axboe@kernel.dk> 写道：
>>
>> On 10/10/19 9:06 PM, Jackie Liu wrote:
>>>
>>>
>>>> 2019年10月11日 10:35，Jens Axboe <axboe@kernel.dk> 写道：
>>>>
>>>> On 10/10/19 8:24 PM, yangerkun wrote:
>>>>>
>>>>>
>>>>> On 2019/10/9 9:19, Jackie Liu wrote:
>>>>>> __io_get_deferred_req is used to get all defer lists, including defer_list
>>>>>> and timeout_list, but io_sequence_defer should be only cares about the sequence.
>>>>>>
>>>>>> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
>>>>>> ---
>>>>>>    fs/io_uring.c | 13 +++++--------
>>>>>>    1 file changed, 5 insertions(+), 8 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>>>>>> index 8a0381f1a43b..8ec2443eb019 100644
>>>>>> --- a/fs/io_uring.c
>>>>>> +++ b/fs/io_uring.c
>>>>>> @@ -418,9 +418,7 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
>>>>>>    static inline bool io_sequence_defer(struct io_ring_ctx *ctx,
>>>>>>    				     struct io_kiocb *req)
>>>>>>    {
>>>>>> -	/* timeout requests always honor sequence */
>>>>>> -	if (!(req->flags & REQ_F_TIMEOUT) &&
>>>>>> -	    (req->flags & (REQ_F_IO_DRAIN|REQ_F_IO_DRAINED)) != REQ_F_IO_DRAIN)
>>>>>> +	if ((req->flags & (REQ_F_IO_DRAIN|REQ_F_IO_DRAINED)) != REQ_F_IO_DRAIN)
>>>>>>    		return false;
>>>>>>
>>>>>>    	return req->sequence != ctx->cached_cq_tail + ctx->rings->sq_dropped;
>>>>>> @@ -435,12 +433,11 @@ static struct io_kiocb *__io_get_deferred_req(struct io_ring_ctx *ctx,
>>>>>>    		return NULL;
>>>>>>
>>>>>>    	req = list_first_entry(list, struct io_kiocb, list);
>>>>>> -	if (!io_sequence_defer(ctx, req)) {
>>>>>> -		list_del_init(&req->list);
>>>>>> -		return req;
>>>>>> -	}
>>>>>> +	if (!(req->flags & REQ_F_TIMEOUT) && io_sequence_defer(ctx, req))
>>>>>> +		return NULL;
>>>>> Hi,
>>>>>
>>>>> For timeout req, we should also compare the sequence to determine to
>>>>> return NULL or the req. But now we will return req directly. Actually,
>>>>> no need to compare req->flags with REQ_F_TIMEOUT.
>>>>
>>>> Yes, not sure how I missed this, the patch is broken as-is. I will kill
>>>> it, cleanup can be done differently.
>>>
>>> Sorry for miss it, I don't wanna change the logic, it's not my
>>> original meaning.
>>
>> No worries, mistakes happen.
>>
>>> Personal opinion, timeout list should not be mixed with defer_list,
>>> which makes the code more complicated and difficult to understand.
>>
>> Not sure why you feel they are mixed? They are in separate lists, but
>> they share using the sequence logic. In that respet they are really not
>> that different, the sequence will trigger either one of them. Either as
>> a timeout, or as a "can now be issued". Hence the code handling them is
>> both shared and identical.
> 
> I not sure, I think I need reread the code of timeout command.
> 
>>
>> I do agree that the check could be cleaner, which is probably how the
>> mistake in this patch happened in the first place.
>>
> 
> Yes, I agree with you. io_sequence_defer should be only cares about
> the sequence.  Thanks for point out this mistake.

How about something like this? More cleanly separates them to avoid
mixing flags. The regular defer code will honor the flags, the timeout
code will just bypass those.


diff --git a/fs/io_uring.c b/fs/io_uring.c
index c92cb09cc262..4a2bb81cb1f1 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -416,26 +416,29 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 	return ctx;
 }
 
+static inline bool __io_sequence_defer(struct io_ring_ctx *ctx,
+				       struct io_kiocb *req)
+{
+	return req->sequence != ctx->cached_cq_tail + ctx->rings->sq_dropped;
+}
+
 static inline bool io_sequence_defer(struct io_ring_ctx *ctx,
 				     struct io_kiocb *req)
 {
-	/* timeout requests always honor sequence */
-	if (!(req->flags & REQ_F_TIMEOUT) &&
-	    (req->flags & (REQ_F_IO_DRAIN|REQ_F_IO_DRAINED)) != REQ_F_IO_DRAIN)
+	if ((req->flags & (REQ_F_IO_DRAIN|REQ_F_IO_DRAINED)) != REQ_F_IO_DRAIN)
 		return false;
 
-	return req->sequence != ctx->cached_cq_tail + ctx->rings->sq_dropped;
+	return __io_sequence_defer(ctx, req);
 }
 
-static struct io_kiocb *__io_get_deferred_req(struct io_ring_ctx *ctx,
-					      struct list_head *list)
+static struct io_kiocb *io_get_deferred_req(struct io_ring_ctx *ctx)
 {
 	struct io_kiocb *req;
 
-	if (list_empty(list))
+	if (list_empty(&ctx->defer_list))
 		return NULL;
 
-	req = list_first_entry(list, struct io_kiocb, list);
+	req = list_first_entry(&ctx->defer_list, struct io_kiocb, list);
 	if (!io_sequence_defer(ctx, req)) {
 		list_del_init(&req->list);
 		return req;
@@ -444,14 +447,20 @@ static struct io_kiocb *__io_get_deferred_req(struct io_ring_ctx *ctx,
 	return NULL;
 }
 
-static struct io_kiocb *io_get_deferred_req(struct io_ring_ctx *ctx)
-{
-	return __io_get_deferred_req(ctx, &ctx->defer_list);
-}
-
 static struct io_kiocb *io_get_timeout_req(struct io_ring_ctx *ctx)
 {
-	return __io_get_deferred_req(ctx, &ctx->timeout_list);
+	struct io_kiocb *req;
+
+	if (list_empty(&ctx->timeout_list))
+		return NULL;
+
+	req = list_first_entry(&ctx->timeout_list, struct io_kiocb, list);
+	if (!__io_sequence_defer(ctx, req)) {
+		list_del_init(&req->list);
+		return req;
+	}
+
+	return NULL;
 }
 
 static void __io_commit_cqring(struct io_ring_ctx *ctx)

-- 
Jens Axboe

