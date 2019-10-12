Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA218D511F
	for <lists+linux-block@lfdr.de>; Sat, 12 Oct 2019 18:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbfJLQsf (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 12 Oct 2019 12:48:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43982 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbfJLQqf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 12 Oct 2019 12:46:35 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 379BCA3CD70;
        Sat, 12 Oct 2019 16:46:35 +0000 (UTC)
Received: from localhost (ovpn-116-56.ams2.redhat.com [10.36.116.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F0D46017E;
        Sat, 12 Oct 2019 16:46:34 +0000 (UTC)
Date:   Sat, 12 Oct 2019 17:46:33 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: io_uring NULL pointer dereference on Linux v5.4-rc1
Message-ID: <20191012164633.GA17917@stefanha-x1.localdomain>
References: <20191009092302.GA5303@stefanha-x1.localdomain>
 <e9beeedf-3a06-841f-53a4-51ac4e9e13ea@kernel.dk>
 <20191009174602.GI13568@stefanha-x1.localdomain>
 <d5bbaf7c-31e4-725c-90ab-18c342e2c4eb@kernel.dk>
 <20191011084618.GA2848@stefanha-x1.localdomain>
 <c24b0ee5-361c-20da-1b7a-27aab947d4f2@kernel.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
In-Reply-To: <c24b0ee5-361c-20da-1b7a-27aab947d4f2@kernel.dk>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Sat, 12 Oct 2019 16:46:35 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2019 at 06:08:34AM -0600, Jens Axboe wrote:
> On 10/11/19 2:46 AM, Stefan Hajnoczi wrote:
> > On Wed, Oct 09, 2019 at 02:36:01PM -0600, Jens Axboe wrote:
> >> On 10/9/19 11:46 AM, Stefan Hajnoczi wrote:
> >>> On Wed, Oct 09, 2019 at 05:27:44AM -0600, Jens Axboe wrote:
> >>>> On 10/9/19 3:23 AM, Stefan Hajnoczi wrote:
> >>>>> I hit this NULL pointer dereference when running qemu-iotests 052 (=
raw)
> >>>>> on both ext4 and XFS on dm-thin/luks.  The kernel is Linux v5.4-rc1=
 but
> >>>>> I haven't found any obvious fixes in Jens' tree, so it's likely that
> >>>>> this bug is still present:
> >>>>>
> >>>>> BUG: kernel NULL pointer dereference, address: 0000000000000102
> >>>>> #PF: supervisor read access in kernel mode
> >>>>> #PF: error_code(0x0000) - not-present page
> >>>>> PGD 0 P4D 0
> >>>>> Oops: 0000 [#1] SMP PTI
> >>>>> CPU: 2 PID: 6656 Comm: qemu-io Not tainted 5.4.0-rc1 #1
> >>>>> Hardware name: LENOVO 20BTS1N70V/20BTS1N70V, BIOS N14ET37W (1.15 ) =
09/06/2016
> >>>>> RIP: 0010:__queue_work+0x1f/0x3b0
> >>>>> Code: eb df 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41 57 49 89 f=
7 41 56 41 89 fe 41 55 41 89 fd 41 54 55 48 89 d5 53 48 83 ec 10 <f6> 86 02=
 01 00 00 01 0f 85 bc 02 00 00 49 bc eb 83 b5 80 46 86 c8
> >>>>> RSP: 0018:ffffbef4884bbd58 EFLAGS: 00010082
> >>>>> RAX: 0000000000000246 RBX: 0000000000000246 RCX: 0000000000000000
> >>>>> RDX: ffff9903901f4460 RSI: 0000000000000000 RDI: 0000000000000040
> >>>>> RBP: ffff9903901f4460 R08: ffff9903901fb040 R09: ffff990398614700
> >>>>> R10: 0000000000000030 R11: 0000000000000000 R12: 0000000000000000
> >>>>> R13: 0000000000000040 R14: 0000000000000040 R15: 0000000000000000
> >>>>> FS:  00007f7d2a4e4a80(0000) GS:ffff9903a5a80000(0000) knlGS:0000000=
000000000
> >>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>>>> CR2: 0000000000000102 CR3: 0000000203da8004 CR4: 00000000003606e0
> >>>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >>>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >>>>> Call Trace:
> >>>>>     ? __io_queue_sqe+0xa1/0x200
> >>>>>     queue_work_on+0x36/0x40
> >>>>>     __io_queue_sqe+0x16e/0x200
> >>>>>     io_ring_submit+0xd2/0x230
> >>>>>     ? percpu_ref_resurrect+0x46/0x70
> >>>>>     ? __io_uring_register+0x207/0xa30
> >>>>>     ? __schedule+0x286/0x700
> >>>>>     __x64_sys_io_uring_enter+0x1a3/0x280
> >>>>>     ? __x64_sys_io_uring_register+0x64/0xb0
> >>>>>     do_syscall_64+0x5b/0x180
> >>>>>     entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >>>>> RIP: 0033:0x7f7d3439f1fd
> >>>>> Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 4=
8 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01=
 f0 ff ff 73 01 c3 48 8b 0d 5b 8c 0c 00 f7 d8 64 89 01 48
> >>>>> RSP: 002b:00007f7d2918d408 EFLAGS: 00000216 ORIG_RAX: 0000000000000=
1aa
> >>>>> RAX: ffffffffffffffda RBX: 00007f7d2918d4f0 RCX: 00007f7d3439f1fd
> >>>>> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 000000000000000a
> >>>>> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000008
> >>>>> R10: 0000000000000000 R11: 0000000000000216 R12: 00005616e3c32ab8
> >>>>> R13: 00005616e3c32b78 R14: 00005616e3c32ab0 R15: 0000000000000001
> >>>>> Modules linked in: fuse ccm xt_CHECKSUM xt_MASQUERADE tun bridge st=
p llc nf_conntrack_netbios_ns nf_conntrack_broadcast xt_CT ip6t_rpfilter ip=
6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat=
 ip6table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf=
_nat iptable_mangle iptable_raw iptable_security nf_conntrack nf_defrag_ipv=
6 nf_defrag_ipv4 ip_set nfnetlink ebtable_filter ebtables ip6table_filter i=
p6_tables iptable_filter ip_tables sunrpc vfat fat intel_rapl_msr rmi_smbus=
 iwlmvm rmi_core intel_rapl_common x86_pkg_temp_thermal intel_powerclamp co=
retemp mac80211 snd_hda_codec_realtek snd_hda_codec_generic snd_hda_codec_h=
dmi kvm_intel snd_hda_intel kvm snd_intel_nhlt snd_hda_codec snd_usb_audio =
irqbypass uvcvideo snd_hda_core snd_usbmidi_lib snd_rawmidi iTCO_wdt snd_hw=
dep libarc4 intel_cstate cdc_ether intel_uncore videobuf2_vmalloc iwlwifi m=
ei_wdt mei_hdcp iTCO_vendor_support snd_seq videobuf2_memops usbnet videobu=
f2_v4l2 snd_seq_device
> >>>>>     intel_rapl_perf pcspkr videobuf2_common joydev wmi_bmof snd_pcm=
 cfg80211 r8152 videodev intel_pch_thermal i2c_i801 mii mc thinkpad_acpi sn=
d_timer mei_me ledtrig_audio snd lpc_ich mei soundcore rfkill binfmt_misc x=
fs dm_thin_pool dm_persistent_data dm_bio_prison libcrc32c dm_crypt i915 i2=
c_algo_bit drm_kms_helper drm crct10dif_pclmul crc32_pclmul crc32c_intel gh=
ash_clmulni_intel serio_raw wmi video
> >>>>> CR2: 0000000000000102
> >>>>> ---[ end trace 2ac747acabe218da ]---
> >>>>> RIP: 0010:__queue_work+0x1f/0x3b0
> >>>>> Code: eb df 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41 57 49 89 f=
7 41 56 41 89 fe 41 55 41 89 fd 41 54 55 48 89 d5 53 48 83 ec 10 <f6> 86 02=
 01 00 00 01 0f 85 bc 02 00 00 49 bc eb 83 b5 80 46 86 c8
> >>>>> RSP: 0018:ffffbef4884bbd58 EFLAGS: 00010082
> >>>>> RAX: 0000000000000246 RBX: 0000000000000246 RCX: 0000000000000000
> >>>>> RDX: ffff9903901f4460 RSI: 0000000000000000 RDI: 0000000000000040
> >>>>> RBP: ffff9903901f4460 R08: ffff9903901fb040 R09: ffff990398614700
> >>>>> R10: 0000000000000030 R11: 0000000000000000 R12: 0000000000000000
> >>>>> R13: 0000000000000040 R14: 0000000000000040 R15: 0000000000000000
> >>>>> FS:  00007f7d2a4e4a80(0000) GS:ffff9903a5a80000(0000) knlGS:0000000=
000000000
> >>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>>>> CR2: 0000000000000102 CR3: 0000000203da8004 CR4: 00000000003606e0
> >>>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >>>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >>>>>
> >>>>> Unfortunately I don't have time to find the root cause.  What I've
> >>>>> figured out so far is:
> >>>>>
> >>>>>      bool queue_work_on(int cpu, struct workqueue_struct *wq,
> >>>>>                         struct work_struct *work)
> >>>>>      {
> >>>>>          bool ret =3D false;
> >>>>>          unsigned long flags;
> >>>>>
> >>>>>          local_irq_save(flags);
> >>>>>
> >>>>>          if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_b=
its(work))) {
> >>>>>                                                         ~~~~~~~~~~~=
~~~~~~~~~
> >>>>>
> >>>>> The address of work is 0x102 so this line causes a page fault when =
it
> >>>>> tries to access the data field (offset 0).
> >>>>>
> >>>>> The caller provided the 0x102 pointer so let's see where it comes f=
rom:
> >>>>>
> >>>>>      static int __io_queue_sqe(struct io_ring_ctx *ctx, struct io_k=
iocb *req,
> >>>>>                                struct sqe_submit *s, bool force_non=
block)
> >>>>>      {
> >>>>>          ...
> >>>>>          if (!io_add_to_prev_work(list, req)) {
> >>>>>              if (list)
> >>>>>                  atomic_inc(&list->cnt);
> >>>>>              INIT_WORK(&req->work, io_sq_wq_submit_work);
> >>>>>              io_queue_async_work(ctx, req);
> >>>>> 	  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>>>>
> >>>>> and queue_work() is called here:
> >>>>>
> >>>>>      static inline void io_queue_async_work(struct io_ring_ctx *ctx,
> >>>>>                                             struct io_kiocb *req)
> >>>>>      {
> >>>>>          int rw =3D 0;
> >>>>>
> >>>>>          if (req->submit.sqe) {
> >>>>>              switch (req->submit.sqe->opcode) {
> >>>>>              case IORING_OP_WRITEV:
> >>>>>              case IORING_OP_WRITE_FIXED:
> >>>>>                  rw =3D !(req->rw.ki_flags & IOCB_DIRECT);
> >>>>>                  break;
> >>>>>              }
> >>>>>          }
> >>>>>
> >>>>>          queue_work(ctx->sqo_wq[rw], &req->work);
> >>>>>          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>>>>
> >>>>> I must be missing something though because it seems impossible to g=
et
> >>>>> this far if req is NULL.  INIT_WORK() would have Oopsed already.  A=
lso,
> >>>>> offsetof(struct io_kiocb, work) is 0xa0 according to pahole(1) so we
> >>>>> still haven't reached the 0x102 offset from the Oops report.
> >>>>>
> >>>>> Any ideas?
> >>>>
> >>>> This is new in 5.4-rc1?
> >>>
> >>> I didn't hit it with 5.3, but I hit other issues so I'm not sure if t=
his
> >>> bug exists in older kernels.
> >>>
> >>>> And how are you reproducing it?
> >>>
> >>>     $ git clone -b io_uring https://github.com/stefanha/qemu
> >>>     $ cd qemu
> >>>     $ ./configure --target-list=3Dx86_64-softmmu
> >>>     $ make -j$(nproc)
> >>>     $ (cd tests/qemu-iotests && ./check -i io_uring 052)
> >>>
> >>> You can mount the file system of your choice at
> >>> tests/qemu-iotests/scratch/ before running the test.
> >>>
> >>> You can view the test case at tests/qemu-iotests/052.
> >>
> >> Thanks, that's useful. Need to look closer into this, but seems wrong
> >> that we're killing the workqueue for SCM_RIGHTS removal. We just need =
to
> >> sync it. Does this work for you?
> >>
> >>
> >> diff --git a/fs/io_uring.c b/fs/io_uring.c
> >> index 8a0381f1a43b..a8755582c688 100644
> >> --- a/fs/io_uring.c
> >> +++ b/fs/io_uring.c
> >> @@ -2920,8 +2920,12 @@ static void io_finish_async(struct io_ring_ctx =
*ctx)
> >>   static void io_destruct_skb(struct sk_buff *skb)
> >>   {
> >>   	struct io_ring_ctx *ctx =3D skb->sk->sk_user_data;
> >> +	int i;
> >> +
> >> +	for (i =3D 0; i < ARRAY_SIZE(ctx->sqo_wq); i++)
> >> +		if (ctx->sqo_wq[i])
> >> +			flush_workqueue(ctx->sqo_wq[i]);
> >>  =20
> >> -	io_finish_async(ctx);
> >>   	unix_destruct_scm(skb);
> >>   }
> >=20
> > I tried this patch but still hit the same NULL pointer dereference.
>=20
> How certain are you that you booted the right kernel when you tested
> that? Because I'm very certain that this patch will fix the issue you
> saw.
>=20
> You can also pull:
>=20
> git://git.kernel.dk/linux-block for-linus
>=20
> into master and test that.

It was bugging me that we don't know if Linux v5.4-rc1 has a regression,
so I merged your for-linux branch on top of Linux v5.4-rc1 as you
suggested.

The test passes, so it's now certain that the fix(es) in your for-linux
branch solve the NULL pointer dereference :).

Stefan

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2iA2YACgkQnKSrs4Gr
c8hDxQf/ZfRTyJDKOKbVnILi//OxtpkDZBF2jT4bLfnCcXLClcBqIcJpqqPGh9A4
19N9wvJlFD0V1E3pfnCrEmDQgzep4fPxo7nTMFP+APgHJhuG3NDM3YefCENFSc6Y
22AK4xoJmeBRxlnESFK4nvWjtD17DDqXMTQhjasl9c2cKUvXCp+fhziyUFI8oLRO
WDESHO2L4vdLblt57q7w/5l3FG4Y8aJnKa0+ZMxivON416GUKhHgoKnou1o54NxT
j0bRjUdAw32dLzZPb388t4ETIqCdMOoqFawQAS91KFgPQun+tEWSdNBzsX4sr01E
s9PXh1+qlGZufgqgHk8K0A+Go1HZvw==
=WuVA
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
