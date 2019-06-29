Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5FD5A918
	for <lists+linux-block@lfdr.de>; Sat, 29 Jun 2019 07:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfF2FEx (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 29 Jun 2019 01:04:53 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:24609 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfF2FEx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Jun 2019 01:04:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561784692; x=1593320692;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/YNtsqzJHVzw6tyvDF9EXRAJVaDHoyXj7KfewPbLLyE=;
  b=gi2knOUTpqOr3Hr/iNzXmN1A+NN5NHrvd9X6BtOC65J0oDxXJsBQuwVa
   /JcJ5x2NLCu1LZtu6Z9hOHOIwEoTWPgeej9TiWcWDdJFHDhsuBoSFijPz
   vD/ECrkPDhT67RwKAeyG0J7JtCvvH+V5iPVOlEOXhM69FPLDfTDbiy0ef
   7+mJoDDFEzrHcMqTl2NFisr5207ea82phehNqa5muroZ0p5AyjtiomUyF
   hICL5qz4/88RUmDPJi2sC1BiM9J6IeZzkze3qyzMXinDCij7z9bk7jKCg
   anp9K7x9ufGEUv2tQknwMctLjiQTRHY89iL3NRXdMU+SKO6quMgmVGa3J
   A==;
X-IronPort-AV: E=Sophos;i="5.63,430,1557158400"; 
   d="scan'208";a="113038947"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2019 13:04:52 +0800
IronPort-SDR: fWu4FJDAiK+IH0Qo5xB/dKgZkyLoELCPPF1dSVppXDwYcX3asAw7AWesQOBFB/I03oMHMOLLAY
 PQQ25eVwf5UMJ28vzRTp7VlXkYz6sLLoKyil9GWhKRvQtiEI12K0lLDhq0BcaUZnZT3dcDdTcu
 VWse3UcH4k8mg8WQ4CZ9C+BHKNKdg2s/3WPavMhDAEgW5AICysfWg3IC07wq1Djc+vvoAuc+cv
 rlqz0lFEhP+y7laKc23g/P4W86jap8n0CCjx7DRdPfVOnqGb1x0h99K6vtyQeQtMLSTIlrJ8Kh
 pGQ2AQ54yhMjGqSRp9eN5Gj5
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 28 Jun 2019 22:04:03 -0700
IronPort-SDR: mtW00Ei1BUAXwEKqaSdSUqEdR5ax5KQPXXkXpzMyYejM2j9S0M7HH+BxwvZ07u/WJ4CKjLaQ6e
 qxhLUOzSM2dHmDddQKN59Yu+rSrCPxTd7d7tyWRIcy8JZ/SGk9n/5E0b2xcHGFTTQLZjHWynOI
 4Of+j3GHnkkbWciBbWGjbn0hdO0X1bvF/7+DM+xxVPx/NZ7HgDXfS6Uz4Bugtyk1N0IjhyGqHV
 oB2AK6UMY8wYVti8UESz7hsY+NHIZ8PDpLy8EXfwaKFe867kAoIh9cpWxPVnwt2I34WcNCZgR4
 pEM=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 28 Jun 2019 22:04:52 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     hch@lst.de, bvanassche@acm.org, axboe@kernel.dk,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 0/5] null_blk: simplify null_handle_cmd()
Date:   Fri, 28 Jun 2019 22:04:37 -0700
Message-Id: <20190629050442.8459-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

The core function where we handle the request null_handle_cmd() in the
null_blk does various things based on how null_blk is configured :-

1. Handle throttling.
2. Handle badblocks.
3. Handle Memory backed device operations.
4. Handle Zoned Block device operations.
5. Completion of the requests.

With all the above functionality present in the one function,
null_handle_cmd() is growing and becoming unreasonably lengthy when
we want to add more features such as new Zone requests which is being
worked on (See [1], [2]).

This is a cleanup patch-series which refactors the code in the
null_handle_cmd(). We create a clear interface for each of the above
mentioned functionality which leads to having null_handle_cmd() more
clear and easy to manage with future changes. Please have a look at
NVMe PCIe Driver (nvme_queue_rq()) (See [3]) which has a similar code
structure and nicely structured code for doing various things such as
setting up commands, mapping of the block layer requests, mapping
PRPs/SGLs, handling integrity requests and finally submitting the
NVMe Command etc.

With this patch-series we fix the following issues with the current 
code :-

1. Get rid of the multiple nesting levels (> 2).
2. Easy to read, debug and extend the code for specific feature.
3. Get rid of the various line foldings which are there in the code
   due to multiple level of nesting under if conditions.
4. Precise definition for the null_handle_cmd() and clear error
   handling as helpers are responsible for handling errors.

Please consider this for 5.3.

Regards,
Chaitanya

Chaitanya Kulkarni (5):
  null_blk: create a helper for throttling
  null_blk: create a helper for badblocks
  null_blk: create a helper for mem-backed ops
  null_blk: create a helper for zoned devices
  null_blk: create a helper for req completion

 drivers/block/null_blk_main.c | 189 +++++++++++++++++++++-------------
 1 file changed, 120 insertions(+), 69 deletions(-)

-- 
2.21.0

