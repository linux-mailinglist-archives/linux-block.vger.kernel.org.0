Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD36E25CEED
	for <lists+linux-block@lfdr.de>; Fri,  4 Sep 2020 03:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbgIDBCw (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 3 Sep 2020 21:02:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43062 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728582AbgIDBCv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Sep 2020 21:02:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599181369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jrZRVZw001W6wwdonr0HEyKZabnRI5c6ai5SCBul9go=;
        b=F4Uay0hwC9siZEHfgXipSc4+WE+/xYiVmfSuzJ5AA6SFYNvHStzEieTI95u/pucaMcGPC+
        uW4T3IhTJ0phTXDOdhVSycraPSDvWHqNSWOrQ3CPwxHb/FjogWdgQhg5p5tDu3a4skcLmv
        xLgBIiTs61KLqzyMXgva2ZOHB0AsIrg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-3gzsoWTnP_y1ctqzRy80RQ-1; Thu, 03 Sep 2020 21:02:46 -0400
X-MC-Unique: 3gzsoWTnP_y1ctqzRy80RQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73D4D425DE;
        Fri,  4 Sep 2020 01:02:45 +0000 (UTC)
Received: from T590 (ovpn-12-109.pek2.redhat.com [10.72.12.109])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B5131A92A;
        Fri,  4 Sep 2020 01:02:37 +0000 (UTC)
Date:   Fri, 4 Sep 2020 09:02:33 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     CKI Project <cki-project@redhat.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        Changhui Zhong <czhong@redhat.com>
Subject: Re: =?utf-8?B?8J+SpSBQQU5JQ0tFRA==?= =?utf-8?Q?=3A?= Test report for
 kernel 5.9.0-rc3-020ad03.cki (block)
Message-ID: <20200904010233.GA817918@T590>
References: <cki.538AE6A321.BMB0X5ZYG5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cki.538AE6A321.BMB0X5ZYG5@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 03, 2020 at 05:07:57PM -0000, CKI Project wrote:
> 
> Hello,
> 
> We ran automated tests on a recent commit from this kernel tree:
> 
>        Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>             Commit: 020ad0333b03 - Merge branch 'for-5.10/block' into for-next
> 
> The results of these automated tests are provided below.
> 
>     Overall result: FAILED (see details below)
>              Merge: OK
>            Compile: OK
>              Tests: PANICKED
> 
> All kernel binaries, config files, and logs are available for download here:
> 
>   https://cki-artifacts.s3.us-east-2.amazonaws.com/index.html?prefix=datawarehouse/2020/09/02/613166
> 
> One or more kernel tests failed:
> 
>     ppc64le:
>      💥 storage: software RAID testing
> 
>     aarch64:
>      💥 storage: software RAID testing
> 
>     x86_64:
>      💥 storage: software RAID testing
> 
> We hope that these logs can help you find the problem quickly. For the full
> detail on our testing procedures, please scroll to the bottom of this message.
> 
> Please reply to this email if you have any questions about the tests that we
> ran or if you have any suggestions on how to make future tests more effective.
> 
>         ,-.   ,-.
>        ( C ) ( K )  Continuous
>         `-',-.`-'   Kernel
>           ( I )     Integration
>            `-'
> ______________________________________________________________________________
> 
> Compile testing
> ---------------
> 
> We compiled the kernel for 4 architectures:
> 
>     aarch64:
>       make options: make -j30 INSTALL_MOD_STRIP=1 targz-pkg
> 
>     ppc64le:
>       make options: make -j30 INSTALL_MOD_STRIP=1 targz-pkg
> 
>     s390x:
>       make options: make -j30 INSTALL_MOD_STRIP=1 targz-pkg
> 
>     x86_64:
>       make options: make -j30 INSTALL_MOD_STRIP=1 targz-pkg
> 
> 
> 
> Hardware testing
> ----------------
> We booted each kernel and ran the following tests:
> 
>   aarch64:
>     Host 1:
>        ✅ Boot test
>        ✅ ACPI table test
>        ✅ LTP
>        ✅ Loopdev Sanity
>        ✅ Memory function: memfd_create
>        ✅ AMTU (Abstract Machine Test Utility)
>        ✅ Ethernet drivers sanity
>        ✅ storage: SCSI VPD
>        🚧 ✅ CIFS Connectathon
>        🚧 ✅ POSIX pjd-fstest suites
> 
>     Host 2:
> 
>        ⚡ Internal infrastructure issues prevented one or more tests (marked
>        with ⚡⚡⚡) from running on this architecture.
>        This is not the fault of the kernel that was tested.
> 
>        ⚡⚡⚡ Boot test
>        ⚡⚡⚡ xfstests - ext4
>        ⚡⚡⚡ xfstests - xfs
>        ⚡⚡⚡ storage: software RAID testing
>        ⚡⚡⚡ stress: stress-ng
>        🚧 ⚡⚡⚡ xfstests - btrfs
>        🚧 ⚡⚡⚡ Storage blktests
> 
>     Host 3:
>        ✅ Boot test
>        ✅ xfstests - ext4
>        ✅ xfstests - xfs
>        💥 storage: software RAID testing
>        ⚡⚡⚡ stress: stress-ng
>        🚧 ⚡⚡⚡ xfstests - btrfs
>        🚧 ⚡⚡⚡ Storage blktests
> 
>   ppc64le:
>     Host 1:
>        ✅ Boot test
>        🚧 ✅ kdump - sysrq-c
> 
>     Host 2:
>        ✅ Boot test
>        ✅ xfstests - ext4
>        ✅ xfstests - xfs
>        💥 storage: software RAID testing
>        🚧 ⚡⚡⚡ xfstests - btrfs
>        🚧 ⚡⚡⚡ Storage blktests
> 
>     Host 3:
> 
>        ⚡ Internal infrastructure issues prevented one or more tests (marked
>        with ⚡⚡⚡) from running on this architecture.
>        This is not the fault of the kernel that was tested.
> 
>        ✅ Boot test
>        ⚡⚡⚡ LTP
>        ⚡⚡⚡ Loopdev Sanity
>        ⚡⚡⚡ Memory function: memfd_create
>        ⚡⚡⚡ AMTU (Abstract Machine Test Utility)
>        ⚡⚡⚡ Ethernet drivers sanity
>        🚧 ⚡⚡⚡ CIFS Connectathon
>        🚧 ⚡⚡⚡ POSIX pjd-fstest suites
> 
>   s390x:
>     Host 1:
>        ✅ Boot test
>        ✅ stress: stress-ng
>        🚧 ✅ Storage blktests
> 
>     Host 2:
>        ✅ Boot test
>        ✅ LTP
>        ✅ Loopdev Sanity
>        ✅ Memory function: memfd_create
>        ✅ AMTU (Abstract Machine Test Utility)
>        ✅ Ethernet drivers sanity
>        🚧 ✅ CIFS Connectathon
>        🚧 ✅ POSIX pjd-fstest suites
> 
>   x86_64:
>     Host 1:
>        ✅ Boot test
>        ✅ Storage SAN device stress - qedf driver
> 
>     Host 2:
>        ⏱  Boot test
>        ⏱  Storage SAN device stress - mpt3sas_gen1
> 
>     Host 3:
>        ✅ Boot test
>        ✅ xfstests - ext4
>        ✅ xfstests - xfs
>        💥 storage: software RAID testing
>        ⚡⚡⚡ stress: stress-ng
>        🚧 ⚡⚡⚡ xfstests - btrfs
>        🚧 ⚡⚡⚡ Storage blktests
> 
>     Host 4:
>        ✅ Boot test
>        ✅ Storage SAN device stress - lpfc driver
> 
>     Host 5:
>        ✅ Boot test
>        🚧 ✅ kdump - sysrq-c
> 
>     Host 6:
>        ✅ Boot test
>        ✅ ACPI table test
>        ✅ LTP
>        ✅ Loopdev Sanity
>        ✅ Memory function: memfd_create
>        ✅ AMTU (Abstract Machine Test Utility)
>        ✅ Ethernet drivers sanity
>        ✅ kernel-rt: rt_migrate_test
>        ✅ kernel-rt: rteval
>        ✅ kernel-rt: sched_deadline
>        ✅ kernel-rt: smidetect
>        ✅ storage: SCSI VPD
>        🚧 ✅ CIFS Connectathon
>        🚧 ✅ POSIX pjd-fstest suites
> 
>     Host 7:
>        ✅ Boot test
>        ✅ kdump - sysrq-c - megaraid_sas
> 
>     Host 8:
>        ✅ Boot test
>        ✅ Storage SAN device stress - qla2xxx driver
> 
>     Host 9:
>        ⏱  Boot test
>        ⏱  kdump - sysrq-c - mpt3sas_gen1
> 
>   Test sources: https://gitlab.com/cki-project/kernel-tests

Hello,

Can you share us the exact commands for setting up xfstests over
'software RAID testing' from the above tree?

BTW I can't reproduce it by running xfstest generic/551 on my simple raid10
settings, include raid stop/remove steps.

Thanks,
Ming

