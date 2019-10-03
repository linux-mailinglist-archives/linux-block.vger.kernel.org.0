Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBE2CA22A
	for <lists+linux-block@lfdr.de>; Thu,  3 Oct 2019 18:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbfJCQCd (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 3 Oct 2019 12:02:33 -0400
Received: from bout01.mta.xmission.com ([166.70.11.15]:49701 "EHLO
        bout01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732006AbfJCQCc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Oct 2019 12:02:32 -0400
X-Greylist: delayed 1285 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Oct 2019 12:02:31 EDT
Received: from mx04.mta.xmission.com ([166.70.13.214])
        by bout01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1iG3Ff-00086p-9O; Thu, 03 Oct 2019 09:42:47 -0600
Received: from plesk14-shared.xmission.com ([166.70.198.161] helo=plesk14.xmission.com)
        by mx04.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1iG3FP-0007KK-Lf; Thu, 03 Oct 2019 09:42:47 -0600
Received: from hacktheplanet (c-68-50-34-150.hsd1.in.comcast.net [68.50.34.150])
        by plesk14.xmission.com (Postfix) with ESMTPSA id A270F126779;
        Thu,  3 Oct 2019 15:42:28 +0000 (UTC)
Date:   Thu, 3 Oct 2019 11:42:27 -0400
From:   Scott Bauer <sbauer@plzdonthack.me>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, axboe <axboe@kernel.dk>,
        Scott Bauer <sbauer@plzdonthack.me>,
        jonathan.derrick@intel.com, revanth.rajashekar@intel.com
Message-ID: <20191003154227.GB2450@hacktheplanet>
References: <807d7b7f-623b-75f0-baab-13b1b0c02e9d@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <807d7b7f-623b-75f0-baab-13b1b0c02e9d@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-XM-SPF: eid=1iG3FP-0007KK-Lf;;;mid=<20191003154227.GB2450@hacktheplanet>;;;hst=mx04.mta.xmission.com;;;ip=166.70.198.161;;;frm=sbauer@plzdonthack.me;;;spf=none
X-SA-Exim-Connect-IP: 166.70.198.161
X-SA-Exim-Mail-From: sbauer@plzdonthack.me
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMNoVowels,XMSubLong,XM_UncommonTLD01
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4998]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.5 XM_UncommonTLD01 Less-common TLD
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Randy Dunlap <rdunlap@infradead.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15245 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.8 (0.0%), b_tie_ro: 2.0 (0.0%), parse: 1.01
        (0.0%), extract_message_metadata: 22 (0.1%), get_uri_detail_list: 1.54
        (0.0%), tests_pri_-1000: 3.3 (0.0%), tests_pri_-950: 1.04 (0.0%),
        tests_pri_-900: 0.84 (0.0%), tests_pri_-90: 16 (0.1%), check_bayes: 15
        (0.1%), b_tokenize: 4.3 (0.0%), b_tok_get_all: 5.0 (0.0%),
        b_comp_prob: 1.18 (0.0%), b_tok_touch_all: 2.7 (0.0%), b_finish: 0.64
        (0.0%), tests_pri_0: 6303 (41.3%), check_dkim_signature: 0.35 (0.0%),
        check_dkim_adsp: 6140 (40.3%), poll_dns_idle: 14983 (98.3%),
        tests_pri_10: 1.63 (0.0%), tests_pri_500: 8891 (58.3%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH 1/2] block: sed-opal: fix sparse warning: obsolete array
 init.
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on mx04.mta.xmission.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 02, 2019 at 07:23:05PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix sparse warning: (missing '=')
> ../block/sed-opal.c:133:17: warning: obsolete array initializer, use C99 syntax
> 
> Fixes: ff91064ea37c ("block: sed-opal: check size of shadow mbr")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-block@vger.kernel.org
> Cc: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> Cc: David Kozub <zub@linux.fjfi.cvut.cz>
> ---

Un cc'd David and Jonas, +CC'd Jon and Revanth.

This looks fine to me too.

Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>
