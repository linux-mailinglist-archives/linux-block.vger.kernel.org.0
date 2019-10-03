Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29473CABAD
	for <lists+linux-block@lfdr.de>; Thu,  3 Oct 2019 19:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731021AbfJCP5q (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 3 Oct 2019 11:57:46 -0400
Received: from mga06.intel.com ([134.134.136.31]:18870 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731015AbfJCP5p (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 3 Oct 2019 11:57:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 08:57:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,253,1566889200"; 
   d="scan'208";a="196386352"
Received: from unknown (HELO [10.232.112.172]) ([10.232.112.172])
  by orsmga006.jf.intel.com with ESMTP; 03 Oct 2019 08:57:44 -0700
Subject: Re: [PATCH 1/2] block: sed-opal: fix sparse warning: obsolete array
 init.
To:     Scott Bauer <sbauer@plzdonthack.me>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, axboe <axboe@kernel.dk>,
        jonathan.derrick@intel.com
References: <807d7b7f-623b-75f0-baab-13b1b0c02e9d@infradead.org>
 <20191003154227.GB2450@hacktheplanet>
From:   "Rajashekar, Revanth" <revanth.rajashekar@intel.com>
Message-ID: <1bef5039-174d-3700-6574-daf85225ffaa@intel.com>
Date:   Thu, 3 Oct 2019 09:57:44 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191003154227.GB2450@hacktheplanet>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 10/3/2019 9:42 AM, Scott Bauer wrote:
> On Wed, Oct 02, 2019 at 07:23:05PM -0700, Randy Dunlap wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> Fix sparse warning: (missing '=')
>> ../block/sed-opal.c:133:17: warning: obsolete array initializer, use C99 syntax
>>
>> Fixes: ff91064ea37c ("block: sed-opal: check size of shadow mbr")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Jens Axboe <axboe@kernel.dk>
>> Cc: linux-block@vger.kernel.org
>> Cc: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
>> Cc: David Kozub <zub@linux.fjfi.cvut.cz>
>> ---
> Un cc'd David and Jonas, +CC'd Jon and Revanth.
>
> This looks fine to me too.
>
> Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>

Looks fine to me as well

Reviewed-by:  Revanth Rajashekar <revanth.rajashekar@intel.com>

