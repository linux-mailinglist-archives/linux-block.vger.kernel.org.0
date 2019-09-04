Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1496A9276
	for <lists+linux-block@lfdr.de>; Wed,  4 Sep 2019 21:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfIDTpU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 4 Sep 2019 15:45:20 -0400
Received: from mga01.intel.com ([192.55.52.88]:31161 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbfIDTpU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 4 Sep 2019 15:45:20 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 12:45:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,468,1559545200"; 
   d="scan'208";a="194841917"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga002.jf.intel.com with ESMTP; 04 Sep 2019 12:45:18 -0700
Date:   Wed, 4 Sep 2019 13:43:48 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        martin.petersen@oracle.com, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, hch@lst.de, sagi@grimberg.me,
        shlomin@mellanox.com, israelr@mellanox.com
Subject: Re: [PATCH v2 1/1] block: centralize PI remapping logic to the block
 layer
Message-ID: <20190904194347.GH21302@localhost.localdomain>
References: <1567614452-26251-1-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567614452-26251-1-git-send-email-maxg@mellanox.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 04, 2019 at 07:27:32PM +0300, Max Gurtovoy wrote:
> +	if (blk_integrity_rq(req) && req_op(req) == REQ_OP_READ &&
> +	    error == BLK_STS_OK)
> +		t10_pi_complete(req,
> +			nr_bytes >> blk_integrity_interval_shift(req->q));

This is not created by your patch, but while reviewing it, I noticed
we're corrupting metadata for TYPE0. Even if there's no in-kernel use
for accessing this data, changing it is still wrong.

Perhaps these t10_pi complete/prepare functions should be part of the
integrity profile like generate_fn/verify_fn.

Or as a quicker fix, we could exclude type0 like below:

---
@@ -246,7 +247,8 @@ void t10_pi_complete(struct request *rq, u8 protection_type,
 	u32 ref_tag = t10_pi_ref_tag(rq);
 	struct bio *bio;
 
-	if (protection_type == T10_PI_TYPE3_PROTECTION)
+	if (protection_type == T10_PI_TYPE0_PROTECTION ||
+	    protection_type == T10_PI_TYPE3_PROTECTION)
 		return;
 
 	__rq_for_each_bio(bio, rq) {
-- 
2.14.5
