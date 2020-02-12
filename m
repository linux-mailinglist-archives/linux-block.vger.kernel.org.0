Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 012C115B179
	for <lists+linux-block@lfdr.de>; Wed, 12 Feb 2020 21:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgBLUA4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 12 Feb 2020 15:00:56 -0500
Received: from relay.sw.ru ([185.231.240.75]:47826 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728098AbgBLUA4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Feb 2020 15:00:56 -0500
Received: from [192.168.15.120]
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1j1yBE-0007nX-2q; Wed, 12 Feb 2020 23:00:16 +0300
Subject: Re: [PATCH v6 6/6] loop: Add support for REQ_ALLOCATE
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     martin.petersen@oracle.com, bob.liu@oracle.com, axboe@kernel.dk,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        song@kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        Chaitanya.Kulkarni@wdc.com, ming.lei@redhat.com, osandov@fb.com,
        jthumshirn@suse.de, minwoo.im.dev@gmail.com, damien.lemoal@wdc.com,
        andrea.parri@amarulasolutions.com, hare@suse.com, tj@kernel.org,
        ajay.joshi@wdc.com, sagi@grimberg.me, dsterba@suse.com,
        bvanassche@acm.org, dhowells@redhat.com, asml.silence@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <158132703141.239613.3550455492676290009.stgit@localhost.localdomain>
 <158132724397.239613.16927024926439560344.stgit@localhost.localdomain>
 <20200212170156.GM6874@magnolia>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <f108e700-62fb-6ecd-2bba-0ab7a6b9ef7b@virtuozzo.com>
Date:   Wed, 12 Feb 2020 23:00:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200212170156.GM6874@magnolia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12.02.2020 20:01, Darrick J. Wong wrote:
> On Mon, Feb 10, 2020 at 12:34:04PM +0300, Kirill Tkhai wrote:
>> Support for new modifier of REQ_OP_WRITE_ZEROES command.
>> This results in allocation extents in backing file instead
>> of actual blocks zeroing.
>>
>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>> Reviewed-by: Bob Liu <bob.liu@oracle.com>
>> ---
>>  drivers/block/loop.c |   15 ++++++++++++---
>>  1 file changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
>> index 739b372a5112..bfe76d9adf09 100644
>> --- a/drivers/block/loop.c
>> +++ b/drivers/block/loop.c
>> @@ -581,6 +581,15 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
>>  	return 0;
>>  }
>>  
>> +static unsigned int write_zeroes_to_fallocate_mode(unsigned int flags)
>> +{
>> +	if (flags & REQ_ALLOCATE)
>> +		return 0;
>> +	if (flags & REQ_NOUNMAP)
>> +		return FALLOC_FL_ZERO_RANGE;
>> +	return FALLOC_FL_PUNCH_HOLE;
>> +}
>> +
>>  static int do_req_filebacked(struct loop_device *lo, struct request *rq)
>>  {
>>  	struct loop_cmd *cmd = blk_mq_rq_to_pdu(rq);
>> @@ -604,9 +613,7 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
>>  		 * write zeroes the range.  Otherwise, punch them out.
>>  		 */
> 
> Please update this comment to reflect the new REQ_ALLOCATE mode, and
> move it to where you define write_zeroes_to_fallocate_mode().
> 
> With that fixed,
> 
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

Just to clarify. Is this "Reviewed-by:" tag for this patch or for the whole series?

Kirill
