Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8966823B40D
	for <lists+linux-block@lfdr.de>; Tue,  4 Aug 2020 06:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgHDE3Q (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 4 Aug 2020 00:29:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:55634 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbgHDE3P (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Aug 2020 00:29:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 54BA7AB3D;
        Tue,  4 Aug 2020 04:29:28 +0000 (UTC)
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Xiao Ni <xni@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20200804041508.1870113-1-ming.lei@redhat.com>
From:   Coly Li <colyli@suse.de>
Autocrypt: addr=colyli@suse.de; keydata=
 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
Subject: Re: [PATCH] block: loop: set discard granularity and alignment for
 block device backed loop
Message-ID: <26b64ecb-53ed-9caf-a447-ce795fbba132@suse.de>
Date:   Tue, 4 Aug 2020 12:29:07 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200804041508.1870113-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/8/4 12:15, Ming Lei wrote:
> In case of block device backend, if the backend supports discard, the
> loop device will set queue flag of QUEUE_FLAG_DISCARD.
> 
> However, limits.discard_granularity isn't setup, and this way is wrong,
> see the following description in Documentation/ABI/testing/sysfs-block:
> 
> 	A discard_granularity of 0 means that the device does not support
> 	discard functionality.
> 
> Especially 9b15d109a6b2 ("block: improve discard bio alignment in
> __blkdev_issue_discard()") starts to take q->limits.discard_granularity
> for computing max discard sectors. And zero discard granularity causes
> kernel oops[1].
> 
> Fix the issue by set up discard granularity and alignment.
> 
> [1] kernel oops when use block disk as loop backend:
> 
> [   33.405947] ------------[ cut here ]------------
> [   33.405948] kernel BUG at block/blk-mq.c:563!
> [   33.407504] invalid opcode: 0000 [#1] SMP PTI
> [   33.408245] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 5.8.0-rc2_update_rq+ #17
> [   33.409466] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS ?-20180724_192412-buildhw-07.phx2.fedor4
> [   33.411546] RIP: 0010:blk_mq_end_request+0x1c/0x2a
> [   33.412354] Code: 48 89 df 5b 5d 41 5c 41 5d e9 2d fe ff ff 0f 1f 44 00 00 55 48 89 fd 53 40 0f b6 de 8b 57 5
> [   33.415724] RSP: 0018:ffffc900019ccf48 EFLAGS: 00010202
> [   33.416688] RAX: 0000000000000001 RBX: 0000000000000000 RCX: ffff88826f2600c0
> [   33.417990] RDX: 0000000000200042 RSI: 0000000000000001 RDI: ffff888270c13100
> [   33.419286] RBP: ffff888270c13100 R08: 0000000000000001 R09: ffffffff81345144
> [   33.420584] R10: ffff88826f260600 R11: 0000000000000000 R12: ffff888270c13100
> [   33.421881] R13: ffffffff820050c0 R14: 0000000000000004 R15: 0000000000000004
> [   33.423053] FS:  0000000000000000(0000) GS:ffff888277d80000(0000) knlGS:0000000000000000
> [   33.424360] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   33.425416] CR2: 00005581d7903f08 CR3: 00000001e9a16002 CR4: 0000000000760ee0
> [   33.426580] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   33.427706] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   33.428910] PKRU: 55555554
> [   33.429412] Call Trace:
> [   33.429858]  <IRQ>
> [   33.430189]  blk_done_softirq+0x84/0xa4
> [   33.430884]  __do_softirq+0x11a/0x278
> [   33.431567]  asm_call_on_stack+0x12/0x20
> [   33.432283]  </IRQ>
> [   33.432673]  do_softirq_own_stack+0x31/0x40
> [   33.433448]  __irq_exit_rcu+0x46/0xae
> [   33.434132]  sysvec_call_function_single+0x7d/0x8b
> [   33.435021]  asm_sysvec_call_function_single+0x12/0x20
> [   33.435965] RIP: 0010:native_safe_halt+0x7/0x8
> [   33.436795] Code: 25 c0 7b 01 00 f0 80 60 02 df f0 83 44 24 fc 00 48 8b 00 a8 08 74 0b 65 81 25 db 38 95 7e b
> [   33.440179] RSP: 0018:ffffc9000191fee0 EFLAGS: 00000246
> [   33.441143] RAX: ffffffff816c4118 RBX: 0000000000000000 RCX: ffff888276631a00
> [   33.442442] RDX: 000000000000ddfe RSI: 0000000000000003 RDI: 0000000000000001
> [   33.443742] RBP: 0000000000000000 R08: 00000000f461e6ac R09: 0000000000000004
> [   33.445046] R10: 8080808080808080 R11: fefefefefefefeff R12: 0000000000000000
> [   33.446352] R13: 0000000000000003 R14: ffffffffffffffff R15: 0000000000000000
> [   33.447450]  ? ldsem_down_write+0x1f5/0x1f5
> [   33.448158]  default_idle+0x1b/0x2c
> [   33.448809]  do_idle+0xf9/0x248
> [   33.449392]  cpu_startup_entry+0x1d/0x1f
> [   33.450118]  start_secondary+0x168/0x185
> [   33.450843]  secondary_startup_64+0xa4/0xb0
> [   33.451612] Modules linked in: scsi_debug iTCO_wdt iTCO_vendor_support nvme nvme_core i2c_i801 lpc_ich virtis
> [   33.454292] Dumping ftrace buffer:
> [   33.454951]    (ftrace buffer empty)
> [   33.455626] ---[ end trace beece202d663d38f ]---
> 
> Fixes: 9b15d109a6b2 ("block: improve discard bio alignment in __blkdev_issue_discard()")
> Cc: Coly Li <colyli@suse.de>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Xiao Ni <xni@redhat.com>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/loop.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index d18160146226..6102370bee35 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -890,6 +890,11 @@ static void loop_config_discard(struct loop_device *lo)
>  		struct request_queue *backingq;
>  
>  		backingq = bdev_get_queue(inode->i_bdev);
> +
> +		q->limits.discard_granularity =
> +			queue_physical_block_size(backingq);
> +		q->limits.discard_alignment = 0;
> +
>  		blk_queue_max_discard_sectors(q,
>  			backingq->limits.max_write_zeroes_sectors);
>  
> 

Hi Ming,

I did similar change, it can avoid the panic or 0 length discard bio.
But yesterday I realize the discard request to loop device should not go
into __blkdev_issue_discard(). As commit c52abf563049 ("loop: Better
discard support for block devices") mentioned it should go into
blkdev_issue_zeroout(), this is why in loop_config_discard() the
max_discard_sectors is set to backingq->limits.max_write_zeroes_sectors.

Now I am looking at the problem why discard request on loop device
doesn't go into blkdev_issue_zeroout().

With the above change, the discard is very slow on loop device with
backing device. In my testing, mkfs.xfs on /dev/loop0 does not complete
in 20 minutes, each discard request is only 4097 sectors.

Coly Li

