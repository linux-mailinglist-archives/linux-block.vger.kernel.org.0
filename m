Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE8914042
	for <lists+linux-block@lfdr.de>; Sun,  5 May 2019 16:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbfEEO13 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 5 May 2019 10:27:29 -0400
Received: from bout01.mta.xmission.com ([166.70.11.15]:44595 "EHLO
        bout01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbfEEO12 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 5 May 2019 10:27:28 -0400
Received: from mx03.mta.xmission.com ([166.70.13.213])
        by bout01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1hNI6x-0002sR-Ec; Sun, 05 May 2019 08:27:27 -0600
Received: from plesk14-shared.xmission.com ([166.70.198.161] helo=plesk14.xmission.com)
        by mx03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1hNI6w-0003Fn-Ri; Sun, 05 May 2019 08:27:27 -0600
Received: from hacktheplanet (c-68-50-23-202.hsd1.in.comcast.net [68.50.23.202])
        by plesk14.xmission.com (Postfix) with ESMTPSA id 297B01C585B;
        Sun,  5 May 2019 14:27:26 +0000 (UTC)
Date:   Sun, 5 May 2019 10:27:15 -0400
From:   Scott Bauer <sbauer@plzdonthack.me>
To:     David Kozub <zub@linux.fjfi.cvut.cz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Message-ID: <20190505142715.GA1030@hacktheplanet>
References: <1556666459-17948-1-git-send-email-zub@linux.fjfi.cvut.cz>
 <1556666459-17948-4-git-send-email-zub@linux.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556666459-17948-4-git-send-email-zub@linux.fjfi.cvut.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-XM-SPF: eid=1hNI6w-0003Fn-Ri;;;mid=<20190505142715.GA1030@hacktheplanet>;;;hst=mx03.mta.xmission.com;;;ip=166.70.198.161;;;frm=sbauer@plzdonthack.me;;;spf=none
X-SA-Exim-Connect-IP: 166.70.198.161
X-SA-Exim-Mail-From: sbauer@plzdonthack.me
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XM_UncommonTLD01 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.5 XM_UncommonTLD01 Less-common TLD
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;David Kozub <zub@linux.fjfi.cvut.cz>
X-Spam-Relay-Country: 
X-Spam-Timing: total 341 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 3.4 (1.0%), b_tie_ro: 2.4 (0.7%), parse: 1.16
        (0.3%), extract_message_metadata: 24 (7.1%), get_uri_detail_list: 1.17
        (0.3%), tests_pri_-1000: 37 (10.7%), tests_pri_-950: 1.36 (0.4%),
        tests_pri_-900: 1.09 (0.3%), tests_pri_-90: 18 (5.3%), check_bayes: 16
        (4.8%), b_tokenize: 5 (1.5%), b_tok_get_all: 5.0 (1.5%), b_comp_prob:
        1.75 (0.5%), b_tok_touch_all: 2.6 (0.8%), b_finish: 0.65 (0.2%),
        tests_pri_0: 240 (70.3%), check_dkim_signature: 0.55 (0.2%),
        check_dkim_adsp: 2.2 (0.7%), poll_dns_idle: 0.52 (0.2%), tests_pri_10:
        3.2 (0.9%), tests_pri_500: 9 (2.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 3/3] block: sed-opal: check size of shadow mbr
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on mx03.mta.xmission.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 01, 2019 at 01:20:59AM +0200, David Kozub wrote:
> From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> 
> Check whether the shadow mbr does fit in the provided space on the
> target. Also a proper firmware should handle this case and return an
> error we may prevent problems or even damage with crappy firmwares.
> 
> Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> Signed-off-by: David Kozub <zub@linux.fjfi.cvut.cz>
> Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>
> Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>
re-reviewed and looks fine again: Scott Bauer <sbauer@plzdonthack.me>
