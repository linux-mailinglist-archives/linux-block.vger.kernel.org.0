Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306476D9E24
	for <lists+linux-block@lfdr.de>; Thu,  6 Apr 2023 19:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239799AbjDFRGy (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 6 Apr 2023 13:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjDFRGx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 13:06:53 -0400
X-Greylist: delayed 437 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 06 Apr 2023 10:06:52 PDT
Received: from phd-imap.ethz.ch (phd-imap.ethz.ch [129.132.80.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6756183F2
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 10:06:52 -0700 (PDT)
Received: from localhost (192-168-127-49.net4.ethz.ch [192.168.127.49])
        by phd-imap.ethz.ch (Postfix) with ESMTP id 4Psnm55w08z33
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 18:59:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phys.ethz.ch;
        s=2023; t=1680800373;
        bh=nXGbb7hv01ZmxnY2hs860tFHyNVV12CQts9yOHXUbnA=;
        h=Date:From:To:Subject:Reply-To:From;
        b=YlAr2W6NXDVDuujIMDlTheiFAxMI3i081R45npN5SO/Fq/PiNagppt60EkSwM1MZy
         uGCBP1yXCFLM1lRNRfS9ELi8Oj5lRvTjYBHM3skYDdfXuWg5zwKcJWJ6PnVwsESQaF
         mTz/IaRTm9a5dJLSPiutd/rh04DSSyKEHJAJKTRnQLZYV2/pTeDowdH8qzdb5ImNjt
         MEPdVqtxocAW7wFgcxpQXJJRFGa76smpRjsWB7G2RA4cWUxymjRPHARx9R+ye+E/lu
         OTtw3vMDiAk1iiXdvEWY4ZaYERikCYdg5ZE0HHwsf6KV2oRF4zMevl+33F0sr27awA
         sFMMu+LcY0OMg==
X-Virus-Scanned: Debian amavisd-new at phys.ethz.ch
Received: from phd-mxin.ethz.ch ([192.168.127.53])
        by localhost (phd-mailscan.ethz.ch [192.168.127.49]) (amavisd-new, port 10024)
        with LMTP id yPmV3_Al3fDF for <linux-block@vger.kernel.org>;
        Thu,  6 Apr 2023 18:59:33 +0200 (CEST)
Received: from phys.ethz.ch (mothership.ethz.ch [192.33.96.20])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: daduke@phd-mxin.ethz.ch)
        by phd-mxin.ethz.ch (Postfix) with ESMTPSA id 4Psnm558FGz9r
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 18:59:33 +0200 (CEST)
Date:   Thu, 6 Apr 2023 18:59:32 +0200
From:   Christian Herzog <herzog@phys.ethz.ch>
To:     linux-block@vger.kernel.org
Subject: file server freezes with all nfsds stuck in D state after upgrade to
 Debian bookworm
Message-ID: <ZC76dIshWvaWlki4@phys.ethz.ch>
Reply-To: Christian Herzog <herzog@phys.ethz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Dear all,

disclaimer: this email was originally posted to linux-nfs since we believed
the problem to be nfsd, but Chuck Lever suggested that rq_qos_wait hinted at a
problem further down in the storage stack and referred to you guys, so here we
are:

for our researchers we are running file servers in the hundreds-of-TiB to
low-PiB range that export via NFS and SMB. Storage is iSCSI-over-Infiniband
LUNs LVM'ed into individual XFS file systems. With Ubuntu 18.04 nearing EOL,
we prepared an upgrade to Debian bookworm and tests went well. About a week
after one of the upgrades, we ran into the first occurence of our problem: all
of a sudden, all nfsds enter the D state and are not recoverable. However, the
underlying file systems seem fine and can be read and written to. The only way
out appears to be to reboot the server. The only clues are the frozen nfsds
and strack traces like

[<0>] rq_qos_wait+0xbc/0x130
[<0>] wbt_wait+0xa2/0x110
[<0>] __rq_qos_throttle+0x20/0x40
[<0>] blk_mq_submit_bio+0x2d3/0x580
[<0>] submit_bio_noacct_nocheck+0xf7/0x2c0
[<0>] iomap_submit_ioend+0x4b/0x80
[<0>] iomap_do_writepage+0x4b4/0x820
[<0>] write_cache_pages+0x180/0x4c0
[<0>] iomap_writepages+0x1c/0x40
[<0>] xfs_vm_writepages+0x79/0xb0 [xfs]
[<0>] do_writepages+0xbd/0x1c0
[<0>] filemap_fdatawrite_wbc+0x5f/0x80
[<0>] __filemap_fdatawrite_range+0x58/0x80
[<0>] file_write_and_wait_range+0x41/0x90
[<0>] xfs_file_fsync+0x5a/0x2a0 [xfs]
[<0>] nfsd_commit+0x93/0x190 [nfsd]
[<0>] nfsd4_commit+0x5e/0x90 [nfsd]
[<0>] nfsd4_proc_compound+0x352/0x660 [nfsd]
[<0>] nfsd_dispatch+0x167/0x280 [nfsd]
[<0>] svc_process_common+0x286/0x5e0 [sunrpc]
[<0>] svc_process+0xad/0x100 [sunrpc]
[<0>] nfsd+0xd5/0x190 [nfsd]
[<0>] kthread+0xe6/0x110
[<0>] ret_from_fork+0x1f/0x30

(we've also seen nfsd3). It's very sporadic, we have no idea what's triggering
it and it has now happened 4 times on one server and once on a second.
Needless to say, these are production systems, so we have a window of a few
minutes for debugging before people start yelling. We've thrown everything we
could at our test setup but so far haven't been able to trigger it.
Any pointers would be highly appreciated.


thanks and best regards,
-Christian



cat /etc/os-release 
PRETTY_NAME="Debian GNU/Linux 12 (bookworm)"

uname -vr
6.1.0-7-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.20-1 (2023-03-19)

apt list --installed '*nfs*'
libnfsidmap1/testing,now 1:2.6.2-4 amd64 [installed,automatic]
nfs-common/testing,now 1:2.6.2-4 amd64 [installed]
nfs-kernel-server/testing,now 1:2.6.2-4 amd64 [installed]

nfsconf -d
[exportd]
 debug = all
[exportfs]
 debug = all
[general]
 pipefs-directory = /run/rpc_pipefs
[lockd]
 port = 32769
 udp-port = 32769
[mountd]
 debug = all
 manage-gids = True
 port = 892
[nfsd]
 debug = all
 port = 2049
 threads = 48
[nfsdcld]
 debug = all
[nfsdcltrack]
 debug = all
[sm-notify]
 debug = all
 outgoing-port = 846
[statd]
 debug = all
 outgoing-port = 2020
 port = 662



-- 
Dr. Christian Herzog <herzog@phys.ethz.ch>  support: +41 44 633 26 68
Head, IT Services Group, HPT H 8              voice: +41 44 633 39 50
Department of Physics, ETH Zurich           
8093 Zurich, Switzerland                     http://isg.phys.ethz.ch/

----- End forwarded message -----

-- 
Dr. Christian Herzog <herzog@phys.ethz.ch>  support: +41 44 633 26 68
Head, IT Services Group, HPT H 8              voice: +41 44 633 39 50
Department of Physics, ETH Zurich           
8093 Zurich, Switzerland                     http://isg.phys.ethz.ch/
