Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F75E17E29D
	for <lists+linux-block@lfdr.de>; Mon,  9 Mar 2020 15:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgCIOjw (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 9 Mar 2020 10:39:52 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:43956 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgCIOjw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Mar 2020 10:39:52 -0400
Received: by mail-il1-f195.google.com with SMTP id o18so8826665ilg.10
        for <linux-block@vger.kernel.org>; Mon, 09 Mar 2020 07:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Zj4MyT2GnGW9BIQcjw7p8W05d+ybJ/CK98JufwkxSCs=;
        b=Eh4pstjOX1YvDRqMkd5pdvRVnK17BAJGf5UkX9hidiv7OGaTNlOeivDGtcZnd6lf/A
         Qu3FrDGxvPxC/6Hz1OSKxnrWhHsaGiWCO66W9Ua0HTZUp3jtDCM4H/8omFf2ctYTtXmH
         u6RgeBcru589DCdEbIFFxhyizXh/SoO+XyoJybRnAPhikGpfmGTOrFYhcAEKeqp8UWab
         hS7DLG24qvTdAP4XaX1GYlYn4EzT4sDJtE+xH7CK9X5kqaby+q+9fNqgnM0k7nLnF5ar
         sWBP3HoY5Ytja+vx6ceQtCcWxHNvpTY1+E+Hib37yuLE2WxV2is0mE3y4IjOCeTTMa4L
         9Xjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zj4MyT2GnGW9BIQcjw7p8W05d+ybJ/CK98JufwkxSCs=;
        b=flySWt8w9ihPEhsn4nHNog61WDWnUOADq3n68t2G6GT281rnkBhXiq3545XaZc8OHI
         MHIhtEZjB3koCLqIulYt9R/el8CodZL4lGKPlrm/gwYTsR9uH60eey5BJXnI17p3WtZB
         IYI6dR9UT7WikYRFYWDuoWnGS+ken8ZmWAnrjilCUNR7ZufDCFGIz/7ic0C8O0TyintD
         XojG8Yvcr9PShRCHOoSgKXSSDEQmJCVif1XX4QWmYrMQ6ijcv/r8waxpgusJu5GBUmd2
         68e4tPXC/NDLzlpjWibpc1ecA6lCijRrXnYfv3Zwk8Gp5tmLOfrP/C0qZUQm1ROrggRZ
         cSjw==
X-Gm-Message-State: ANhLgQ1kLwXe1Tg1lFq7On2aEA/HNQPlW2ruM81Af4y3+BAcQf79qlSK
        1oWlsYOvielbO6cT80oduy+yGw==
X-Google-Smtp-Source: ADFU+vtLOg1ro3vhXOxvfzOLBKZd/KaioK5cWUvCfVUrtHYA7MwHf5cZTpLc4JInbeQ3qdAycxnyIw==
X-Received: by 2002:a92:ca8a:: with SMTP id t10mr15906729ilo.210.1583764790056;
        Mon, 09 Mar 2020 07:39:50 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f22sm7494502iof.37.2020.03.09.07.39.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2020 07:39:49 -0700 (PDT)
Subject: =?UTF-8?Q?Re=3a_=e2=9d=8c_FAIL=3a_Test_report_for_kernel_5=2e6=2e0-?=
 =?UTF-8?Q?rc4-61a0925=2ecki_=28mainline=2ekernel=2eorg=29?=
To:     Rachel Sibley <rasibley@redhat.com>, linux-block@vger.kernel.org
Cc:     CKI Project <cki-project@redhat.com>,
        Memory Management <mm-qe@redhat.com>,
        Jan Stancek <jstancek@redhat.com>,
        LTP Mailing List <ltp@lists.linux.it>,
        Xiong Zhou <xzhou@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>
References: <cki.FEFA879F6B.TFTZ93YIF0@redhat.com>
 <ba09351f-0a5a-824a-dbf2-021360581cd7@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <56ccdcb9-2090-b1eb-1acf-65279d0cb385@kernel.dk>
Date:   Mon, 9 Mar 2020 08:39:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <ba09351f-0a5a-824a-dbf2-021360581cd7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Adding Paolo

On 3/9/20 8:27 AM, Rachel Sibley wrote:
> (cc'ing linux-block@vger.kernel.org)
> 
> Hello,
> 
> We are seeing a kernel panic triggered with LTP and xfstests against a recent commit for mainline,
> wanted to share in case it's not already known.
> 
> Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>   Commit: 61a09258f2e5 - Merge tag 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma
> 
> We have also seen it with 2c523b344dfa and 378fee2e6b12 commits as well.
> 
> LTP: https://cki-artifacts.s3.us-east-2.amazonaws.com/datawarehouse/2020/03/08/477469/x86_64_1_console.log
> xfstests: https://cki-artifacts.s3.us-east-2.amazonaws.com/datawarehouse/2020/03/08/477469/x86_64_4_console.log
> 
> [-- MARK -- Sun Mar  8 02:45:00 2020]
> [  762.315610] BUG: kernel NULL pointer dereference, address: 0000000000000158
> [  762.323385] #PF: supervisor read access in kernel mode
> [  762.329119] #PF: error_code(0x0000) - not-present page
> [  762.334853] PGD 0 P4D 0
> [  762.337680] Oops: 0000 [#1] SMP PTI
> [  762.341575] CPU: 9 PID: 87 Comm: kworker/9:1 Not tainted 5.6.0-rc4-61a0925.cki #1
> [  762.349927] Hardware name: Cisco Systems, Inc. UCS-E160DP-M1/K9/UCS-E160DP-M1/K9, BIOS UCSED.1.5.0.2.051520131757 05/15/2013
> [  762.362453] Workqueue: cgroup_destroy css_killed_work_fn
> [  762.368387] RIP: 0010:bfq_bfqq_expire+0x1c/0x940
> [  762.373540] Code: 01 00 00 c7 80 f8 00 00 00 01 00 00 00 c3 66 66 66 66 90 41 57 41 56 41 55 41 54 41 89 cc 55 48 89 fd 53 48 89 f3 48 83 ec 28 
> <8b> be 58 01 00 00 65 48 8b 04 25 28 00 00 00 48 89 44 24 20 31 c0
> [  762.394500] RSP: 0018:ffff9927c03bbd50 EFLAGS: 00010086
> [  762.400331] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000004
> [  762.408301] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8965a3913800
> [  762.416270] RBP: ffff8965a3913800 R08: ffff896592d41098 R09: ffff89657aa8df00
> [  762.424233] R10: 0000000000000000 R11: ffff89657aa8df00 R12: 0000000000000004
> [  762.432200] R13: ffff89659f0cd9b0 R14: ffff8965a3913bf0 R15: ffff89659f0cd898
> [  762.440175] FS:  0000000000000000(0000) GS:ffff8965a7c40000(0000) knlGS:0000000000000000
> [  762.449211] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  762.455622] CR2: 0000000000000158 CR3: 000000065afc6003 CR4: 00000000000606e0
> [  762.463599] Call Trace:
> [  762.466341]  ? bfq_idle_extract+0x40/0xb0
> [  762.470821]  bfq_bfqq_move+0x14f/0x160
> [  762.475011]  bfq_pd_offline+0xd3/0xf0
> [  762.479112]  blkg_destroy+0x52/0xf0
> [  762.483005]  blkcg_destroy_blkgs+0x4f/0xa0
> [  762.487582]  css_killed_work_fn+0x4d/0xd0
> [  762.492066]  process_one_work+0x1b5/0x360
> [  762.496547]  worker_thread+0x50/0x3c0
> [  762.500641]  kthread+0xf9/0x130
> [  762.504153]  ? process_one_work+0x360/0x360
> [  762.508813]  ? kthread_park+0x90/0x90
> [  762.512909]  ret_from_fork+0x35/0x40
> 
> Thanks,
> Rachel
> 
> On 3/7/20 9:59 PM, CKI Project wrote:
>>
>> Hello,
>>
>> We ran automated tests on a recent commit from this kernel tree:
>>
>>         Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>              Commit: 61a09258f2e5 - Merge tag 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma
>>
>> The results of these automated tests are provided below.
>>
>>      Overall result: FAILED (see details below)
>>               Merge: OK
>>             Compile: OK
>>               Tests: FAILED
>>
>> All kernel binaries, config files, and logs are available for download here:
>>
>>    https://cki-artifacts.s3.us-east-2.amazonaws.com/index.html?prefix=datawarehouse/2020/03/08/477469
>>
>> One or more kernel tests failed:
>>
>>      x86_64:
>>       ❌ LTP
>>       ❌ xfstests - ext4
>>
>> We hope that these logs can help you find the problem quickly. For the full
>> detail on our testing procedures, please scroll to the bottom of this message.
>>
>> Please reply to this email if you have any questions about the tests that we
>> ran or if you have any suggestions on how to make future tests more effective.
>>
>>          ,-.   ,-.
>>         ( C ) ( K )  Continuous
>>          `-',-.`-'   Kernel
>>            ( I )     Integration
>>             `-'
>> ______________________________________________________________________________
>>
>> Compile testing
>> ---------------
>>
>> We compiled the kernel for 1 architecture:
>>
>>      x86_64:
>>        make options: -j30 INSTALL_MOD_STRIP=1 targz-pkg
>>
>>
>> Hardware testing
>> ----------------
>> We booted each kernel and ran the following tests:
>>
>>    x86_64:
>>      Host 1:
>>         ✅ Boot test
>>         ✅ Podman system integration test - as root
>>         ✅ Podman system integration test - as user
>>         ❌ LTP
>>         ⚡⚡⚡ Loopdev Sanity
>>         ⚡⚡⚡ Memory function: memfd_create
>>         ⚡⚡⚡ AMTU (Abstract Machine Test Utility)
>>         ⚡⚡⚡ Networking bridge: sanity
>>         ⚡⚡⚡ Ethernet drivers sanity
>>         ⚡⚡⚡ Networking MACsec: sanity
>>         ⚡⚡⚡ Networking socket: fuzz
>>         ⚡⚡⚡ Networking sctp-auth: sockopts test
>>         ⚡⚡⚡ Networking: igmp conformance test
>>         ⚡⚡⚡ Networking route: pmtu
>>         ⚡⚡⚡ Networking route_func - local
>>         ⚡⚡⚡ Networking route_func - forward
>>         ⚡⚡⚡ Networking TCP: keepalive test
>>         ⚡⚡⚡ Networking UDP: socket
>>         ⚡⚡⚡ Networking tunnel: geneve basic test
>>         ⚡⚡⚡ Networking tunnel: gre basic
>>         ⚡⚡⚡ L2TP basic test
>>         ⚡⚡⚡ Networking tunnel: vxlan basic
>>         ⚡⚡⚡ Networking ipsec: basic netns - transport
>>         ⚡⚡⚡ Networking ipsec: basic netns - tunnel
>>         ⚡⚡⚡ audit: audit testsuite test
>>         ⚡⚡⚡ httpd: mod_ssl smoke sanity
>>         ⚡⚡⚡ tuned: tune-processes-through-perf
>>         ⚡⚡⚡ pciutils: sanity smoke test
>>         ⚡⚡⚡ ALSA PCM loopback test
>>         ⚡⚡⚡ ALSA Control (mixer) Userspace Element test
>>         ⚡⚡⚡ storage: SCSI VPD
>>         ⚡⚡⚡ trace: ftrace/tracer
>>         🚧 ⚡⚡⚡ CIFS Connectathon
>>         🚧 ⚡⚡⚡ POSIX pjd-fstest suites
>>         🚧 ⚡⚡⚡ jvm - DaCapo Benchmark Suite
>>         🚧 ⚡⚡⚡ jvm - jcstress tests
>>         🚧 ⚡⚡⚡ Memory function: kaslr
>>         🚧 ⚡⚡⚡ LTP: openposix test suite
>>         🚧 ⚡⚡⚡ Networking vnic: ipvlan/basic
>>         🚧 ⚡⚡⚡ iotop: sanity
>>         🚧 ⚡⚡⚡ Usex - version 1.9-29
>>         🚧 ⚡⚡⚡ storage: dm/common
>>
>>      Host 2:
>>         ✅ Boot test
>>         ✅ Storage SAN device stress - mpt3sas driver
>>
>>      Host 3:
>>         ✅ Boot test
>>         ✅ Storage SAN device stress - megaraid_sas
>>
>>      Host 4:
>>         ✅ Boot test
>>         ❌ xfstests - ext4
>>         ⚡⚡⚡ xfstests - xfs
>>         ⚡⚡⚡ selinux-policy: serge-testsuite
>>         ⚡⚡⚡ lvm thinp sanity
>>         ⚡⚡⚡ storage: software RAID testing
>>         ⚡⚡⚡ stress: stress-ng
>>         🚧 ⚡⚡⚡ IOMMU boot test
>>         🚧 ⚡⚡⚡ IPMI driver test
>>         🚧 ⚡⚡⚡ IPMItool loop stress test
>>         🚧 ⚡⚡⚡ power-management: cpupower/sanity test
>>         🚧 ⚡⚡⚡ Storage blktests
>>
>>    Test sources: https://github.com/CKI-project/tests-beaker
>>      💚 Pull requests are welcome for new tests or improvements to existing tests!
>>
>> Waived tests
>> ------------
>> If the test run included waived tests, they are marked with 🚧. Such tests are
>> executed but their results are not taken into account. Tests are waived when
>> their results are not reliable enough, e.g. when they're just introduced or are
>> being fixed.
>>
>> Testing timeout
>> ---------------
>> We aim to provide a report within reasonable timeframe. Tests that haven't
>> finished running yet are marked with ⏱.
>>
>>
> 


-- 
Jens Axboe

