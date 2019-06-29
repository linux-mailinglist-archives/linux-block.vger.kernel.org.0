Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59D0C5AC94
	for <lists+linux-block@lfdr.de>; Sat, 29 Jun 2019 18:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfF2Qho (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 29 Jun 2019 12:37:44 -0400
Received: from bout01.mta.xmission.com ([166.70.11.15]:49749 "EHLO
        bout01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfF2Qho (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Jun 2019 12:37:44 -0400
Received: from mx02.mta.xmission.com ([166.70.13.212])
        by bout01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1hhGM8-0008Vd-Kr; Sat, 29 Jun 2019 10:37:40 -0600
Received: from plesk14-shared.xmission.com ([166.70.198.161] helo=plesk14.xmission.com)
        by mx02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1hhGM7-0000gT-Tq; Sat, 29 Jun 2019 10:37:40 -0600
Received: from hacktheplanet (c-68-50-34-150.hsd1.in.comcast.net [68.50.34.150])
        by plesk14.xmission.com (Postfix) with ESMTPSA id 2E121193879;
        Sat, 29 Jun 2019 16:37:39 +0000 (UTC)
Date:   Sat, 29 Jun 2019 12:37:37 -0400
From:   Scott Bauer <sbauer@plzdonthack.me>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     jonathan.derrick@intel.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zub@linux.fjfi.cvut.cz" <zub@linux.fjfi.cvut.cz>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "jonas.rabenstein@studium.uni-erlangen.de" 
        <jonas.rabenstein@studium.uni-erlangen.de>
Message-ID: <20190629163737.GB21042@hacktheplanet>
References: <1558471606-25139-1-git-send-email-zub@linux.fjfi.cvut.cz>
 <7ee5d705c12d770bf7566bce7d664bf733b25206.camel@intel.com>
 <20190629161947.GA20127@hacktheplanet>
 <d3074ee1-0506-511d-c29c-44effb4eda97@kernel.dk>
 <20190629162835.GA21042@hacktheplanet>
 <cb37028f-bff9-92a6-4ecd-efe938274d24@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb37028f-bff9-92a6-4ecd-efe938274d24@kernel.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-XM-SPF: eid=1hhGM7-0000gT-Tq;;;mid=<20190629163737.GB21042@hacktheplanet>;;;hst=mx02.mta.xmission.com;;;ip=166.70.198.161;;;frm=sbauer@plzdonthack.me;;;spf=none
X-SA-Exim-Connect-IP: 166.70.198.161
X-SA-Exim-Mail-From: sbauer@plzdonthack.me
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=8.0 tests=ALL_TRUSTED,BAYES_40,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong,
        XM_UncommonTLD01 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.2905]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.5 XM_UncommonTLD01 Less-common TLD
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Jens Axboe <axboe@kernel.dk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 251 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 2.5 (1.0%), b_tie_ro: 1.72 (0.7%), parse: 0.93
        (0.4%), extract_message_metadata: 3.4 (1.4%), get_uri_detail_list:
        0.67 (0.3%), tests_pri_-1000: 3.1 (1.2%), tests_pri_-950: 1.40 (0.6%),
        tests_pri_-900: 1.18 (0.5%), tests_pri_-90: 19 (7.4%), check_bayes: 17
        (6.8%), b_tokenize: 5 (2.1%), b_tok_get_all: 5 (2.1%), b_comp_prob:
        1.78 (0.7%), b_tok_touch_all: 2.6 (1.0%), b_finish: 0.61 (0.2%),
        tests_pri_0: 209 (83.4%), check_dkim_signature: 0.58 (0.2%),
        check_dkim_adsp: 7 (2.8%), poll_dns_idle: 0.51 (0.2%), tests_pri_10:
        2.3 (0.9%), tests_pri_500: 6 (2.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 0/3] block: sed-opal: add support for shadow MBR done
 flag and write
X-SA-Exim-Version: 4.2.1 (built Mon, 03 Jun 2019 09:49:16 -0600)
X-SA-Exim-Scanned: Yes (on mx02.mta.xmission.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

e1;5202;0csOn Sat, Jun 29, 2019 at 10:35:30AM -0600, Jens Axboe wrote:
> On 6/29/19 10:28 AM, Scott Bauer wrote:
> > On Sat, Jun 29, 2019 at 10:26:52AM -0600, Jens Axboe wrote:
> >> On 6/29/19 10:19 AM, Scott Bauer wrote:
> >>>
> >>> Hey Jens,
> >>>
> >>> Can you please stage these for 5.3 aswell?
> >>
> >> Yes, looks fine to me. But it conflicts with the psid revert in terms
> >> of ioctl numbering. You fine with me renumbering IOC_OPAL_MBR_DONE to:
> >>
> >> #define IOC_OPAL_MBR_DONE           _IOW('p', 233, struct opal_mbr_done)
> > 
> > Sorry for the conflict. That's fine. I'll fix up userland tooling.
> 
> Renamed 232 -> 233, and 233 -> 234, for the two conflicts. So now we have:
> 
> #define IOC_OPAL_PSID_REVERT_TPR    _IOW('p', 232, struct opal_key)
> #define IOC_OPAL_MBR_DONE           _IOW('p', 233, struct opal_mbr_done)
> #define IOC_OPAL_WRITE_SHADOW_MBR   _IOW('p', 234, struct opal_shadow_mbr)

Looks good, thank you for handling this.
