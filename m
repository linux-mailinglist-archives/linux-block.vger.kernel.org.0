Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F54210762D
	for <lists+linux-block@lfdr.de>; Fri, 22 Nov 2019 18:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfKVRFZ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 22 Nov 2019 12:05:25 -0500
Received: from bout01.mta.xmission.com ([166.70.11.15]:33767 "EHLO
        bout01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfKVRFZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Nov 2019 12:05:25 -0500
Received: from mx04.mta.xmission.com ([166.70.13.214])
        by bout01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1iYCN1-0000ir-SN; Fri, 22 Nov 2019 10:05:23 -0700
Received: from plesk14-shared.xmission.com ([166.70.198.161] helo=plesk14.xmission.com)
        by mx04.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1iYCN0-0002jD-Kf; Fri, 22 Nov 2019 10:05:23 -0700
Received: from hacktheplanet (c-68-50-34-150.hsd1.in.comcast.net [68.50.34.150])
        by plesk14.xmission.com (Postfix) with ESMTPSA id AFB8814E2E8;
        Fri, 22 Nov 2019 17:05:15 +0000 (UTC)
Date:   Fri, 22 Nov 2019 12:05:07 -0500
From:   Scott Bauer <sbauer@plzdonthack.me>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "Rajashekar, Revanth" <revanth.rajashekar@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <20191122170507.GA362@hacktheplanet>
References: <20191122161854.70939-1-revanth.rajashekar@intel.com>
 <45c05efa3fb1947de41a47f6cb6fc043fa904f65.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45c05efa3fb1947de41a47f6cb6fc043fa904f65.camel@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-XM-SPF: eid=1iYCN0-0002jD-Kf;;;mid=<20191122170507.GA362@hacktheplanet>;;;hst=mx04.mta.xmission.com;;;ip=166.70.198.161;;;frm=sbauer@plzdonthack.me;;;spf=none
X-SA-Exim-Connect-IP: 166.70.198.161
X-SA-Exim-Mail-From: sbauer@plzdonthack.me
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=8.0 tests=ALL_TRUSTED,BAYES_00,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XM_UncommonTLD01
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -3.0 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1]
        *  0.5 XM_UncommonTLD01 Less-common TLD
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 
X-Spam-Combo: ;"Derrick, Jonathan" <jonathan.derrick@intel.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 493 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 4.9 (1.0%), b_tie_ro: 3.2 (0.6%), parse: 1.17
        (0.2%), extract_message_metadata: 29 (5.9%), get_uri_detail_list: 0.45
        (0.1%), tests_pri_-1000: 25 (5.0%), tests_pri_-950: 1.38 (0.3%),
        tests_pri_-900: 1.27 (0.3%), tests_pri_-90: 27 (5.5%), check_bayes: 26
        (5.2%), b_tokenize: 3.0 (0.6%), b_tok_get_all: 3.7 (0.7%),
        b_comp_prob: 1.13 (0.2%), b_tok_touch_all: 4.1 (0.8%), b_finish: 2.0
        (0.4%), tests_pri_0: 391 (79.4%), check_dkim_signature: 0.76 (0.2%),
        check_dkim_adsp: 174 (35.2%), poll_dns_idle: 163 (33.0%),
        tests_pri_10: 2.2 (0.4%), tests_pri_500: 7 (1.4%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [PATCH] block: sed-opal: Cleanup trivial patch
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on mx04.mta.xmission.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 22, 2019 at 04:28:06PM +0000, Derrick, Jonathan wrote:
> Acked-by: Jon Derrick <jonathan.derrick@intel.com>
Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>
