Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D03B1401E
	for <lists+linux-block@lfdr.de>; Sun,  5 May 2019 16:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfEEOQW (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 5 May 2019 10:16:22 -0400
Received: from bout01.mta.xmission.com ([166.70.11.15]:43818 "EHLO
        bout01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfEEOQW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 5 May 2019 10:16:22 -0400
Received: from mx04.mta.xmission.com ([166.70.13.214])
        by bout01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1hNHwA-0001vp-Qa; Sun, 05 May 2019 08:16:19 -0600
Received: from plesk14-shared.xmission.com ([166.70.198.161] helo=plesk14.xmission.com)
        by mx04.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1hNHw9-0007RB-HU; Sun, 05 May 2019 08:16:18 -0600
Received: from hacktheplanet (c-68-50-23-202.hsd1.in.comcast.net [68.50.23.202])
        by plesk14.xmission.com (Postfix) with ESMTPSA id E79F71C556F;
        Sun,  5 May 2019 14:16:15 +0000 (UTC)
Date:   Sun, 5 May 2019 10:16:04 -0400
From:   Scott Bauer <sbauer@plzdonthack.me>
To:     David Kozub <zub@linux.fjfi.cvut.cz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Message-ID: <20190505141604.GA956@hacktheplanet>
References: <1556666459-17948-1-git-send-email-zub@linux.fjfi.cvut.cz>
 <1556666459-17948-2-git-send-email-zub@linux.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556666459-17948-2-git-send-email-zub@linux.fjfi.cvut.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-XM-SPF: eid=1hNHw9-0007RB-HU;;;mid=<20190505141604.GA956@hacktheplanet>;;;hst=mx04.mta.xmission.com;;;ip=166.70.198.161;;;frm=sbauer@plzdonthack.me;;;spf=none
X-SA-Exim-Connect-IP: 166.70.198.161
X-SA-Exim-Mail-From: sbauer@plzdonthack.me
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
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
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.5 XM_UncommonTLD01 Less-common TLD
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;David Kozub <zub@linux.fjfi.cvut.cz>
X-Spam-Relay-Country: 
X-Spam-Timing: total 610 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.6 (0.6%), b_tie_ro: 2.5 (0.4%), parse: 1.17
        (0.2%), extract_message_metadata: 24 (3.9%), get_uri_detail_list: 1.37
        (0.2%), tests_pri_-1000: 26 (4.3%), tests_pri_-950: 1.44 (0.2%),
        tests_pri_-900: 1.11 (0.2%), tests_pri_-90: 19 (3.0%), check_bayes: 17
        (2.8%), b_tokenize: 6 (0.9%), b_tok_get_all: 4.9 (0.8%), b_comp_prob:
        1.81 (0.3%), b_tok_touch_all: 2.6 (0.4%), b_finish: 0.72 (0.1%),
        tests_pri_0: 485 (79.5%), check_dkim_signature: 0.72 (0.1%),
        check_dkim_adsp: 24 (3.9%), poll_dns_idle: 52 (8.6%), tests_pri_10:
        4.6 (0.8%), tests_pri_500: 42 (6.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/3] block: sed-opal: add ioctl for done-mark of shadow
 mbr
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on mx04.mta.xmission.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 01, 2019 at 01:20:57AM +0200, David Kozub wrote:
> From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> 
> Enable users to mark the shadow mbr as done without completely
> deactivating the shadow mbr feature. This may be useful on reboots,
> when the power to the disk is not disconnected in between and the shadow
> mbr stores the required boot files. Of course, this saves also the
> (few) commands required to enable the feature if it is already enabled
> and one only wants to mark the shadow mbr as done.
> 
> Co-authored-by: David Kozub <zub@linux.fjfi.cvut.cz>
> Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> Signed-off-by: David Kozub <zub@linux.fjfi.cvut.cz>
Looks fine.
Reviewed by: Scott Bauer <sbauer@plzdonthack.me>
