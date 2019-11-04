Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADA5ED68C
	for <lists+linux-block@lfdr.de>; Mon,  4 Nov 2019 01:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbfKDASZ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 3 Nov 2019 19:18:25 -0500
Received: from bout01.mta.xmission.com ([166.70.11.15]:34328 "EHLO
        bout01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728447AbfKDASZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 3 Nov 2019 19:18:25 -0500
Received: from mx01.mta.xmission.com ([166.70.13.211])
        by bout01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1iRQ4e-0007Ow-7s; Sun, 03 Nov 2019 17:18:24 -0700
Received: from plesk14-shared.xmission.com ([166.70.198.161] helo=plesk14.xmission.com)
        by mx01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1iRQ4d-0002qQ-Nk; Sun, 03 Nov 2019 17:18:24 -0700
Received: from hacktheplanet (c-68-50-34-150.hsd1.in.comcast.net [68.50.34.150])
        by plesk14.xmission.com (Postfix) with ESMTPSA id A7E702174C3;
        Mon,  4 Nov 2019 00:18:21 +0000 (UTC)
Date:   Sun, 3 Nov 2019 19:18:18 -0500
From:   Scott Bauer <sbauer@plzdonthack.me>
To:     Revanth Rajashekar <revanth.rajashekar@intel.com>
Cc:     linux-block@vger.kernel.org,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Jonas Rabenstine <jonas.rabenstein@studium.uni-erlangen.de>,
        David Kozub <zub@linux.fjfi.cvut.cz>,
        Jens Axboe <axboe@kernel.dk>
Message-ID: <20191104001818.GC12665@hacktheplanet>
References: <20191031161322.16624-1-revanth.rajashekar@intel.com>
 <20191031161322.16624-4-revanth.rajashekar@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031161322.16624-4-revanth.rajashekar@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-XM-SPF: eid=1iRQ4d-0002qQ-Nk;;;mid=<20191104001818.GC12665@hacktheplanet>;;;hst=mx01.mta.xmission.com;;;ip=166.70.198.161;;;frm=sbauer@plzdonthack.me;;;spf=none
X-SA-Exim-Connect-IP: 166.70.198.161
X-SA-Exim-Mail-From: sbauer@plzdonthack.me
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong,
        XM_UncommonTLD01 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4658]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.5 XM_UncommonTLD01 Less-common TLD
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Revanth Rajashekar <revanth.rajashekar@intel.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 226 ms - load_scoreonly_sql: 0.30 (0.1%),
        signal_user_changed: 4.5 (2.0%), b_tie_ro: 3.0 (1.3%), parse: 0.88
        (0.4%), extract_message_metadata: 15 (6.5%), get_uri_detail_list: 0.73
        (0.3%), tests_pri_-1000: 22 (9.6%), tests_pri_-950: 1.35 (0.6%),
        tests_pri_-900: 1.16 (0.5%), tests_pri_-90: 17 (7.7%), check_bayes: 16
        (7.0%), b_tokenize: 4.8 (2.1%), b_tok_get_all: 4.6 (2.0%),
        b_comp_prob: 1.67 (0.7%), b_tok_touch_all: 2.7 (1.2%), b_finish: 0.62
        (0.3%), tests_pri_0: 151 (66.7%), check_dkim_signature: 0.55 (0.2%),
        check_dkim_adsp: 2.7 (1.2%), poll_dns_idle: 0.64 (0.3%), tests_pri_10:
        2.4 (1.1%), tests_pri_500: 8 (3.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v3 3/3] block: sed-opal: Introduce Opal Datastore UID
X-SA-Exim-Version: 4.2.1 (built Mon, 03 Jun 2019 09:49:16 -0600)
X-SA-Exim-Scanned: Yes (on mx01.mta.xmission.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 31, 2019 at 10:13:22AM -0600, Revanth Rajashekar wrote:
> This patch introduces Opal Datastore UID.
> The generic read/write table ioctl can use this UID
> to access the Opal Datastore.
> 
> Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>
> Signed-off-by: Revanth Rajashekar <revanth.rajashekar@intel.com>
This is fine
Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>
