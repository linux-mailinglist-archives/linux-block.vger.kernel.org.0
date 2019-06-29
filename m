Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2847F5AC8E
	for <lists+linux-block@lfdr.de>; Sat, 29 Jun 2019 18:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfF2Q3S (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 29 Jun 2019 12:29:18 -0400
Received: from bout01.mta.xmission.com ([166.70.11.15]:49497 "EHLO
        bout01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfF2Q3S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Jun 2019 12:29:18 -0400
Received: from mx01.mta.xmission.com ([166.70.13.211])
        by bout01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1hhG56-0007Mh-5o; Sat, 29 Jun 2019 10:20:04 -0600
Received: from plesk14-shared.xmission.com ([166.70.198.161] helo=plesk14.xmission.com)
        by mx01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1hhG55-0001fp-KZ; Sat, 29 Jun 2019 10:20:04 -0600
Received: from hacktheplanet (unknown [73.58.156.118])
        by plesk14.xmission.com (Postfix) with ESMTPSA id 6A5A7193226;
        Sat, 29 Jun 2019 16:20:02 +0000 (UTC)
Date:   Sat, 29 Jun 2019 12:19:55 -0400
From:   Scott Bauer <sbauer@plzdonthack.me>
To:     axboe@kernel.dk
Cc:     jonathan.derrick@intel.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zub@linux.fjfi.cvut.cz" <zub@linux.fjfi.cvut.cz>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "jonas.rabenstein@studium.uni-erlangen.de" 
        <jonas.rabenstein@studium.uni-erlangen.de>
Message-ID: <20190629161947.GA20127@hacktheplanet>
References: <1558471606-25139-1-git-send-email-zub@linux.fjfi.cvut.cz>
 <7ee5d705c12d770bf7566bce7d664bf733b25206.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ee5d705c12d770bf7566bce7d664bf733b25206.camel@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-XM-SPF: eid=1hhG55-0001fp-KZ;;;mid=<20190629161947.GA20127@hacktheplanet>;;;hst=mx01.mta.xmission.com;;;ip=166.70.198.161;;;frm=sbauer@plzdonthack.me;;;spf=none
X-SA-Exim-Connect-IP: 166.70.198.161
X-SA-Exim-Mail-From: sbauer@plzdonthack.me
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong,
        XM_UncommonTLD01 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4284]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.5 XM_UncommonTLD01 Less-common TLD
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;axboe@kernel.dk
X-Spam-Relay-Country: 
X-Spam-Timing: total 405 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.1 (0.5%), b_tie_ro: 1.43 (0.4%), parse: 0.97
        (0.2%), extract_message_metadata: 13 (3.3%), get_uri_detail_list: 1.51
        (0.4%), tests_pri_-1000: 11 (2.7%), tests_pri_-950: 1.03 (0.3%),
        tests_pri_-900: 0.81 (0.2%), tests_pri_-90: 22 (5.5%), check_bayes: 21
        (5.1%), b_tokenize: 8 (2.0%), b_tok_get_all: 6 (1.5%), b_comp_prob:
        2.3 (0.6%), b_tok_touch_all: 2.8 (0.7%), b_finish: 0.59 (0.1%),
        tests_pri_0: 344 (85.0%), check_dkim_signature: 0.45 (0.1%),
        check_dkim_adsp: 152 (37.5%), poll_dns_idle: 149 (36.7%),
        tests_pri_10: 1.73 (0.4%), tests_pri_500: 5 (1.2%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [PATCH v2 0/3] block: sed-opal: add support for shadow MBR done
 flag and write
X-SA-Exim-Version: 4.2.1 (built Mon, 03 Jun 2019 09:49:16 -0600)
X-SA-Exim-Scanned: Yes (on mx01.mta.xmission.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Hey Jens,

Can you please stage these for 5.3 aswell?


On Tue, Jun 25, 2019 at 08:47:26PM +0000, Derrick, Jonathan wrote:
> These are still good with me and we'll likely have a similar future use
> for passing data through the ioctl.
> 
> Could we get this staged for 5.3?
> 
> On Tue, 2019-05-21 at 22:46 +0200, David Kozub wrote:
> > This patch series extends SED Opal support: it adds IOCTL for setting the shadow
> > MBR done flag which can be useful for unlocking an Opal disk on boot and it adds
> > IOCTL for writing to the shadow MBR.
> > 
> > This applies on current master.
> > 
> > I successfully tested toggling the MBR done flag and writing the shadow MBR
> > using some tools I hacked together[1] with a Samsung SSD 850 EVO drive.
> > 
> > Changes from v1:
> > * PATCH 2/3: remove check with access_ok, just rely on copy_from_user as
> > suggested in [2] (I tested passing data == 0 and I got the expected EFAULT)
> > 
> > [1] https://gitlab.com/zub2/opalctl
> > [2] https://lore.kernel.org/lkml/20190501134833.GB24132@infradead.org/
> > 
> > Jonas Rabenstein (3):
> >   block: sed-opal: add ioctl for done-mark of shadow mbr
> >   block: sed-opal: ioctl for writing to shadow mbr
> >   block: sed-opal: check size of shadow mbr
> > 
> >  block/opal_proto.h            |  16 ++++
> >  block/sed-opal.c              | 157 +++++++++++++++++++++++++++++++++-
> >  include/linux/sed-opal.h      |   2 +
> >  include/uapi/linux/sed-opal.h |  20 +++++
> >  4 files changed, 193 insertions(+), 2 deletions(-)
> > 


