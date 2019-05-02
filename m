Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A80BD1190D
	for <lists+linux-block@lfdr.de>; Thu,  2 May 2019 14:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfEBMbO (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 2 May 2019 08:31:14 -0400
Received: from bout01.mta.xmission.com ([166.70.11.15]:35508 "EHLO
        bout01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEBMbO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 May 2019 08:31:14 -0400
Received: from mx03.mta.xmission.com ([166.70.13.213])
        by bout01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1hMArn-0001ta-0c; Thu, 02 May 2019 06:31:11 -0600
Received: from plesk14-shared.xmission.com ([166.70.198.161] helo=plesk14.xmission.com)
        by mx03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1hMArm-0004cQ-EK; Thu, 02 May 2019 06:31:10 -0600
Received: from hacktheplanet (c-68-50-23-202.hsd1.in.comcast.net [68.50.23.202])
        by plesk14.xmission.com (Postfix) with ESMTPSA id 6F8631C4856;
        Thu,  2 May 2019 12:31:09 +0000 (UTC)
Date:   Thu, 2 May 2019 08:30:58 -0400
From:   Scott Bauer <sbauer@plzdonthack.me>
To:     David Kozub <zub@linux.fjfi.cvut.cz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Message-ID: <20190502123036.GA4657@hacktheplanet>
References: <1556666459-17948-1-git-send-email-zub@linux.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556666459-17948-1-git-send-email-zub@linux.fjfi.cvut.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-XM-SPF: eid=1hMArm-0004cQ-EK;;;mid=<20190502123036.GA4657@hacktheplanet>;;;hst=mx03.mta.xmission.com;;;ip=166.70.198.161;;;frm=sbauer@plzdonthack.me;;;spf=none
X-SA-Exim-Connect-IP: 166.70.198.161
X-SA-Exim-Mail-From: sbauer@plzdonthack.me
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong,XM_UncommonTLD01 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4985]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.5 XM_UncommonTLD01 Less-common TLD
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;David Kozub <zub@linux.fjfi.cvut.cz>
X-Spam-Relay-Country: 
X-Spam-Timing: total 244 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 2.8 (1.1%), b_tie_ro: 1.92 (0.8%), parse: 0.92
        (0.4%), extract_message_metadata: 3.3 (1.4%), get_uri_detail_list:
        0.56 (0.2%), tests_pri_-1000: 3.2 (1.3%), tests_pri_-950: 1.42 (0.6%),
        tests_pri_-900: 1.18 (0.5%), tests_pri_-90: 18 (7.6%), check_bayes: 17
        (6.9%), b_tokenize: 5 (2.1%), b_tok_get_all: 5 (2.1%), b_comp_prob:
        1.74 (0.7%), b_tok_touch_all: 3.0 (1.2%), b_finish: 0.64 (0.3%),
        tests_pri_0: 202 (82.8%), check_dkim_signature: 0.59 (0.2%),
        check_dkim_adsp: 8 (3.3%), poll_dns_idle: 1.60 (0.7%), tests_pri_10:
        2.4 (1.0%), tests_pri_500: 6 (2.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/3] block: sed-opal: add support for shadow MBR done
 flag and write
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on mx03.mta.xmission.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 01, 2019 at 01:20:56AM +0200, David Kozub wrote:
> 
> Jonas Rabenstein (3):
>   block: sed-opal: add ioctl for done-mark of shadow mbr
>   block: sed-opal: ioctl for writing to shadow mbr
>   block: sed-opal: check size of shadow mbr
> 
>  block/opal_proto.h            |  16 ++++
>  block/sed-opal.c              | 160 +++++++++++++++++++++++++++++++++-
>  include/linux/sed-opal.h      |   2 +
>  include/uapi/linux/sed-opal.h |  20 +++++
>  4 files changed, 196 insertions(+), 2 deletions(-)
> 

I'll review this over the weekend. Is this essentially the same thing
we reviewed a month or two ago or are there little differences due to
it be split across two different series?


> -- 
> 2.20.1
> 
