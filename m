Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15055442C8
	for <lists+linux-block@lfdr.de>; Thu,  9 Jun 2022 06:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiFIE4I (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 9 Jun 2022 00:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiFIE4I (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Jun 2022 00:56:08 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA6665F2;
        Wed,  8 Jun 2022 21:56:05 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VFr-v1N_1654750559;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VFr-v1N_1654750559)
          by smtp.aliyun-inc.com;
          Thu, 09 Jun 2022 12:56:01 +0800
Date:   Thu, 9 Jun 2022 12:55:59 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] block drivers in user space
Message-ID: <YqF9X0sJjeCxwxBb@B-P7TQMD6M-0146.local>
Mail-Followup-To: Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, linux-fsdevel@vger.kernel.org
References: <YhXMu/GcceyDx637@B-P7TQMD6M-0146.local>
 <a55211a1-a610-3d86-e21a-98751f20f21e@opensource.wdc.com>
 <YhXsQdkOpBY2nmFG@B-P7TQMD6M-0146.local>
 <3702afe7-2918-42e7-110b-efa75c0b58e8@opensource.wdc.com>
 <YhbYOeMUv5+U1XdQ@B-P7TQMD6M-0146.local>
 <YqFUc8jhYp5ijS/C@T590>
 <YqFashbvU+v5lGZy@B-P7TQMD6M-0146.local>
 <YqFx2GGACopPmLaM@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YqFx2GGACopPmLaM@T590>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 09, 2022 at 12:06:48PM +0800, Ming Lei wrote:
> On Thu, Jun 09, 2022 at 10:28:02AM +0800, Gao Xiang wrote:
> > On Thu, Jun 09, 2022 at 10:01:23AM +0800, Ming Lei wrote:
> > > On Thu, Feb 24, 2022 at 08:58:33AM +0800, Gao Xiang wrote:
> > > > On Thu, Feb 24, 2022 at 07:40:47AM +0900, Damien Le Moal wrote:
> > > > > On 2/23/22 17:11, Gao Xiang wrote:
> > > > > > On Wed, Feb 23, 2022 at 04:46:41PM +0900, Damien Le Moal wrote:
> > > > > >> On 2/23/22 14:57, Gao Xiang wrote:
> > > > > >>> On Mon, Feb 21, 2022 at 02:59:48PM -0500, Gabriel Krisman Bertazi wrote:
> > > > > >>>> I'd like to discuss an interface to implement user space block devices,
> > > > > >>>> while avoiding local network NBD solutions.  There has been reiterated
> > > > > >>>> interest in the topic, both from researchers [1] and from the community,
> > > > > >>>> including a proposed session in LSFMM2018 [2] (though I don't think it
> > > > > >>>> happened).
> > > > > >>>>
> > > > > >>>> I've been working on top of the Google iblock implementation to find
> > > > > >>>> something upstreamable and would like to present my design and gather
> > > > > >>>> feedback on some points, in particular zero-copy and overall user space
> > > > > >>>> interface.
> > > > > >>>>
> > > > > >>>> The design I'm pending towards uses special fds opened by the driver to
> > > > > >>>> transfer data to/from the block driver, preferably through direct
> > > > > >>>> splicing as much as possible, to keep data only in kernel space.  This
> > > > > >>>> is because, in my use case, the driver usually only manipulates
> > > > > >>>> metadata, while data is forwarded directly through the network, or
> > > > > >>>> similar. It would be neat if we can leverage the existing
> > > > > >>>> splice/copy_file_range syscalls such that we don't ever need to bring
> > > > > >>>> disk data to user space, if we can avoid it.  I've also experimented
> > > > > >>>> with regular pipes, But I found no way around keeping a lot of pipes
> > > > > >>>> opened, one for each possible command 'slot'.
> > > > > >>>>
> > > > > >>>> [1] https://dl.acm.org/doi/10.1145/3456727.3463768
> > > > > >>>> [2] https://www.spinics.net/lists/linux-fsdevel/msg120674.html
> > > > > >>>
> > > > > >>> I'm interested in this general topic too. One of our use cases is
> > > > > >>> that we need to process network data in some degree since many
> > > > > >>> protocols are application layer protocols so it seems more reasonable
> > > > > >>> to process such protocols in userspace. And another difference is that
> > > > > >>> we may have thousands of devices in a machine since we'd better to run
> > > > > >>> containers as many as possible so the block device solution seems
> > > > > >>> suboptimal to us. Yet I'm still interested in this topic to get more
> > > > > >>> ideas.
> > > > > >>>
> > > > > >>> Btw, As for general userspace block device solutions, IMHO, there could
> > > > > >>> be some deadlock issues out of direct reclaim, writeback, and userspace
> > > > > >>> implementation due to writeback user requests can be tripped back to
> > > > > >>> the kernel side (even the dependency crosses threads). I think they are
> > > > > >>> somewhat hard to fix with user block device solutions. For example,
> > > > > >>> https://lore.kernel.org/r/CAM1OiDPxh0B1sXkyGCSTEpdgDd196-ftzLE-ocnM8Jd2F9w7AA@mail.gmail.com
> > > > > >>
> > > > > >> This is already fixed with prctl() support. See:
> > > > > >>
> > > > > >> https://lore.kernel.org/linux-fsdevel/20191112001900.9206-1-mchristi@redhat.com/
> > > > > > 
> > > > > > As I mentioned above, IMHO, we could add some per-task state to avoid
> > > > > > the majority of such deadlock cases (also what I mentioned above), but
> > > > > > there may still some potential dependency could happen between threads,
> > > > > > such as using another kernel workqueue and waiting on it (in principle
> > > > > > at least) since userspace program can call any syscall in principle (
> > > > > > which doesn't like in-kernel drivers). So I think it can cause some
> > > > > > risk due to generic userspace block device restriction, please kindly
> > > > > > correct me if I'm wrong.
> > > > > 
> > > > > Not sure what you mean with all this. prctl() works per process/thread
> > > > > and a context that has PR_SET_IO_FLUSHER set will have PF_MEMALLOC_NOIO
> > > > > set. So for the case of a user block device driver, setting this means
> > > > > that it cannot reenter itself during a memory allocation, regardless of
> > > > > the system call it executes (FS etc): all memory allocations in any
> > > > > syscall executed by the context will have GFP_NOIO.
> > > > 
> > > > I mean,
> > > > 
> > > > assuming PR_SET_IO_FLUSHER is already set on Thread A by using prctl,
> > > > but since it can call any valid system call, therefore, after it
> > > > received data due to direct reclaim and writeback, it is still
> > > > allowed to call some system call which may do something as follows:
> > > > 
> > > >    Thread A (PR_SET_IO_FLUSHER)   Kernel thread B (another context)
> > > > 
> > > >    (call some syscall which)
> > > > 
> > > >    submit something to Thread B
> > > >                                   
> > > >                                   ... (do something)
> > > > 
> > > >                                   memory allocation with GFP_KERNEL (it
> > > >                                   may trigger direct memory reclaim
> > > >                                   again and reenter the original fs.)
> > > > 
> > > >                                   wake up Thread A
> > > > 
> > > >    wait Thread B to complete
> > > > 
> > > > Normally such system call won't cause any problem since userspace
> > > > programs cannot be in a context out of writeback and direct reclaim.
> > > > Yet I'm not sure if it works under userspace block driver
> > > > writeback/direct reclaim cases.
> > > 
> > > Hi Gao Xiang,
> > > 
> > > I'd rather to reply you in this original thread, and the recent
> > > discussion is from the following link:
> > > 
> > > https://lore.kernel.org/linux-block/Yp1jRw6kiUf5jCrW@B-P7TQMD6M-0146.local/
> > > 
> > > kernel loop & nbd is really in the same situation.
> > > 
> > > For example of kernel loop, PF_MEMALLOC_NOIO is added in commit
> > > d0a255e795ab ("loop: set PF_MEMALLOC_NOIO for the worker thread"),
> > > so loop's worker thread can be thought as the above Thread A, and
> > > of course, writeback/swapout IO can reach the loop worker thread(
> > > the above Thread A), then loop just calls into FS from the worker
> > > thread for handling the loop IO, that is same with user space driver's
> > > case, and the kernel 'thread B' should be in FS code.
> > > 
> > > Your theory might be true, but it does depend on FS's implementation,
> > > and we don't see such report in reality.
> > > 
> > > Also you didn't mentioned that what kernel thread B exactly is? And what
> > > the allocation is in kernel thread B.
> > > 
> > > If you have actual report, I am happy to take account into it, otherwise not
> > > sure if it is worth of time/effort in thinking/addressing one pure theoretical
> > > concern.
> > 
> > Hi Ming,
> > 
> > Thanks for your look & reply.
> > 
> > That is not a wild guess. That is a basic difference between
> > in-kernel native block-based drivers and user-space block drivers.
> 
> Please look at my comment, wrt. your pure theoretical concern, userspace
> block driver is same with kernel loop/nbd.

Hi Ming,

I don't have time to audit some potential risky system call, but I guess
security folks or researchers may be interested in finding such path.

The big problem is, you cannot avoid people to write such system call (or 
ioctls) in their user daemon, since most system call (or ioctls)
implementation assumes that they're never called under the kernel memory
direct reclaim context (even with PR_SET_IO_FLUSHER) but userspace block
driver can give such context to userspace and user problems can do
whatever they do in principle.

IOWs, we can audit in-kernel block drivers and fix all buggy paths with
GFP_NOIO since the source code is already there and they should be fixed.

But you have no way to audit all user programs to call proper system calls
or random ioctls which can be safely worked in the direct reclaim context
(even with PR_SET_IO_FLUSHER).

> 
> Did you see such report on loop & nbd? Can you answer my questions wrt.
> kernel thread B?

I don't think it has some relationship with in-kernel loop device, since
the loop device I/O paths are all under control.

> 
> > 
> > That is userspace block driver can call _any_ system call if they want.
> > Since users can call any system call and any _new_ system call can be
> > introduced later, you have to audit all system calls "Which are safe
> > and which are _not_ safe" all the time. Otherwise, attacker can make
> 
> Isn't nbd server capable of calling any system call? Is there any
> security risk for nbd?

Note that I wrote this email initially as a generic concern (prior to your
ubd annoucement ), so that isn't related to your ubd from my POV.

> 
> > use of it to hung the system if such userspace driver is used widely.
> 
> >From the beginning, only ADMIN can create ubd, that is same with
> nbd/loop, and it gets default permission as disk device.

loop device is different since the path can be totally controlled by the
kernel.

> 
> ubd is really in same situation with nbd wrt. security, the only difference
> is just that nbd uses socket for communication, and ubd uses io_uring, that
> is all.
> 
> Yeah, Stefan Hajnoczi and I discussed to make ubd as one container
> block device, so normal user can create & use ubd, but it won't be done
> from the beginning, and won't be enabled until the potential security
> risks are addressed, and there should be more limits on ubd when normal user
> can create & use it, such as:
> 
> - not allow unprivileged ubd device to be mounted
> - not allow unprivileged ubd device's partition table to be read from
>   kernel
> - not support buffered io for unprivileged ubd device, and only direct io
>   is allowed

How could you do that? I think it needs a wide modification to mm/fs.
and how about mmap I/O?

> - maybe more limit for minimizing security risk.
> 
> > 
> > IOWs, in my humble opinion, that is quite a fundamental security
> > concern of all userspace block drivers.
> 
> But nbd is still there and widely used, and there are lots of people who
> shows interest in userspace block device. Then think about who is wrong?
> 
> As one userspace block driver, it is normal to see some limits there,
> but I don't agree that there is fundamental security issue.

That depends, if you think it's a real security issue that there could be
a path reported to public to trigger that after it's widely used, that is
fine.

> 
> > 
> > Actually, you cannot ignore block I/O requests if they actually push
> 
> Who wants to ignore block I/O? And why ignore it?

I don't know how to express that properly. Sorry for my bad English.

For example, userspace FS implementation can ignore any fs operations
triggered under direct reclaim.

But if you runs a userspace block driver under a random fs, they will
just send data & metadata I/O to your driver unconditionally. I think
that is too late to avoid such deadlock.

> 
> > into block layer, since that is too late if I/O actually is submitted
> > by some FS. And you don't even know which type of such I/O is.
> 
> We do know the I/O type.

1) you don't know meta or data I/O. I know there is a REQ_META, but
   that is not a strict mark.

2) even you know an I/O is under direct reclaim, how to deal with that?
  just send to userspace unconditionally?

> 
> > 
> > On the other side, user-space FS implementations can avoid this since
> > FS can know if under direct reclaim and don't do such I/O requests.
> 
> But it is nothing to do with userspace block device.

Anyway, it is just a random side note for this topic
"block drivers in user space"

I'm just expressing my own concern about such architecture, you could
ignore my concern above of course.

Thanks,
Gao Xiang


> 
> 
> 
> Thanks,
> Ming
> 
