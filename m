Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8917D37F3
	for <lists+linux-block@lfdr.de>; Fri, 11 Oct 2019 05:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbfJKDnt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-block@lfdr.de>); Thu, 10 Oct 2019 23:43:49 -0400
Received: from smtpbguseast1.qq.com ([54.204.34.129]:37312 "EHLO
        smtpbguseast1.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfJKDnt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Oct 2019 23:43:49 -0400
X-Greylist: delayed 2220 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Oct 2019 23:43:48 EDT
X-QQ-mid: bizesmtp17t1570765421t3fm104x
Received: from [172.20.0.236] (unknown [218.76.23.26])
        by esmtp6.qq.com (ESMTP) with 
        id ; Fri, 11 Oct 2019 11:43:40 +0800 (CST)
X-QQ-SSF: 00400000002000S0ZT90000A0000000
X-QQ-FEAT: 9nlJVcnIir7GemAxpdA4ETjjr2CqVF+pyTBhLkE43c3LMp93BhQmfByhHkf86
        9MGD6I2cZLxyhKi6RfXF4Ti7cFmGMUbYCfLh3ew/EoE6IM0dTU0N7tmXWQzp1SO3mHY80Aj
        vc+ybjr6COzKO88i8gVj1Mji3UrZf/wOfWNZT3hbT1fwYiUviqFVCgugCIQ/vA5Z4DHmJG0
        Gm/0TQgm/Lr6GENM0lWz2crq88vkPIDqVQQdA17+VBDOBie8bCO/D+Grv2jwgIcg/oNDymt
        hbVL8cdzLIV8pUDvd5kXb3UxGhhn4VUsq+27Dr2g5tBNBXj68KbG1FmcGKHecdxUIT+4ca+
        ZtMZPFXkVH7hzP0ukEb3xR63AKfhL/5dI3bzH2Y
X-QQ-GoodBg: 2
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.19\))
Subject: Re: [PATCH 1/2] io_uring: make the logic clearer for
 io_sequence_defer
From:   Jackie Liu <liuyun01@kylinos.cn>
In-Reply-To: <dc9a36c6-0427-212f-efc9-4658663498c7@kernel.dk>
Date:   Fri, 11 Oct 2019 11:43:40 +0800
Cc:     yangerkun <yangerkun@huawei.com>, linux-block@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <71C4794E-2B1F-4A29-93E9-D578E71DECED@kylinos.cn>
References: <20191009011959.2203-1-liuyun01@kylinos.cn>
 <7af32ce6-dc8f-6683-2b99-95eefb598bff@huawei.com>
 <597dc8a4-b9db-f0b7-21b5-12050f07e766@kernel.dk>
 <544E51DB-7774-4DDF-A897-7A957AE2CDEB@kylinos.cn>
 <6e1c1450-4317-7acf-dfa0-40977de4b8ea@kernel.dk>
 <543C3771-8956-40C4-B477-6B0F2FF477F5@kylinos.cn>
 <ccdcd63c-e811-fbcb-3329-2e779e69fe76@kernel.dk>
 <9C395F47-FE38-4E42-9DB0-3CCC427DE857@kylinos.cn>
 <dc9a36c6-0427-212f-efc9-4658663498c7@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3594.4.19)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> 2019年10月11日 11:42，Jens Axboe <axboe@kernel.dk> 写道：
> 
> On 10/10/19 9:41 PM, Jackie Liu wrote:
>> 
>> 
>>> 2019年10月11日 11:34，Jens Axboe <axboe@kernel.dk> 写道：
>>> 
>>> On 10/10/19 9:27 PM, Jackie Liu wrote:
>>>> 
>>>> 
>>>>> 2019年10月11日 11:17，Jens Axboe <axboe@kernel.dk> 写道：
>>>>> 
>>>>> On 10/10/19 9:06 PM, Jackie Liu wrote:
>>>>>> 
>>>>>> 
>>>>>>> 2019年10月11日 10:35，Jens Axboe <axboe@kernel.dk> 写道：
>>>>>>> 
>>>>>>> On 10/10/19 8:24 PM, yangerkun wrote:
>>>>>>>> 
>>>>>>>> 
>>>>>>>> On 2019/10/9 9:19, Jackie Liu wrote:
>>>>>>>>> __io_get_deferred_req is used to get all defer lists, including defer_list
>>>>>>>>> and timeout_list, but io_sequence_defer should be only cares about the sequence.
>>>>>>>>> 
>>>>>>>>> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
>>>>>>>>> ---
>>>>>>>>>   fs/io_uring.c | 13 +++++--------
>>>>>>>>>   1 file changed, 5 insertions(+), 8 deletions(-)
>>>>>>>>> 
>>>>>>>>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>>>>>>>>> index 8a0381f1a43b..8ec2443eb019 100644
>>>>>>>>> --- a/fs/io_uring.c
>>>>>>>>> +++ b/fs/io_uring.c
>>>>>>>>> @@ -418,9 +418,7 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
>>>>>>>>>   static inline bool io_sequence_defer(struct io_ring_ctx *ctx,
>>>>>>>>>   				     struct io_kiocb *req)
>>>>>>>>>   {
>>>>>>>>> -	/* timeout requests always honor sequence */
>>>>>>>>> -	if (!(req->flags & REQ_F_TIMEOUT) &&
>>>>>>>>> -	    (req->flags & (REQ_F_IO_DRAIN|REQ_F_IO_DRAINED)) != REQ_F_IO_DRAIN)
>>>>>>>>> +	if ((req->flags & (REQ_F_IO_DRAIN|REQ_F_IO_DRAINED)) != REQ_F_IO_DRAIN)
>>>>>>>>>   		return false;
>>>>>>>>> 
>>>>>>>>>   	return req->sequence != ctx->cached_cq_tail + ctx->rings->sq_dropped;
>>>>>>>>> @@ -435,12 +433,11 @@ static struct io_kiocb *__io_get_deferred_req(struct io_ring_ctx *ctx,
>>>>>>>>>   		return NULL;
>>>>>>>>> 
>>>>>>>>>   	req = list_first_entry(list, struct io_kiocb, list);
>>>>>>>>> -	if (!io_sequence_defer(ctx, req)) {
>>>>>>>>> -		list_del_init(&req->list);
>>>>>>>>> -		return req;
>>>>>>>>> -	}
>>>>>>>>> +	if (!(req->flags & REQ_F_TIMEOUT) && io_sequence_defer(ctx, req))
>>>>>>>>> +		return NULL;
>>>>>>>> Hi,
>>>>>>>> 
>>>>>>>> For timeout req, we should also compare the sequence to determine to
>>>>>>>> return NULL or the req. But now we will return req directly. Actually,
>>>>>>>> no need to compare req->flags with REQ_F_TIMEOUT.
>>>>>>> 
>>>>>>> Yes, not sure how I missed this, the patch is broken as-is. I will kill
>>>>>>> it, cleanup can be done differently.
>>>>>> 
>>>>>> Sorry for miss it, I don't wanna change the logic, it's not my
>>>>>> original meaning.
>>>>> 
>>>>> No worries, mistakes happen.
>>>>> 
>>>>>> Personal opinion, timeout list should not be mixed with defer_list,
>>>>>> which makes the code more complicated and difficult to understand.
>>>>> 
>>>>> Not sure why you feel they are mixed? They are in separate lists, but
>>>>> they share using the sequence logic. In that respet they are really not
>>>>> that different, the sequence will trigger either one of them. Either as
>>>>> a timeout, or as a "can now be issued". Hence the code handling them is
>>>>> both shared and identical.
>>>> 
>>>> I not sure, I think I need reread the code of timeout command.
>>>> 
>>>>> 
>>>>> I do agree that the check could be cleaner, which is probably how the
>>>>> mistake in this patch happened in the first place.
>>>>> 
>>>> 
>>>> Yes, I agree with you. io_sequence_defer should be only cares about
>>>> the sequence.  Thanks for point out this mistake.
>>> 
>>> How about something like this? More cleanly separates them to avoid
>>> mixing flags. The regular defer code will honor the flags, the timeout
>>> code will just bypass those.
>>> 
>>> 
>>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>>> index c92cb09cc262..4a2bb81cb1f1 100644
>>> --- a/fs/io_uring.c
>>> +++ b/fs/io_uring.c
>>> @@ -416,26 +416,29 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
>>> 	return ctx;
>>> }
>>> 
>>> +static inline bool __io_sequence_defer(struct io_ring_ctx *ctx,
>>> +				       struct io_kiocb *req)
>>> +{
>>> +	return req->sequence != ctx->cached_cq_tail + ctx->rings->sq_dropped;
>>> +}
>>> +
>>> static inline bool io_sequence_defer(struct io_ring_ctx *ctx,
>>> 				     struct io_kiocb *req)
>>> {
>>> -	/* timeout requests always honor sequence */
>>> -	if (!(req->flags & REQ_F_TIMEOUT) &&
>>> -	    (req->flags & (REQ_F_IO_DRAIN|REQ_F_IO_DRAINED)) != REQ_F_IO_DRAIN)
>>> +	if ((req->flags & (REQ_F_IO_DRAIN|REQ_F_IO_DRAINED)) != REQ_F_IO_DRAIN)
>>> 		return false;
>>> 
>>> -	return req->sequence != ctx->cached_cq_tail + ctx->rings->sq_dropped;
>>> +	return __io_sequence_defer(ctx, req);
>>> }
>>> 
>>> -static struct io_kiocb *__io_get_deferred_req(struct io_ring_ctx *ctx,
>>> -					      struct list_head *list)
>>> +static struct io_kiocb *io_get_deferred_req(struct io_ring_ctx *ctx)
>>> {
>>> 	struct io_kiocb *req;
>>> 
>>> -	if (list_empty(list))
>>> +	if (list_empty(&ctx->defer_list))
>>> 		return NULL;
>>> 
>>> -	req = list_first_entry(list, struct io_kiocb, list);
>>> +	req = list_first_entry(&ctx->defer_list, struct io_kiocb, list);
>>> 	if (!io_sequence_defer(ctx, req)) {
>>> 		list_del_init(&req->list);
>>> 		return req;
>>> @@ -444,14 +447,20 @@ static struct io_kiocb *__io_get_deferred_req(struct io_ring_ctx *ctx,
>>> 	return NULL;
>>> }
>>> 
>>> -static struct io_kiocb *io_get_deferred_req(struct io_ring_ctx *ctx)
>>> -{
>>> -	return __io_get_deferred_req(ctx, &ctx->defer_list);
>>> -}
>>> -
>>> static struct io_kiocb *io_get_timeout_req(struct io_ring_ctx *ctx)
>>> {
>>> -	return __io_get_deferred_req(ctx, &ctx->timeout_list);
>>> +	struct io_kiocb *req;
>>> +
>>> +	if (list_empty(&ctx->timeout_list))
>>> +		return NULL;
>>> +
>>> +	req = list_first_entry(&ctx->timeout_list, struct io_kiocb, list);
>>> +	if (!__io_sequence_defer(ctx, req)) {
>>> +		list_del_init(&req->list);
>>> +		return req;
>>> +	}
>>> +
>>> +	return NULL;
>>> }
>>> 
>>> static void __io_commit_cqring(struct io_ring_ctx *ctx)
>>> 
>> 
>> Much better, clearly and easy understand.
> 
> Agree, this is easier to read as well, and harder to inadvertently
> break. Can I add your reviewed-by to this one?
> 
> 

Yes, please, Reviewed-by: Jackie Liu <liuyun01@kylinos.cn>


--
BR, Jackie Liu



