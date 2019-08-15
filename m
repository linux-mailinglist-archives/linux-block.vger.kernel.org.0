Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFDD8E363
	for <lists+linux-block@lfdr.de>; Thu, 15 Aug 2019 06:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbfHOEHq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 15 Aug 2019 00:07:46 -0400
Received: from bout01.mta.xmission.com ([166.70.11.15]:55824 "EHLO
        bout01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfHOEHp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Aug 2019 00:07:45 -0400
X-Greylist: delayed 350 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Aug 2019 00:07:45 EDT
Received: from mx04.mta.xmission.com ([166.70.13.214])
        by bout01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1hy73A-0004tc-VC; Wed, 14 Aug 2019 22:07:45 -0600
Received: from plesk14-shared.xmission.com ([166.70.198.161] helo=plesk14.xmission.com)
        by mx04.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1hy73A-0002wD-6o; Wed, 14 Aug 2019 22:07:44 -0600
Received: from hacktheplanet (unknown [8.25.222.2])
        by plesk14.xmission.com (Postfix) with ESMTPSA id C94F472909;
        Thu, 15 Aug 2019 04:07:43 +0000 (UTC)
Date:   Thu, 15 Aug 2019 00:07:41 -0400
From:   Scott Bauer <sbauer@plzdonthack.me>
To:     Revanth Rajashekar <revanth.rajashekar@intel.com>
Cc:     linux-block@vger.kernel.org,
        Jonathan Derrick <jonathan.derrick@intel.com>
Message-ID: <20190815040741.GC31938@hacktheplanet>
References: <20190813214340.15533-1-revanth.rajashekar@intel.com>
 <20190813214340.15533-4-revanth.rajashekar@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813214340.15533-4-revanth.rajashekar@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-XM-SPF: eid=1hy73A-0002wD-6o;;;mid=<20190815040741.GC31938@hacktheplanet>;;;hst=mx04.mta.xmission.com;;;ip=166.70.198.161;;;frm=sbauer@plzdonthack.me;;;spf=none
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
        *      [score: 0.4399]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.5 XM_UncommonTLD01 Less-common TLD
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Revanth Rajashekar <revanth.rajashekar@intel.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 258 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.8 (1.1%), b_tie_ro: 1.98 (0.8%), parse: 1.00
        (0.4%), extract_message_metadata: 15 (5.7%), get_uri_detail_list: 0.72
        (0.3%), tests_pri_-1000: 27 (10.5%), tests_pri_-950: 1.58 (0.6%),
        tests_pri_-900: 1.21 (0.5%), tests_pri_-90: 17 (6.5%), check_bayes: 15
        (5.9%), b_tokenize: 4.8 (1.9%), b_tok_get_all: 4.1 (1.6%),
        b_comp_prob: 1.78 (0.7%), b_tok_touch_all: 2.3 (0.9%), b_finish: 0.83
        (0.3%), tests_pri_0: 177 (68.7%), check_dkim_signature: 0.76 (0.3%),
        check_dkim_adsp: 3.8 (1.5%), poll_dns_idle: 0.86 (0.3%), tests_pri_10:
        2.2 (0.9%), tests_pri_500: 11 (4.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 3/3] block: sed-opal: OPAL_METHOD_LENGTH defined twice
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on mx04.mta.xmission.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 13, 2019 at 03:43:40PM -0600, Revanth Rajashekar wrote:
> Signed-off-by: Revanth Rajashekar <revanth.rajashekar@intel.com>
Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>

Two things,
Can we also change the title of this commit to:
"Removed duplicate OPAL_METHOD_LENGTH definition"
2nd, I'm dumb as hell now adays, why doesn't this throw a compiler error for multiple declarations?
