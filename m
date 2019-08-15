Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC128E436
	for <lists+linux-block@lfdr.de>; Thu, 15 Aug 2019 06:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfHOEu5 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 15 Aug 2019 00:50:57 -0400
Received: from bout01.mta.xmission.com ([166.70.11.15]:57249 "EHLO
        bout01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfHOEu5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Aug 2019 00:50:57 -0400
Received: from mx01.mta.xmission.com ([166.70.13.211])
        by bout01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1hy6zX-0004cv-U6; Wed, 14 Aug 2019 22:03:59 -0600
Received: from plesk14-shared.xmission.com ([166.70.198.161] helo=plesk14.xmission.com)
        by mx01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1hy6zX-0000rB-Ji; Wed, 14 Aug 2019 22:03:59 -0600
Received: from hacktheplanet (unknown [8.25.222.2])
        by plesk14.xmission.com (Postfix) with ESMTPSA id 4994572842;
        Thu, 15 Aug 2019 04:03:59 +0000 (UTC)
Date:   Thu, 15 Aug 2019 00:03:56 -0400
From:   Scott Bauer <sbauer@plzdonthack.me>
To:     Revanth Rajashekar <revanth.rajashekar@intel.com>
Cc:     linux-block@vger.kernel.org,
        Jonathan Derrick <jonathan.derrick@intel.com>
Message-ID: <20190815040356.GB31938@hacktheplanet>
References: <20190813214340.15533-1-revanth.rajashekar@intel.com>
 <20190813214340.15533-3-revanth.rajashekar@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813214340.15533-3-revanth.rajashekar@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-XM-SPF: eid=1hy6zX-0000rB-Ji;;;mid=<20190815040356.GB31938@hacktheplanet>;;;hst=mx01.mta.xmission.com;;;ip=166.70.198.161;;;frm=sbauer@plzdonthack.me;;;spf=none
X-SA-Exim-Connect-IP: 166.70.198.161
X-SA-Exim-Mail-From: sbauer@plzdonthack.me
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XM_UncommonTLD01 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4819]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.5 XM_UncommonTLD01 Less-common TLD
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Revanth Rajashekar <revanth.rajashekar@intel.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 184 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.9 (1.6%), b_tie_ro: 2.1 (1.1%), parse: 0.82
        (0.4%), extract_message_metadata: 15 (8.4%), get_uri_detail_list: 0.79
        (0.4%), tests_pri_-1000: 21 (11.6%), tests_pri_-950: 1.28 (0.7%),
        tests_pri_-900: 1.05 (0.6%), tests_pri_-90: 16 (8.5%), check_bayes: 14
        (7.7%), b_tokenize: 4.2 (2.3%), b_tok_get_all: 4.1 (2.2%),
        b_comp_prob: 1.51 (0.8%), b_tok_touch_all: 2.2 (1.2%), b_finish: 0.70
        (0.4%), tests_pri_0: 115 (62.4%), check_dkim_signature: 0.50 (0.3%),
        check_dkim_adsp: 2.5 (1.4%), poll_dns_idle: 0.80 (0.4%), tests_pri_10:
        2.2 (1.2%), tests_pri_500: 6 (3.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 2/3] block: sed-opal: Eliminating the dead error
X-SA-Exim-Version: 4.2.1 (built Mon, 03 Jun 2019 09:49:16 -0600)
X-SA-Exim-Scanned: Yes (on mx01.mta.xmission.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 13, 2019 at 03:43:39PM -0600, Revanth Rajashekar wrote:
> In the function 'response_parse', num_entries will never be 0 as
> slen is checked for 0. Hence, the condition 'if (num_entries == 0)'
> can never be true.
> 
> Signed-off-by: Revanth Rajashekar <revanth.rajashekar@intel.com>
Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>

Can we also change the title to something a little more obvious like:
Remove always false if statement
The current title is ambigious if you single-line look at commits.
