Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07ADE44108A
	for <lists+linux-block@lfdr.de>; Sun, 31 Oct 2021 20:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbhJaTod (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 31 Oct 2021 15:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhJaToc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 Oct 2021 15:44:32 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB02C061714
        for <linux-block@vger.kernel.org>; Sun, 31 Oct 2021 12:42:00 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id l13so16433399ilh.3
        for <linux-block@vger.kernel.org>; Sun, 31 Oct 2021 12:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=hlMJUQ5tJAJOcDvzdSEHB3wKufZfvQwyRD3UIZQHrs0=;
        b=sSQNR/mIOpJrIoZwQgrcNNfoBl4POu1peI6ogutkrDUn63twMz1WQIbOkVamgPDa3I
         lH0znMfnxB1myxGRBoNu0BAnSji9RHsr71VDYElac6ntDzGRt8MfyuIx+EbRz4IEboE6
         fL6DDdEWfv023Caz7D7zMaIXMvHUL1AA589Ex78J2R/K+nJKrVJiy5H6CJm4x5jpnj7a
         L2dAjCQF089fimTwttOAI0mbL62UB3Ua4YNp5smUmIrfRPISkn7mj+nAN3bTho4dZQ0s
         h0fbpDuHkPbBEf8F8+yaIoiSttv3qaAjUlmr0XEGR6A3nVT5Nh1p9X60bfznyq1j+z3i
         nq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=hlMJUQ5tJAJOcDvzdSEHB3wKufZfvQwyRD3UIZQHrs0=;
        b=nO8B+cLMC51RgZpKP8a9mXMC0aSbp6bpt2/WdOAUEBcuupOSiS70g/PTiYdlnpbFvK
         103Pt78rHSqkRj8Jvzu/x6/5wud2ZzoKRmG5oyYOZKFO5GXs/ozOn2Ub+Z7+Z26RuDxg
         ivQDRFVFFAheYjxnqFCrPFUmgfKtpazCNkpy/EkhwSAuYfHcaSA6zmGIeacGr3b4xh5o
         Qo6mFpey0ESapcQqqRLL/8W3aLCCq8rjKu8AVqxBbTX2RQ5Wi/xEFYBKB3b61ge03evd
         NTZFN2a08gLL5DvSLqyqIm+R/hXTYl6M7fzps/cuVDWn7Zstw7JsjOrnze7/vw57fdSH
         frgw==
X-Gm-Message-State: AOAM530IWaYgzxT5QMNa2YqDrwYPWpYDg7kBzcjlgVOI39hLPaaCmG7N
        rtoJKm2g5ih5N+mxtsJBB/iS8A==
X-Google-Smtp-Source: ABdhPJw1nPV+gxkmTuviAfalHZOJJVz+PkkASGKVSZWBXZPiC0KlBzQ1EPYSdELUc7oByHEcW2XFqQ==
X-Received: by 2002:a92:c5a1:: with SMTP id r1mr16583691ilt.228.1635709319967;
        Sun, 31 Oct 2021 12:41:59 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id k7sm6431487iob.7.2021.10.31.12.41.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Oct 2021 12:41:59 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] SCSI multi-actuator support
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>
Message-ID: <93d17044-440c-a7f6-45fe-ea804b2a0977@kernel.dk>
Date:   Sun, 31 Oct 2021 13:41:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

On top of the core block tree, this pull request adds SCSI support for
the recently merged block multi-actuator support. Since this was sitting
on top of the block tree, the SCSI side asked me to queue it up.

Please pull!


The following changes since commit a2247f19ee1c5ad75ef095cdfb909a3244b88aa8:

  block: Add independent access ranges support (2021-10-26 20:36:47 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.16/scsi-ma-2021-10-29

for you to fetch changes up to 9d824642889823c464847342d6ff530b9eee3241:

  doc: Fix typo in request queue sysfs documentation (2021-10-26 21:01:48 -0600)

----------------------------------------------------------------
for-5.16/scsi-ma-2021-10-29

----------------------------------------------------------------
Damien Le Moal (4):
      scsi: sd: add concurrent positioning ranges support
      libata: support concurrent positioning ranges log
      doc: document sysfs queue/independent_access_ranges attributes
      doc: Fix typo in request queue sysfs documentation

 Documentation/block/queue-sysfs.rst | 33 ++++++++++++++-
 drivers/ata/libata-core.c           | 57 +++++++++++++++++++++++++-
 drivers/ata/libata-scsi.c           | 48 +++++++++++++++++-----
 drivers/scsi/sd.c                   | 81 +++++++++++++++++++++++++++++++++++++
 drivers/scsi/sd.h                   |  1 +
 include/linux/ata.h                 |  1 +
 include/linux/libata.h              | 15 +++++++
 7 files changed, 224 insertions(+), 12 deletions(-)

-- 
Jens Axboe

