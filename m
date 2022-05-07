Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F2651E3EE
	for <lists+linux-block@lfdr.de>; Sat,  7 May 2022 06:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355747AbiEGEYL (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 7 May 2022 00:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445506AbiEGEYI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 7 May 2022 00:24:08 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903C7C5D
        for <linux-block@vger.kernel.org>; Fri,  6 May 2022 21:20:22 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VCUzE6g_1651897218;
Received: from 30.30.104.151(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VCUzE6g_1651897218)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 07 May 2022 12:20:19 +0800
Message-ID: <8a52ed85-3ffa-44a4-3e28-e13cdc793732@linux.alibaba.com>
Date:   Sat, 7 May 2022 12:20:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: Follow up on UBD discussion
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        joseph.qi@linux.alibaba.com, linux-block@vger.kernel.org
References: <874k27rfwm.fsf@collabora.com> <YnDhorlKgOKiWkiz@T590>
From:   ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <YnDhorlKgOKiWkiz@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/5/3 16:02, Ming Lei wrote:
> Hello Gabriel,
> 
> CC linux-block and hope you don't mind, :-)
> 
> On Mon, May 02, 2022 at 01:41:13PM -0400, Gabriel Krisman Bertazi wrote:
>>
>> Hi Ming,
>>
>> First of all, I hope I didn't put you on the spot too much during the
>> discussion.  My original proposal was to propose my design, but your
>> implementation quite solved the questions I had. :)
> 
> I think that is open source, then we can put efforts together to make things
> better.
> 
>>
>> I'd like to follow up to restart the communication and see
>> where I can help more with UBD.  As I said during the talk, I've
>> done some fio runs and I was able to saturate NBD much faster than UBD:
>>
>> https://people.collabora.com/~krisman/mingl-ubd/bw.png
> 
> Yeah, that is true since NBD has extra socket communication cost which
> can't be efficient as io_uring.
> 
>>
>> I've also wrote some fixes to the initialization path, which I
>> planned to send to you as soon as you published your code, but I think
>> you might want to take a look already and see if you want to just squash
>> it into your code base.
>>
>> I pushed those fixes here:
>>
>>   https://gitlab.collabora.com/krisman/linux/-/tree/mingl-ubd
> 
> I have added the 1st fix and 3rd patch into my tree:
> 
> https://github.com/ming1/linux/commits/v5.17-ubd-dev
> 
> The added check in 2nd patch is done lockless, which may not be reliable
> enough, so I didn't add it. Also adding device is in slow path, and no
> necessary to improve in that code path.
> 
> I also cleaned up ubd driver a bit: debug code cleanup, remove zero copy
> code, remove command of UBD_IO_GET_DATA and always make ubd driver
> builtin.
> 
> ubdsrv part has been cleaned up too:
> 
> https://github.com/ming1/ubdsrv
> 
>>
>> I'm looking into adding support for multiple driver queues next, and
>> should be able to share some patches on that shortly.
> 
> OK, please post them on linux-block so that more eyes can look at the
> code, meantime the ubdsrv side needs to handle MQ too.
> 
> Sooner or later, the single ubdsrv task may be saturated by copying data and
> io_uring command communication only, which can be shown by running io on
> ubd-null target. In my lattop, the ubdsrv cpu utilization is close to
> 90% when IOPS is > 500K. So MQ may help some fast backing cases.
> 
> 
> Thanks,
> Ming

Hi Ming,

Now I am learning your userspace block driver(UBD) [1][2] and we plan to
replace TCMU by UBD as a new choice for implementing userspace bdev for
its high performance and simplicity.

First, we have conducted some tests by fio and perf to evaluate UBD.

1) UBD achieves higher throughput than TCMU. We think TCMU suffers from
     the complicated SCSI layer and does not support multiqueue. However
UBD is simply using io_uring passthrough and may support multiqueue in
the future.(Note that even with a single queue now , UBD outperforms TCMU)

2) Some functions in UBD result in high CPU utilization and we guess
they also lower throughput. For example, ubdsrv_submit_fetch_commands()
frequently iterates on the array of UBD IOs and wastes CPU when no IO is
ready to be submitted. Besides,  ubd_copy_pages() asks CPU to copy data
between bio vectors and UBD internal buffers while handling write and
read requests and it could be eliminated by supporting zero-copy.

Second, I'd like to share some ideas on UBD. I'm not sure if they are
reasonable so please figure out my mistakes.

1) UBD issues one sqe to commit last completed request and fetch a new
one. Then, blk-mq's queue_rq() issues a new UBD IO request and completes
one cqe for the fetch command. We have evaluated that io_submit_sqes()
costs some CPU and steps of building a new sqe may lower throughput.
Here I'd like to give a new solution: never submit sqe but trump up a
cqe(with information of new UBD IO request) when calling queue_rq(). I
am inspired by one io_uring flag: IORING_POLL_ADD_MULTI, with which a
user issues only one sqe for polling an fd and repeatedly gets multiple
cqes when new events occur. Dose this solution break the architecture of
UBD?

2) UBDSRV(the userspace part) should not allocate data buffers itself.
When an application configs many queues with bigger iodepth, UBDSRV has
to preallocate more buffers(size = 256KiB) and results in heavy memory
overhead. I think data buffers should be allocated by applications
themselves and passed to UBDSRV. In this way UBD offers more
flexibility. However, while handling a write request, the control flow
returns to the kernel part again to set buf addr and copy data from bio
vectors. Is ioctl helpful by setting buf addr and copying write data to
app buf?

3) ubd_fetch_and_submit() frequently iterates on the array of ubd IOs
and wastes CPU when no IO is ready to be submitted. I think it can be
optimized by adding a new array storing UBD IOs that are ready to be
commit back to the kernel part. Then we could batch these IOs and avoid
unnecessary iterations on IOs which are not ready(fetching or handling
by targets).

4) Zero-copy support is important and we are trying to implement it now.

5) Currently, UBD only support the loop target with io_uirng and all
works(1.get one cqe 2.issue target io_uring IO 3.get target io_uring IO
completion 4.prepare one sqe) are done in one thread. As far as I know,
 some applications such as SPDK, network fs and customized distribution
systems do not support io_uring well.  I think we should separate target
IO handling from the UBDSRV loop and allow applications handle target
IOs themselves. Is this suggestion reasonable? (Or UBD should focus on
io_uring-supported targets?)

Regards,
Zhang

[1] https://github.com/ming1/ubdsrv
[2]https://github.com/ming1/linux/commits/v5.17-ubd-dev
