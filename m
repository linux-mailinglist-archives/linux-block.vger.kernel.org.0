Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78161F1F20
	for <lists+linux-block@lfdr.de>; Wed,  6 Nov 2019 20:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfKFTkq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 6 Nov 2019 14:40:46 -0500
Received: from mail-io1-f53.google.com ([209.85.166.53]:41899 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbfKFTkq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Nov 2019 14:40:46 -0500
Received: by mail-io1-f53.google.com with SMTP id r144so28256962iod.8
        for <linux-block@vger.kernel.org>; Wed, 06 Nov 2019 11:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8WeAdnPwLkVKfjKfS85mq63m4KGYUB+j3SdfSQTZ/5c=;
        b=MJ1q17dtSVxRv9TCZuuqetYE/SzaC4BxnJhYa46r5oZAhNHYbhB3gLJ6if3dihobhS
         qG20fr4+FMm24uPn/OJjWsAwJVijf9du+GpXJX3fIYzgCh6E4eYJYSpFFoo7uJYfizHg
         YftxIb0S9ru39hmVSx3Q6h9JennMxvq++kj6f3glEGR1fMaQh/6YhysmJ2baGC/SXgiH
         sWH3tsQWml5NcfdZ57cntwmjpmfl/H4ofA7LIQCciRvNcOBfjSFmx2mLDLxdOl3aeHgc
         lRYoaVkI/no7DqCv68//qttb1Nq1/1mKNQW0irke4l+t4Wpv685ZigJRigsBvHsTZ66Z
         QPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8WeAdnPwLkVKfjKfS85mq63m4KGYUB+j3SdfSQTZ/5c=;
        b=O+nkzVQ0H3YAGoA9+jqb2oqZo7peUgbcHQJba5ajbqEjQQIW5GQ9gDjO94EywDS3Ii
         oyqQVqBFAwRm2ImRURrMMlS6aJGFg4RF48Hbeifd3pPnRyYV41heH8VafveG9sBT3G7j
         fqHUZwITE2tRmwp+fzserRYqUC6eXkjo6XVmmOT3PaBGzZlvcfa11DoUpiNmcSLlWW1X
         VBXNkO93pZCFXHX6QQtGiai3Ueb9M8Jnec+ZZ5YAEKwLaXB3JGUri3L/ymkSBxZazflv
         xjqyNzPDukoUw8R9DetpVluQ4YAecWSA3rj8xoWfbOgpWcNyJbIXBkKuDWxJINSR3r1s
         pMtA==
X-Gm-Message-State: APjAAAUef+h8Lxbiedof2oD/bxlO52EUM6n1GljvOuR+PuV2Y3L+DTRr
        cRccXp6Lpg1USz2tcVdJAyU/Mfqi/Lo=
X-Google-Smtp-Source: APXvYqyZimxCKIca76Oa1yx0JDSibimpMSF4IftFJLm6sh3QobxxcrCUtKip4lDiWSr1mhf8BCysWg==
X-Received: by 2002:a02:5103:: with SMTP id s3mr9924680jaa.45.1573069243949;
        Wed, 06 Nov 2019 11:40:43 -0800 (PST)
Received: from x1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k22sm911298iot.34.2019.11.06.11.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 11:40:42 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-block@vger.kernel.org
Subject: [PATCHSET 0/2] Add unbounded io_wq for io_uring
Date:   Wed,  6 Nov 2019 12:40:38 -0700
Message-Id: <20191106194040.26723-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently we have just the one workqueue for each io_uring ctx, which
supports any kind of IO. This is problematic with requests that have
very different life times. For example, disk IO is always bounded in
time, while networked IO can take a long time. Ditto with POLL commands,
that also have unbounded execution time.

First patch is just a prep patch, patch number two adds support for
determining the io_wq placement based on the request type.

Patches are against my for-5.5/io_uring-test branch.

 fs/io-wq.c    |   8 +--
 fs/io-wq.h    |   2 +-
 fs/io_uring.c | 145 ++++++++++++++++++++++++++++++++++++--------------
 3 files changed, 110 insertions(+), 45 deletions(-)

-- 
 Jens Axboe


