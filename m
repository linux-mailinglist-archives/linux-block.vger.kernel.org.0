Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2ED4D9620
	for <lists+linux-block@lfdr.de>; Wed, 16 Oct 2019 18:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391628AbfJPQA1 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 16 Oct 2019 12:00:27 -0400
Received: from mga02.intel.com ([134.134.136.20]:36718 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391534AbfJPQA1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Oct 2019 12:00:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2019 09:00:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,304,1566889200"; 
   d="scan'208";a="198994550"
Received: from unknown (HELO [10.232.112.141]) ([10.232.112.141])
  by orsmga003.jf.intel.com with ESMTP; 16 Oct 2019 09:00:25 -0700
Subject: Re: [PATCH v2 2/3] block: sed-opal: Generalizing write data to any
 opal table
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        Jonas Rabenstine <jonas.rabenstein@studium.uni-erlangen.de>,
        David Kozub <zub@linux.fjfi.cvut.cz>,
        Jens Axboe <axboe@kernel.dk>
References: <20191015230246.10171-1-revanth.rajashekar@intel.com>
 <20191015230246.10171-3-revanth.rajashekar@intel.com>
 <20191016063212.GB6852@infradead.org>
From:   "Rajashekar, Revanth" <revanth.rajashekar@intel.com>
Message-ID: <7ac5ac89-3544-2a99-dbdb-95d14fbbdeb1@intel.com>
Date:   Wed, 16 Oct 2019 10:00:25 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191016063212.GB6852@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 10/16/2019 12:32 AM, Christoph Hellwig wrote:
> On Tue, Oct 15, 2019 at 05:02:45PM -0600, Revanth Rajashekar wrote:
>> +static int generic_table_write_data(struct opal_dev *dev, const u64 data, u64 offset,
> Please at least fix your basic coding style issues before the next
> resend.
Sure :)
