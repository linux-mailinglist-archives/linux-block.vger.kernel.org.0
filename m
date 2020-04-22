Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2231B3AA9
	for <lists+linux-block@lfdr.de>; Wed, 22 Apr 2020 11:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbgDVJAy (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 22 Apr 2020 05:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725968AbgDVJAx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Apr 2020 05:00:53 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12CDC03C1A6
        for <linux-block@vger.kernel.org>; Wed, 22 Apr 2020 02:00:53 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id v2so673754plp.9
        for <linux-block@vger.kernel.org>; Wed, 22 Apr 2020 02:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=/lNHrzKG35VPMrePjYUYNbOK/+5taqOUGFBWUbMoiz0=;
        b=GF0DB9uCqX5LDfTa5GuQLRU6/cbJya7ug5Uk2gUZCxauRxJ2HDYzC4JTBgAhC4G/N8
         T2iXhEPZoi1t7o0qHG5q4r3cgcZiszl2tt/v6j+0BsFNYRpdfUBg7DAWiNH9L8+tjiDU
         UnDAfG7eeOa91E/xtSZKfpOl0HCPTMFSmFuqCJ2OBwugh7SJhRKVMhxxi/kRUybl9LSd
         kFd6gmxMdpq5L0zFVjh0iUfpsV/J9QuuWyIBc73IldxofXIH054YE3m92UMbCE7enClL
         thvtB1w2jwspELeSPYTQ3iptmVrmHZtpFJAnHd5ln85uVBqA3eeMRUyswr7O0e/6Db28
         utUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/lNHrzKG35VPMrePjYUYNbOK/+5taqOUGFBWUbMoiz0=;
        b=LVGGgFiUQ+KgxfBSFJTYwwHnUjX4x62+fh8ZTYIVSRBBFgu1Ne6JACbCrcX/GsLAFB
         tPnaHRPzmjvjPUlnFw7z5Q32Qd08RAjfdyOmstdCmWx7UfdgwL5YgoseN3eQRqWPSIH2
         0L2ndnIYmkJ8YvMVNbbWsM0R835V8aVH4b1vzT+0ckLg61VSDsgC5IFQkkqwTln22PjO
         cW2gzLIfYeKnID5iQOTKu72rf2xV9v8uQsa7w/U+PXOUR8r3u0yVl+E7iOC+62yH4fav
         mGvWjWJEeaaJRpumO5AArDgpMBWnLLpsTQhUAtJ9KK96O8w76/Ygl2QOG8lmJb5Ebg10
         3YPg==
X-Gm-Message-State: AGi0PubCH40Ftjb63pqfqzkcx0WP/tBKrLqkIQkdYeKAMjpmnwMDdajB
        HONCxjCWiK9bSePj9qptwNxvbA==
X-Google-Smtp-Source: APiQypKsfBc3CfFgHX6D5DERQfxF2tR+yy5uYKa2Pi7RJWV+BaxEQNZbRWHg7yMlnTJT2sBFEA2JVQ==
X-Received: by 2002:a17:902:9004:: with SMTP id a4mr23509028plp.275.1587546053434;
        Wed, 22 Apr 2020 02:00:53 -0700 (PDT)
Received: from debian.bytedance.net ([61.120.150.75])
        by smtp.gmail.com with ESMTPSA id p66sm4660054pfb.65.2020.04.22.02.00.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Apr 2020 02:00:52 -0700 (PDT)
From:   Hou Pu <houpu@bytedance.com>
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     mpa@pengutronix.de, linux-block@vger.kernel.org,
        nbd@other.debian.org, Hou Pu <houpu@bytedance.com>
Subject: [PATCH 0/2] nbd: export dead connection timeout
Date:   Wed, 22 Apr 2020 05:00:16 -0400
Message-Id: <20200422090018.23210-1-houpu@bytedance.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Here are two trivial patches:

Hou Pu (2):
  nbd: export dead_conn_timeout via debugfs
  nbd: set max discard sectors in the unit of sector

 drivers/block/nbd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)


Thanks,
Hou


-- 
2.11.0

