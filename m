Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F39214059
	for <lists+linux-block@lfdr.de>; Sun,  5 May 2019 16:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfEEOns (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 5 May 2019 10:43:48 -0400
Received: from bout01.mta.xmission.com ([166.70.11.15]:45475 "EHLO
        bout01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbfEEOns (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 5 May 2019 10:43:48 -0400
Received: from mx01.mta.xmission.com ([166.70.13.211])
        by bout01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1hNIMc-00042t-7p; Sun, 05 May 2019 08:43:38 -0600
Received: from plesk14-shared.xmission.com ([166.70.198.161] helo=plesk14.xmission.com)
        by mx01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1hNIMb-0007j9-Kk; Sun, 05 May 2019 08:43:38 -0600
Received: from hacktheplanet (c-68-50-23-202.hsd1.in.comcast.net [68.50.23.202])
        by plesk14.xmission.com (Postfix) with ESMTPSA id E6B3C1C5B9A;
        Sun,  5 May 2019 14:43:36 +0000 (UTC)
Date:   Sun, 5 May 2019 10:43:30 -0400
From:   Scott Bauer <sbauer@plzdonthack.me>
To:     David Kozub <zub@linux.fjfi.cvut.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Message-ID: <20190505144330.GB1030@hacktheplanet>
References: <1556666459-17948-1-git-send-email-zub@linux.fjfi.cvut.cz>
 <20190501134917.GC24132@infradead.org>
 <alpine.LRH.2.21.1905032058110.30331@linux.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.1905032058110.30331@linux.fjfi.cvut.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-XM-SPF: eid=1hNIMb-0007j9-Kk;;;mid=<20190505144330.GB1030@hacktheplanet>;;;hst=mx01.mta.xmission.com;;;ip=166.70.198.161;;;frm=sbauer@plzdonthack.me;;;spf=none
X-SA-Exim-Connect-IP: 166.70.198.161
X-SA-Exim-Mail-From: sbauer@plzdonthack.me
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong,XM_UncommonTLD01 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.5 XM_UncommonTLD01 Less-common TLD
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;David Kozub <zub@linux.fjfi.cvut.cz>
X-Spam-Relay-Country: 
X-Spam-Timing: total 399 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.1 (0.8%), b_tie_ro: 2.2 (0.5%), parse: 1.00
        (0.3%), extract_message_metadata: 4.0 (1.0%), get_uri_detail_list:
        1.36 (0.3%), tests_pri_-1000: 2.9 (0.7%), tests_pri_-950: 1.33 (0.3%),
        tests_pri_-900: 1.11 (0.3%), tests_pri_-90: 24 (6.1%), check_bayes: 23
        (5.7%), b_tokenize: 7 (1.8%), b_tok_get_all: 8 (1.9%), b_comp_prob:
        2.7 (0.7%), b_tok_touch_all: 3.2 (0.8%), b_finish: 0.64 (0.2%),
        tests_pri_0: 352 (88.0%), check_dkim_signature: 0.50 (0.1%),
        check_dkim_adsp: 7 (1.7%), poll_dns_idle: 0.55 (0.1%), tests_pri_10:
        2.2 (0.6%), tests_pri_500: 6 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/3] block: sed-opal: add support for shadow MBR done
 flag and write
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mx01.mta.xmission.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 03, 2019 at 10:32:19PM +0200, David Kozub wrote:
> On Wed, 1 May 2019, Christoph Hellwig wrote:
> 
> > > I successfully tested toggling the MBR done flag and writing the shadow MBR
> > > using some tools I hacked together[4] with a Samsung SSD 850 EVO drive.
> > 
> > Can you submit the tool to util-linux so that we get it into distros?
> 
> There is already Scott's sed-opal-temp[1] and a fork by Jonas that adds
> support for older version of these new IOCTLs[2]. There was already some
> discussion of getting that to util-linux.[3]
> 
> While I like my hack, sed-opal-temp can do much more (my tool supports just
> the few things I actually use). But there are two things which sed-opal-temp
> currently lacks which my hack has:
> 
> * It can use a PBKDF2 hash (salted by disk serial number) of the password
>   rather than the password directly. This makes it compatible with sedutil
>   and I think it's also better practice (as firmware can contain many
>   surprises).
> 
> * It contains a 'PBA' (pre-boot authorization) tool. A tool intended to be
>   run from shadow mbr that asks for a password and uses it to unlock all
>   disks and set shadow mbr done flag, so after restart the computer boots
>   into the real OS.
> 
> @Scott: What are your plans with sed-opal-temp? If you want I can update
> Jonas' patches to the adapted IOCTLs. What are your thoughts on PW hashing
> and a PBA tool?

I will accept any and all patches to sed opal tooling, I am not picky. I will
also give up maintainership of it is someone else feels they can (rightfully
so) do a better job.

Jon sent me a patch for the tool that will deal with writing to the shadow MBR,
so once we know these patches are going in i'll pull that patch into the tool.

Then I guess that leaves PBKDF2 which I don't think will be too hard to pull in.

With regard to your PBA tool, is that actually being run post-uefi/pre-linux?
IE are we writing your tool into the SMBR and that's what is being run on bootup?

Jon, if you think it's a good idea can you ask David if Revanth or you wants
to take over the tooling? Or if anyone else here wants to own it then let me know.

