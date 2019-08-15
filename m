Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC7738E437
	for <lists+linux-block@lfdr.de>; Thu, 15 Aug 2019 06:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfHOEu6 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 15 Aug 2019 00:50:58 -0400
Received: from bout01.mta.xmission.com ([166.70.11.15]:57255 "EHLO
        bout01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfHOEu6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Aug 2019 00:50:58 -0400
Received: from mx02.mta.xmission.com ([166.70.13.212])
        by bout01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1hy6xW-0004Vh-FI; Wed, 14 Aug 2019 22:01:54 -0600
Received: from plesk14-shared.xmission.com ([166.70.198.161] helo=plesk14.xmission.com)
        by mx02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1hy6xV-00082g-UW; Wed, 14 Aug 2019 22:01:54 -0600
Received: from hacktheplanet (unknown [8.25.222.2])
        by plesk14.xmission.com (Postfix) with ESMTPSA id 623DE727A8;
        Thu, 15 Aug 2019 04:01:53 +0000 (UTC)
Date:   Thu, 15 Aug 2019 00:01:48 -0400
From:   Scott Bauer <sbauer@plzdonthack.me>
To:     Revanth Rajashekar <revanth.rajashekar@intel.com>
Cc:     linux-block@vger.kernel.org,
        Jonathan Derrick <jonathan.derrick@intel.com>
Message-ID: <20190815040140.GA31938@hacktheplanet>
References: <20190813214340.15533-1-revanth.rajashekar@intel.com>
 <20190813214340.15533-2-revanth.rajashekar@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813214340.15533-2-revanth.rajashekar@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-XM-SPF: eid=1hy6xV-00082g-UW;;;mid=<20190815040140.GA31938@hacktheplanet>;;;hst=mx02.mta.xmission.com;;;ip=166.70.198.161;;;frm=sbauer@plzdonthack.me;;;spf=none
X-SA-Exim-Connect-IP: 166.70.198.161
X-SA-Exim-Mail-From: sbauer@plzdonthack.me
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XM_UncommonTLD01 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4947]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.5 XM_UncommonTLD01 Less-common TLD
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 
X-Spam-Combo: *;Revanth Rajashekar <revanth.rajashekar@intel.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 396 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.9 (0.7%), b_tie_ro: 2.0 (0.5%), parse: 1.04
        (0.3%), extract_message_metadata: 17 (4.3%), get_uri_detail_list: 0.72
        (0.2%), tests_pri_-1000: 12 (3.0%), tests_pri_-950: 1.28 (0.3%),
        tests_pri_-900: 1.02 (0.3%), tests_pri_-90: 14 (3.6%), check_bayes: 13
        (3.2%), b_tokenize: 3.7 (0.9%), b_tok_get_all: 3.6 (0.9%),
        b_comp_prob: 1.30 (0.3%), b_tok_touch_all: 2.4 (0.6%), b_finish: 0.66
        (0.2%), tests_pri_0: 333 (84.2%), check_dkim_signature: 0.46 (0.1%),
        check_dkim_adsp: 185 (46.8%), poll_dns_idle: 181 (45.7%),
        tests_pri_10: 2.9 (0.7%), tests_pri_500: 8 (2.0%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [PATCH 1/3] block: sed-opal: Add/remove spaces
X-SA-Exim-Version: 4.2.1 (built Mon, 03 Jun 2019 09:49:16 -0600)
X-SA-Exim-Scanned: Yes (on mx02.mta.xmission.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 13, 2019 at 03:43:38PM -0600, Revanth Rajashekar wrote:
> Signed-off-by: Revanth Rajashekar <revanth.rajashekar@intel.com>
looks fine
Reviewed-by Scott Bauer <sbauer@pldonthack.me>
