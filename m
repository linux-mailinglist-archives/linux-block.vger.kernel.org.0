Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41CB314037
	for <lists+linux-block@lfdr.de>; Sun,  5 May 2019 16:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbfEEOWh (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 5 May 2019 10:22:37 -0400
Received: from bout01.mta.xmission.com ([166.70.11.15]:44255 "EHLO
        bout01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfEEOWh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 5 May 2019 10:22:37 -0400
Received: from mx01.mta.xmission.com ([166.70.13.211])
        by bout01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1hNI2F-0002Qo-PE; Sun, 05 May 2019 08:22:35 -0600
Received: from plesk14-shared.xmission.com ([166.70.198.161] helo=plesk14.xmission.com)
        by mx01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1hNI25-0000T0-9t; Sun, 05 May 2019 08:22:35 -0600
Received: from hacktheplanet (c-68-50-23-202.hsd1.in.comcast.net [68.50.23.202])
        by plesk14.xmission.com (Postfix) with ESMTPSA id 6186C1C56E6;
        Sun,  5 May 2019 14:22:24 +0000 (UTC)
Date:   Sun, 5 May 2019 10:22:17 -0400
From:   Scott Bauer <sbauer@plzdonthack.me>
To:     David Kozub <zub@linux.fjfi.cvut.cz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Message-ID: <20190505142217.GB956@hacktheplanet>
References: <1556666459-17948-1-git-send-email-zub@linux.fjfi.cvut.cz>
 <1556666459-17948-3-git-send-email-zub@linux.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556666459-17948-3-git-send-email-zub@linux.fjfi.cvut.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-XM-SPF: eid=1hNI25-0000T0-9t;;;mid=<20190505142217.GB956@hacktheplanet>;;;hst=mx01.mta.xmission.com;;;ip=166.70.198.161;;;frm=sbauer@plzdonthack.me;;;spf=none
X-SA-Exim-Connect-IP: 166.70.198.161
X-SA-Exim-Mail-From: sbauer@plzdonthack.me
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong,XM_UncommonTLD01 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.5 XM_UncommonTLD01 Less-common TLD
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;David Kozub <zub@linux.fjfi.cvut.cz>
X-Spam-Relay-Country: 
X-Spam-Timing: total 10305 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.7 (0.0%), b_tie_ro: 1.96 (0.0%), parse: 0.99
        (0.0%), extract_message_metadata: 20 (0.2%), get_uri_detail_list: 1.39
        (0.0%), tests_pri_-1000: 9 (0.1%), tests_pri_-950: 0.99 (0.0%),
        tests_pri_-900: 0.82 (0.0%), tests_pri_-90: 16 (0.2%), check_bayes: 14
        (0.1%), b_tokenize: 4.1 (0.0%), b_tok_get_all: 4.8 (0.0%),
        b_comp_prob: 1.11 (0.0%), b_tok_touch_all: 2.8 (0.0%), b_finish: 0.62
        (0.0%), tests_pri_0: 137 (1.3%), check_dkim_signature: 0.38 (0.0%),
        check_dkim_adsp: 8 (0.1%), poll_dns_idle: 10085 (97.9%), tests_pri_10:
        1.68 (0.0%), tests_pri_500: 10114 (98.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 2/3] block: sed-opal: ioctl for writing to shadow mbr
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mx01.mta.xmission.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 01, 2019 at 01:20:58AM +0200, David Kozub wrote:
> From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> 
> Allow modification of the shadow mbr. If the shadow mbr is not marked as
> done, this data will be presented read only as the device content. Only
> after marking the shadow mbr as done and unlocking a locking range the
> actual content is accessible.
> 
> Co-authored-by: David Kozub <zub@linux.fjfi.cvut.cz>
> Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> Signed-off-by: David Kozub <zub@linux.fjfi.cvut.cz>
> Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>
> Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>


re-reviewed and looks fine: Scott Bauer <sbauer@plzdonthack.me>
