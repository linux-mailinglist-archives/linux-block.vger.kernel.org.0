Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 271CD17E55E
	for <lists+linux-block@lfdr.de>; Mon,  9 Mar 2020 18:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbgCIRJg (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 9 Mar 2020 13:09:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51047 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727201AbgCIRJg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Mar 2020 13:09:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583773774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ldM27SPo0b6SS/sz7Fn+KdNHXvsU4qNibEbf0hMXOB4=;
        b=W0Qb3xm+9cDtTx+OjzCAMZN0r3tNpq0+/P4O1bjpjuEg7peUp40ZaVWhH5uxd0q/bX/4qx
        T6llenCWtyOgrNdyn9upipTZeiUtn9SJRiq0efX3OM4gaUCRLIMEPNhchF6JsFEYvIenEQ
        uubI24px5MMIYZVoh46Gg9D+V+LFr1c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-_9iV8QP5PIGuJJl80zxqJg-1; Mon, 09 Mar 2020 13:09:29 -0400
X-MC-Unique: _9iV8QP5PIGuJJl80zxqJg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3805D1005509;
        Mon,  9 Mar 2020 17:09:28 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-211.rdu2.redhat.com [10.10.123.211])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 06ECC60BFB;
        Mon,  9 Mar 2020 17:09:20 +0000 (UTC)
Subject: =?UTF-8?Q?Re=3a_=e2=9d=8c_FAIL=3a_Test_report_for_kernel_5=2e6=2e0-?=
 =?UTF-8?Q?rc4-61a0925=2ecki_=28mainline=2ekernel=2eorg=29?=
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block <linux-block@vger.kernel.org>,
        CKI Project <cki-project@redhat.com>,
        Memory Management <mm-qe@redhat.com>,
        Jan Stancek <jstancek@redhat.com>,
        LTP Mailing List <ltp@lists.linux.it>,
        Xiong Zhou <xzhou@redhat.com>
References: <cki.FEFA879F6B.TFTZ93YIF0@redhat.com>
 <ba09351f-0a5a-824a-dbf2-021360581cd7@redhat.com>
 <86A42362-D355-4885-AC68-B43E46FBB109@linaro.org>
From:   Rachel Sibley <rasibley@redhat.com>
Message-ID: <24e4518f-7035-f8f8-30d0-97f0836f174c@redhat.com>
Date:   Mon, 9 Mar 2020 13:09:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <86A42362-D355-4885-AC68-B43E46FBB109@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 3/9/20 12:42 PM, Paolo Valente wrote:
> Hi Rachel,
> IIUC, you can reproduce this bug reliably. If so, I'd need you to test =
a debugging patch (on top of one of the offending kernels).

Hi Paolo,

Yes seems we have seen it pretty consistently in the last three reports, =
but I'm cloning the job to be sure we can
reproduce reliably. In the mean time, feel free to send me a pointer to y=
our debugging patch so I can retry with
the patch applied.

Thank you,
Rachel

>=20
> Looking forward to your feedback,
> Paolo
>=20
>> Il giorno 9 mar 2020, alle ore 15:27, Rachel Sibley <rasibley@redhat.c=
om> ha scritto:
>>
>> (cc'ing linux-block@vger.kernel.org)
>>
>> Hello,
>>
>> We are seeing a kernel panic triggered with LTP and xfstests against a=
 recent commit for mainline,
>> wanted to share in case it's not already known.
>>
>> Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/=
linux.git
>> Commit: 61a09258f2e5 - Merge tag 'for-linus' of git://git.kernel.org/p=
ub/scm/linux/kernel/git/rdma/rdma
>>
>> We have also seen it with 2c523b344dfa and 378fee2e6b12 commits as wel=
l.
>>
>> LTP: https://cki-artifacts.s3.us-east-2.amazonaws.com/datawarehouse/20=
20/03/08/477469/x86_64_1_console.log
>> xfstests: https://cki-artifacts.s3.us-east-2.amazonaws.com/datawarehou=
se/2020/03/08/477469/x86_64_4_console.log
>>
>> [-- MARK -- Sun Mar  8 02:45:00 2020]
>> [  762.315610] BUG: kernel NULL pointer dereference, address: 00000000=
00000158
>> [  762.323385] #PF: supervisor read access in kernel mode
>> [  762.329119] #PF: error_code(0x0000) - not-present page
>> [  762.334853] PGD 0 P4D 0
>> [  762.337680] Oops: 0000 [#1] SMP PTI
>> [  762.341575] CPU: 9 PID: 87 Comm: kworker/9:1 Not tainted 5.6.0-rc4-=
61a0925.cki #1
>> [  762.349927] Hardware name: Cisco Systems, Inc. UCS-E160DP-M1/K9/UCS=
-E160DP-M1/K9, BIOS UCSED.1.5.0.2.051520131757 05/15/2013
>> [  762.362453] Workqueue: cgroup_destroy css_killed_work_fn
>> [  762.368387] RIP: 0010:bfq_bfqq_expire+0x1c/0x940
>> [  762.373540] Code: 01 00 00 c7 80 f8 00 00 00 01 00 00 00 c3 66 66 6=
6 66 90 41 57 41 56 41 55 41 54 41 89 cc 55 48 89 fd 53 48 89 f3 48 83 ec=
 28 <8b> be 58 01 00 00 65 48 8b 04 25 28 00 00 00 48 89 44 24 20 31 c0
>> [  762.394500] RSP: 0018:ffff9927c03bbd50 EFLAGS: 00010086
>> [  762.400331] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000=
0000000004
>> [  762.408301] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff89=
65a3913800
>> [  762.416270] RBP: ffff8965a3913800 R08: ffff896592d41098 R09: ffff89=
657aa8df00
>> [  762.424233] R10: 0000000000000000 R11: ffff89657aa8df00 R12: 000000=
0000000004
>> [  762.432200] R13: ffff89659f0cd9b0 R14: ffff8965a3913bf0 R15: ffff89=
659f0cd898
>> [  762.440175] FS:  0000000000000000(0000) GS:ffff8965a7c40000(0000) k=
nlGS:0000000000000000
>> [  762.449211] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  762.455622] CR2: 0000000000000158 CR3: 000000065afc6003 CR4: 000000=
00000606e0
>> [  762.463599] Call Trace:
>> [  762.466341]  ? bfq_idle_extract+0x40/0xb0
>> [  762.470821]  bfq_bfqq_move+0x14f/0x160
>> [  762.475011]  bfq_pd_offline+0xd3/0xf0
>> [  762.479112]  blkg_destroy+0x52/0xf0
>> [  762.483005]  blkcg_destroy_blkgs+0x4f/0xa0
>> [  762.487582]  css_killed_work_fn+0x4d/0xd0
>> [  762.492066]  process_one_work+0x1b5/0x360
>> [  762.496547]  worker_thread+0x50/0x3c0
>> [  762.500641]  kthread+0xf9/0x130
>> [  762.504153]  ? process_one_work+0x360/0x360
>> [  762.508813]  ? kthread_park+0x90/0x90
>> [  762.512909]  ret_from_fork+0x35/0x40
>>
>> Thanks,
>> Rachel
>>
>> On 3/7/20 9:59 PM, CKI Project wrote:
>>> Hello,
>>> We ran automated tests on a recent commit from this kernel tree:
>>>         Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/=
torvalds/linux.git
>>>              Commit: 61a09258f2e5 - Merge tag 'for-linus' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/rdma/rdma
>>> The results of these automated tests are provided below.
>>>      Overall result: FAILED (see details below)
>>>               Merge: OK
>>>             Compile: OK
>>>               Tests: FAILED
>>> All kernel binaries, config files, and logs are available for downloa=
d here:
>>>    https://cki-artifacts.s3.us-east-2.amazonaws.com/index.html?prefix=
=3Ddatawarehouse/2020/03/08/477469
>>> One or more kernel tests failed:
>>>      x86_64:
>>>       =E2=9D=8C LTP
>>>       =E2=9D=8C xfstests - ext4
>>> We hope that these logs can help you find the problem quickly. For th=
e full
>>> detail on our testing procedures, please scroll to the bottom of this=
 message.
>>> Please reply to this email if you have any questions about the tests =
that we
>>> ran or if you have any suggestions on how to make future tests more e=
ffective.
>>>          ,-.   ,-.
>>>         ( C ) ( K )  Continuous
>>>          `-',-.`-'   Kernel
>>>            ( I )     Integration
>>>             `-'
>>> _____________________________________________________________________=
_________
>>> Compile testing
>>> ---------------
>>> We compiled the kernel for 1 architecture:
>>>      x86_64:
>>>        make options: -j30 INSTALL_MOD_STRIP=3D1 targz-pkg
>>> Hardware testing
>>> ----------------
>>> We booted each kernel and ran the following tests:
>>>    x86_64:
>>>      Host 1:
>>>         =E2=9C=85 Boot test
>>>         =E2=9C=85 Podman system integration test - as root
>>>         =E2=9C=85 Podman system integration test - as user
>>>         =E2=9D=8C LTP
>>>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Loopdev Sanity
>>>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Memory function: memfd_create
>>>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 AMTU (Abstract Machine Test Utili=
ty)
>>>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking bridge: sanity
>>>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Ethernet drivers sanity
>>>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking MACsec: sanity
>>>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking socket: fuzz
>>>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking sctp-auth: sockopts te=
st
>>>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking: igmp conformance test
>>>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking route: pmtu
>>>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking route_func - local
>>>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking route_func - forward
>>>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking TCP: keepalive test
>>>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking UDP: socket
>>>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking tunnel: geneve basic t=
est
>>>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking tunnel: gre basic
>>>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 L2TP basic test
>>>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking tunnel: vxlan basic
>>>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking ipsec: basic netns - t=
ransport
>>>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking ipsec: basic netns - t=
unnel
>>>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 audit: audit testsuite test
>>>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 httpd: mod_ssl smoke sanity
>>>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 tuned: tune-processes-through-per=
f
>>>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 pciutils: sanity smoke test
>>>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 ALSA PCM loopback test
>>>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 ALSA Control (mixer) Userspace El=
ement test
>>>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 storage: SCSI VPD
>>>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 trace: ftrace/tracer
>>>         =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 CIFS Connectathon
>>>         =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 POSIX pjd-fstest sui=
tes
>>>         =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 jvm - DaCapo Benchma=
rk Suite
>>>         =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 jvm - jcstress tests
>>>         =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 Memory function: kas=
lr
>>>         =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 LTP: openposix test =
suite
>>>         =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking vnic: ipv=
lan/basic
>>>         =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 iotop: sanity
>>>         =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 Usex - version 1.9-2=
9
>>>         =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 storage: dm/common
>>>      Host 2:
>>>         =E2=9C=85 Boot test
>>>         =E2=9C=85 Storage SAN device stress - mpt3sas driver
>>>      Host 3:
>>>         =E2=9C=85 Boot test
>>>         =E2=9C=85 Storage SAN device stress - megaraid_sas
>>>      Host 4:
>>>         =E2=9C=85 Boot test
>>>         =E2=9D=8C xfstests - ext4
>>>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 xfstests - xfs
>>>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 selinux-policy: serge-testsuite
>>>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 lvm thinp sanity
>>>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 storage: software RAID testing
>>>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 stress: stress-ng
>>>         =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 IOMMU boot test
>>>         =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 IPMI driver test
>>>         =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 IPMItool loop stress=
 test
>>>         =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 power-management: cp=
upower/sanity test
>>>         =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage blktests
>>>    Test sources: https://github.com/CKI-project/tests-beaker
>>>      =F0=9F=92=9A Pull requests are welcome for new tests or improvem=
ents to existing tests!
>>> Waived tests
>>> ------------
>>> If the test run included waived tests, they are marked with =F0=9F=9A=
=A7. Such tests are
>>> executed but their results are not taken into account. Tests are waiv=
ed when
>>> their results are not reliable enough, e.g. when they're just introdu=
ced or are
>>> being fixed.
>>> Testing timeout
>>> ---------------
>>> We aim to provide a report within reasonable timeframe. Tests that ha=
ven't
>>> finished running yet are marked with =E2=8F=B1.
>>
>=20

