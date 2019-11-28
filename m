Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF5D910CF6C
	for <lists+linux-block@lfdr.de>; Thu, 28 Nov 2019 22:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfK1VMU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 28 Nov 2019 16:12:20 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:37113 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbfK1VMU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Nov 2019 16:12:20 -0500
Received: by mail-wr1-f49.google.com with SMTP id w15so1691246wru.4;
        Thu, 28 Nov 2019 13:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZoopOf7bjFAgliAZM/EuWfHdb/60sjI4z+ge82oishU=;
        b=YuoP3obc6Rgv6yO2zhNsdwmkVHGZXhVMI2cuOHFc1G3uVVL+ztRLHYq8VWKTiqJEOm
         BOrLVHuA54MdJwwJo4fbyGLSP6T1u1jqC957UBUkjR3+fpd3VYiU1PAFugx7bFeFeMn1
         8c90JFY/cZBdVpRLuav1oONzZ5twgkX/22pPNMNRw0rz0qNAcY4yykKiWVguAzdxVX1d
         7uVi99MnoZtI2ruy5sJKOxWrln20wQlfDFEXRTPZ9Y48pxhem2suOdS3nre1Fb4uecrM
         o+N3kiLo7v3LZ5kI934QSugzGNriwj1134PCpe/4QmivSWM/QfeUGq4wbWnf5h6Vkfvu
         oLyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZoopOf7bjFAgliAZM/EuWfHdb/60sjI4z+ge82oishU=;
        b=e/QMHe8YhA6VkjffAjVVn7U7LuJQXh+k6XuN5vQaEWFIp0BP9anQvZTLSC6l2y4bA4
         np7Yj7KglKKDT/BiM5/sKJZ6hKEpWM3tc1TPzAFvULyRNIBQLmk08rc+3XdOUVgo8cCu
         rtCNvZ3hzDHJWMA1ifsdAgAim7HEcqM2gDS10C+xvbA1VrKDkQdx2tJrxCP5RBP7CUqj
         oVQs8agUPWr6dSz454ffsuZAjmgMq3oZploEbkhQAkP0r7/XN4LnHc5KhReULiw4ZkGA
         xevttKWRg/0SPEVPx6vtJlQ54ZGcg3h1SHV2hyUQOh+koGT065lA3ZFeIDRXcDI/TYpJ
         iC6g==
X-Gm-Message-State: APjAAAU5B53ugs0gRAdDCG/q3pbp4uLHcyIWe+/SV10rff4/AJPbH/8U
        +hz77ZI8iLMjqY560OApjgU=
X-Google-Smtp-Source: APXvYqwGlF6HicOC1vZlQbi1CxgsIMGxhJuYWyTaQjToAlrPq7b8n+RGRz2p+iybhAjiYy22bZrBZw==
X-Received: by 2002:adf:f20f:: with SMTP id p15mr78926wro.370.1574975538432;
        Thu, 28 Nov 2019 13:12:18 -0800 (PST)
Received: from localhost.localdomain ([109.126.143.74])
        by smtp.gmail.com with ESMTPSA id l26sm11620809wmj.48.2019.11.28.13.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 13:12:17 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] blk-mq: optimise plugging
Date:   Fri, 29 Nov 2019 00:11:52 +0300
Message-Id: <cover.1574974577.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Clean and optimise blk_mq_flush_plug_list().

Pavel Begunkov (3):
  blk-mq: optimise rq sort function
  list: introduce list_for_each_continue()
  blk-mq: optimise blk_mq_flush_plug_list()

 block/blk-mq.c       | 69 +++++++++++++++-----------------------------
 include/linux/list.h | 10 +++++++
 2 files changed, 33 insertions(+), 46 deletions(-)

-- 
2.24.0

