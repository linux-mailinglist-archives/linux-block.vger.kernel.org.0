Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF7C5A41A7
	for <lists+linux-block@lfdr.de>; Mon, 29 Aug 2022 06:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiH2EBA (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 29 Aug 2022 00:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiH2EAy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Aug 2022 00:00:54 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4CD1A832;
        Sun, 28 Aug 2022 21:00:52 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VNW3uM1_1661745649;
Received: from 30.97.56.171(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VNW3uM1_1661745649)
          by smtp.aliyun-inc.com;
          Mon, 29 Aug 2022 12:00:50 +0800
Message-ID: <2c5def30-7116-7a0d-860d-74e1d36a91c6@linux.alibaba.com>
Date:   Mon, 29 Aug 2022 12:00:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [RFC PATCH 0/9] ublk_drv: add USER_RECOVERY support
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com
References: <20220824054744.77812-1-ZiyangZhang@linux.alibaba.com>
 <Ywwfi7Dgi0JC2kQ/@T590>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <Ywwfi7Dgi0JC2kQ/@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/8/29 10:08, Ming Lei wrote:
> On Wed, Aug 24, 2022 at 01:47:35PM +0800, ZiyangZhang wrote:
>> ublk_drv is a driver simply passes all blk-mq rqs to ublksrv[1] in
>> userspace. For each ublk queue, there is one ubq_daemon(pthread).
>> All ubq_daemons share the same process which opens /dev/ublkcX.
>> The ubq_daemon code infinitely loops on io_uring_enter() to
>> send/receive io_uring cmds which pass information of blk-mq
>> rqs.
>>
>> Now, if one ubq_daemon(pthread) or the process crashes, ublk_drv
>> must abort the dying ubq, stop the device and release everything.
>> This is not a good choice in practice because users do not expect
>> aborted requests, I/O errors and a released device. They may want
>> a recovery machenism so that no requests are aborted and no I/O
>> error occurs. Anyway, users just want everything works as uaual.
> 
> I understand the requirement is that both /dev/ublkbN and /dev/ublkcN
> won't be deleted & re-added from user viewpoint after user recovery,
> so the device context won't be lost.

Yes, after the 'process' is killed or crashed(such as segmentation fault)
both /dev/ublkb0 and /dev/ublkc0 is not deleted.

> 
>>
>> This RFC patchset implements USER_RECOVERY support. If the process
>> crashes, we allow ublksrv to provide new process and ubq_daemons.
>> We do not support single ubq_daemon(pthread) recovery because a
>> pthread rarely crashes.
>>
>> Recovery feature is quite useful for products do not expect to
>> return any I/O error to frontend users.
> 
> That looks one very ideal requirement. To be honest, no any block driver
> can guarantee that 100%, so it is just one soft requirement?
> 
> Cause memory allocation may fail, network may be disconnected,
> re-creating pthread or process may fail too, ...

Yes, I know there are many other problem which may cause a failure.

The recovery mechanism only guarantees that rqs sent to ublksrv
before crash are not aborted. Instead, ublk_drv re-issues the request
itself and fio does not konw about it. Of course the backend must
tolerate a double-write/read.

> 
>> In detail, we support
>> this scenario:
>> (1) The /dev/ublkc0 is opened by process 0;
>> (2) Fio is running on /dev/ublkb0 exposed by ublk_drv and all
>>     rqs are handled by process 0.
>> (3) Process 0 suddenly crashes(e.g. segfault);
>> (4) Fio is still running and submit IOs(but these IOs cannot
>>     complete now)
>> (5) User recovers with process 1 and attach it to /dev/ublkc0
>> (6) All rqs are handled by process 1 now and IOs can be
>>     completed now.
>>
>> Note: The backend must tolerate double-write because we re-issue
>> a rq sent to the old(dying) process before. We allow users to
>> choose whether re-issue these rqs or not, please see patch 7 for
>> more detail.
>>
>> We provide a sample script here to simulate the above steps:
>>
>> ***************************script***************************
>> LOOPS=10
>>
>> __ublk_get_pid() {
>> 	pid=`./ublk list -n 0 | grep "pid" | awk '{print $7}'`
>> 	echo $pid
>> }
>>
>> ublk_recover_kill()
>> {
>> 	for CNT in `seq $LOOPS`; do
>> 		dmesg -C
>>                 pid=`__ublk_get_pid`
>>                 echo -e "*** kill $pid now ***"
>> 		kill -9 $pid
>> 		sleep 2
>>                 echo -e "*** recover now ***"
>>                 ./ublk recover -n 0
> 
> The current behavior is that /dev/ublkb* is removed after device is
> aborted because ubq daemon is killed.
> 
> What if 'ublk recover' command isn't sent? So the current behavior
> without recovery is changed? Or just changed with this feature enabled?

No, I do not change the default behavior. You can verify this by running
generic/002 and generic/003. These tests passes with either recovery enabled
or disabled.


(1) With recovery disabled, the monitor_work scheduled periodically or
    STOP_DEV ctrl-cmd issued manually can cleanup everything and remove the
    gendisk.

(2)With recovery enabled, the monitor_work is not scheduled anymore, see
   patch 9. So after a crash，all resources are still in kernel.
   Then, there are two options for a user:
    (a) You don't want to recover it, so just send STOP_DEV ctrl-cmd. This will
        schedule monitor_work once and cleanup everything. Please see patch 5.
    (b) You want to recover it, so just send START_RECOVERY ctrl-cmd. Then you
        HAVE TO start a new process and send END_RECOVERY.

Note: Actually I am thinking what if a user has sent START_RECOVERY but he fails
to start a new process. I have a rough idea: just abort all rqs after we unqiuesce
the request queue. But that is not included in this RFC patchset because I
want to make it simpler. Maybe we can consider it later?

> 
> BTW, I do not mean the change isn't reasonable, but suggest to document
> the user visible change, so it can get reviewed from either user
> viewpoint and technical point.
> 
>> 		sleep 4
>> 	done
>> }
>>
>> ublk_test()
>> {
>>         dmesg -C
>>         echo -e "*** add ublk device ***"
>>         ./ublk add -t null -d 4 -i 1
>>         sleep 2
>>         echo -e "*** start fio ***"
>>         fio --bs=4k \
>>             --filename=/dev/ublkb0 \
>>             --runtime=100s \
>>             --rw=read &
>>         sleep 4
>>         ublk_recover_kill
>>         wait
>>         echo -e "*** delete ublk device ***"
>>         ./ublk del -n 0
>> }
>>
>> for CNT in `seq 4`; do
>>         modprobe -rv ublk_drv
>>         modprobe ublk_drv
>>         echo -e "************ round $CNT ************"
>>         ublk_test
>>         sleep 5
>> done
>> ***************************script***************************
>>
>> You may run it with our modified ublksrv[3] which supports
>> recovey feature. No I/O error occurs and you can verify it
>> by typing
>>     $ perf-tools/bin/tpoint block:block_rq_error
>>
>> The basic idea of USER_RECOVERY is quite straightfoward:
>>
>> (1) release/free everything belongs to the dying process.
>>
>>     Note: Since ublk_drv does save information about user process,
>>     this work is important because we don't expect any resource
>>     lekage. Particularly, ioucmds from the dying ubq_daemons
>>     need to be completed(freed). Current ublk_drv code cannot satisfy
>>     our need while considering USER_RECOVERY. So we refactor some code
>>     shown in patch 1-5 to gracefully free all ioucmds.
>>
>> (2) init ublk queues including requeuing/aborting rqs.
>>
>> (3) allow new ubq_daemons issue FETCH_REQ.
>>
>> Here is steps to reocver:
>>
>> (1) For a user, after a process crash(how he detect a crash is not related
>>     to this patchset), he sends START_USER_RECOVERY ctrl-cmd to
> 
> I'd suggest to describe crash detector a bit at least, as one whole use case,
> crash detector should be the input of the use case of user recovery, which is
> usually one part of use case when modeling software requirement/design.

This patchset tries to answer only one question: After a process crash, how to
re-attach the device by another process. So I do not consider other questions
too much, such as:
(1) How to detect a crash?
(2) Is IO hang a crash? Should we kill the process?
(3) What if a blk-mq rq timeout? Does the process dies? Should we kill the process?

I think we can answer them after kernel-support of USER_RECOVERY is available.


For now I only try to directly kill the process in testcases and manually inject
a crash in handle_io_async().

> 
> Such as, crash is detected after the ubq daemon pthread/process is crashed?
> Will you consider io hang in the daemon pthread/process? IMO, long-term,
> the crash detector utility should be part of ublksrv.

Yes, we should design a crash detector in ublksrv. For IO hang, my idea is that:

(1) the ublksrv_tgt code should handle it if user runs ublksrv directly.

(2) the backend should handle it if user only uses libublksrv and embeds it inside
    the backend code.

> 
> We don't implement ublk driver's IO timeout yet, but that implementation may be
> related with this recovery feature closely, such as, one simple approach is to
> kill ubq-daemon if we can't move on after retrying several times, then
> let userspace detect & recovery.

You mean the ublk_drv can kill the ubq_daemon? I have not consider this case yet...

BTW, I don't think we should put too much logic(IO hang, detector) in ublk_drv
because it should only pass-through rqs to userpsace. We should make ublk_drv simple.
Accept a new daemon and re-attach it to /dev/ublkb0 is what it can do I think.


Regards,
Zhang
