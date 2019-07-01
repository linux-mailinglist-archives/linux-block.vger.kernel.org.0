Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F82C49EF3
	for <lists+linux-block@lfdr.de>; Tue, 18 Jun 2019 13:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbfFRLJ3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 18 Jun 2019 07:09:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:41364 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729458AbfFRLJ3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Jun 2019 07:09:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 219F8AF84;
        Tue, 18 Jun 2019 11:09:27 +0000 (UTC)
Subject: Re: [PATCH 1/2] block: improve print_req_error
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     "hch@lst.de" <hch@lst.de>, "hare@suse.com" <hare@suse.com>
References: <20190611200210.4819-1-chaitanya.kulkarni@wdc.com>
 <20190611200210.4819-2-chaitanya.kulkarni@wdc.com>
 <321f98fe-eb76-cdcb-5917-32d27f12d3d6@suse.de>
 <BYAPR04MB5749F0648B6E2390E5436AE086EB0@BYAPR04MB5749.namprd04.prod.outlook.com>
From:   Hannes Reinecke <hare@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=hare@suse.de; prefer-encrypt=mutual; keydata=
 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
 azzYF4VRJsdl+d0MCaSy8mUh
Message-ID: <ad48cc31-5cac-6109-92a0-d141689a8e85@suse.de>
Date:   Tue, 18 Jun 2019 13:09:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB5749F0648B6E2390E5436AE086EB0@BYAPR04MB5749.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/17/19 6:49 PM, Chaitanya Kulkarni wrote:
> On 06/17/2019 01:43 AM, Hannes Reinecke wrote:
>> On 6/11/19 10:02 PM, Chaitanya Kulkarni wrote:
>>> From: Christoph Hellwig <hch@lst.de>
>>>
>>> Print the calling function instead of print_req_error as a prefix, and
>>> print the operation and op_flags separately instead of the whole field.
>>>
>>> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
>>> ---
>>>   block/blk-core.c | 16 +++++++++-------
>>>   1 file changed, 9 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/block/blk-core.c b/block/blk-core.c
>>> index ee1b35fe8572..d1a227cfb72e 100644
>>> --- a/block/blk-core.c
>>> +++ b/block/blk-core.c
>>> @@ -167,18 +167,20 @@ int blk_status_to_errno(blk_status_t status)
>>>   }
>>>   EXPORT_SYMBOL_GPL(blk_status_to_errno);
>>>
>>> -static void print_req_error(struct request *req, blk_status_t status)
>>> +static void print_req_error(struct request *req, blk_status_t status,
>>> +		const char *caller)
>>>   {
>>>   	int idx = (__force int)status;
>>>
>>>   	if (WARN_ON_ONCE(idx >= ARRAY_SIZE(blk_errors)))
>>>   		return;
>>>
>>> -	printk_ratelimited(KERN_ERR "%s: %s error, dev %s, sector %llu flags %x\n",
>>> -				__func__, blk_errors[idx].name,
>>> -				req->rq_disk ?  req->rq_disk->disk_name : "?",
>>> -				(unsigned long long)blk_rq_pos(req),
>>> -				req->cmd_flags);
>>> +	printk_ratelimited(KERN_ERR
>>> +		"%s: %s error, dev %s, sector %llu op 0x%x flags 0x%x\n",
>>> +		caller, blk_errors[idx].name,
>>> +		req->rq_disk ?  req->rq_disk->disk_name : "?",
>>> +		blk_rq_pos(req), req_op(req),
>>> +		req->cmd_flags & ~REQ_OP_MASK);
>>>   }
>>>
>>>   static void req_bio_endio(struct request *rq, struct bio *bio,
>>> @@ -1360,7 +1362,7 @@ bool blk_update_request(struct request *req, blk_status_t error,
>>>
>>>   	if (unlikely(error && !blk_rq_is_passthrough(req) &&
>>>   		     !(req->rq_flags & RQF_QUIET)))
>>> -		print_req_error(req, error);
>>> +		print_req_error(req, error, __func__);
>>>
>>>   	blk_account_io_completion(req, nr_bytes);
>>>
>>>
>> I did ask this already, but didn't get an answer:
>> Why do we have the __func__ argument?
>> Can it print anything else than 'blk_update_request' ?
>> If so, can't it be dropped?
> Thanks for looking into this. The caller argument I think is useful for 
> future use if this function gets called from different places.
> 
> Are you okay with that ?
> 
Yes, I am.

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
