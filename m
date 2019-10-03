Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10EBCCACAF
	for <lists+linux-block@lfdr.de>; Thu,  3 Oct 2019 19:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388583AbfJCQOX (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 3 Oct 2019 12:14:23 -0400
Received: from bout01.mta.xmission.com ([166.70.11.15]:50250 "EHLO
        bout01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388575AbfJCQOW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Oct 2019 12:14:22 -0400
Received: from mx01.mta.xmission.com ([166.70.13.211])
        by bout01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1iG3Dz-0007yB-3W; Thu, 03 Oct 2019 09:41:03 -0600
Received: from plesk14-shared.xmission.com ([166.70.198.161] helo=plesk14.xmission.com)
        by mx01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1iG3Dw-0003hb-Uu; Thu, 03 Oct 2019 09:41:03 -0600
Received: from hacktheplanet (c-68-50-34-150.hsd1.in.comcast.net [68.50.34.150])
        by plesk14.xmission.com (Postfix) with ESMTPSA id 47CDD1266F5;
        Thu,  3 Oct 2019 15:40:59 +0000 (UTC)
Date:   Thu, 3 Oct 2019 11:40:53 -0400
From:   Scott Bauer <sbauer@plzdonthack.me>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, axboe <axboe@kernel.dk>,
        Scott Bauer <sbauer@plzdonthack.me>,
        jonathan.derrick@intel.com, revanth.rajashekar@intel.com
Message-ID: <20191003154053.GA2450@hacktheplanet>
References: <82f70133-7242-d113-f041-9b89694685c0@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82f70133-7242-d113-f041-9b89694685c0@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-XM-SPF: eid=1iG3Dw-0003hb-Uu;;;mid=<20191003154053.GA2450@hacktheplanet>;;;hst=mx01.mta.xmission.com;;;ip=166.70.198.161;;;frm=sbauer@plzdonthack.me;;;spf=none
X-SA-Exim-Connect-IP: 166.70.198.161
X-SA-Exim-Mail-From: sbauer@plzdonthack.me
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMNoVowels,XMSubLong,XM_UncommonTLD01
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4787]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.5 XM_UncommonTLD01 Less-common TLD
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Randy Dunlap <rdunlap@infradead.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1998 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 2.7 (0.1%), b_tie_ro: 1.90 (0.1%), parse: 1.23
        (0.1%), extract_message_metadata: 27 (1.3%), get_uri_detail_list: 2.1
        (0.1%), tests_pri_-1000: 9 (0.5%), tests_pri_-950: 1.85 (0.1%),
        tests_pri_-900: 1.57 (0.1%), tests_pri_-90: 25 (1.2%), check_bayes: 23
        (1.2%), b_tokenize: 10 (0.5%), b_tok_get_all: 6 (0.3%), b_comp_prob:
        1.91 (0.1%), b_tok_touch_all: 2.3 (0.1%), b_finish: 0.63 (0.0%),
        tests_pri_0: 422 (21.1%), check_dkim_signature: 0.80 (0.0%),
        check_dkim_adsp: 57 (2.8%), poll_dns_idle: 1528 (76.5%), tests_pri_10:
        2.1 (0.1%), tests_pri_500: 1502 (75.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 2/2] block: sed-opal: fix sparse warning: convert __be64
 data
X-SA-Exim-Version: 4.2.1 (built Mon, 03 Jun 2019 09:49:16 -0600)
X-SA-Exim-Scanned: Yes (on mx01.mta.xmission.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 02, 2019 at 07:23:15PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> sparse warns about incorrect type when using __be64 data.
> It is not being converted to CPU-endian but it should be.
> 
> Fixes these sparse warnings:
> 
> ../block/sed-opal.c:375:20: warning: incorrect type in assignment (different base types)
> ../block/sed-opal.c:375:20:    expected unsigned long long [usertype] align
> ../block/sed-opal.c:375:20:    got restricted __be64 const [usertype] alignment_granularity
> ../block/sed-opal.c:376:25: warning: incorrect type in assignment (different base types)
> ../block/sed-opal.c:376:25:    expected unsigned long long [usertype] lowest_lba
> ../block/sed-opal.c:376:25:    got restricted __be64 const [usertype] lowest_aligned_lba
> 
> Fixes: 455a7b238cd6 ("block: Add Sed-opal library")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Scott Bauer <scott.bauer@intel.com>
> Cc: Rafael Antognolli <rafael.antognolli@intel.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-block@vger.kernel.org

+ Jon and Revanth,


These look fine. They're currently unused, but may be useful in the future for sysfs or what ever else we add in.
