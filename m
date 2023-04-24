Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4296D8D38
	for <lists+linux-block@lfdr.de>; Thu,  6 Apr 2023 04:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjDFCEg (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 5 Apr 2023 22:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbjDFCEf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Apr 2023 22:04:35 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6297D7EE6
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 19:04:01 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5144427bad7so47042a12.0
        for <linux-block@vger.kernel.org>; Wed, 05 Apr 2023 19:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680746639;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAX7cIp3aAxKESB/0Sd5HKGJOuas353fCWo8CuyScHc=;
        b=ENFffumRSAdBivjLkSSF+pYdxJuaj+ry817Q65Pg+rq58WYnWR3y13ES78CSyHmLMG
         aOrvzTDljgttqgAWtYW3KXlrMYab0oFRiobXQZSxefj0IEcZEptn6hVJOQ5JrBtsx/0z
         9oRf6MN/Ko+SPtVFa5WARFlNovYS4wDYtnc8Rb9qj/LZYzT+FIbNrdE8YKvimHZFcK6R
         bEJqu80Sw3miLct+9fIsdOoO+ZX6Jz0Zr/2wi9ydgaLHU0M5QYB4U0TGPGtTuNyasqvc
         fY3oEMMWPukEcS3h4yIeZ98uP58aD5aIq67EC1Okkwd5eWnfIUZwrN9v599xhR7eLpO4
         xQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680746639;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WAX7cIp3aAxKESB/0Sd5HKGJOuas353fCWo8CuyScHc=;
        b=CSBSGrxOsAlVYR1RBO5mwzlBXfZlGMOzBSKxY6wDeunfysmhdqO1tPY+jO5gVGBjqa
         wLrm+ouJrvFW7kL+0KQVfSchrfyRafUo2izZmE5bH4QR0q2xqNrWD0srS0+XOMtKh/w2
         s0QfnKdy9SsnoQY1PrD7QqDkXBl3Jo0MlJQJmszz3cka3Nw45kZAzTGAYZmWvvnvwKd7
         RGje6MyWdDaMcBhivjgj7umt0+400JENwViH5y0RLdFwV2IifZ0n23Ckn1C3KyHTcdGe
         CJd8S6hRCdbyB6Jv1AXBsWwSwZaflrLk5RhOhS0jYEH/nOSMrkT/U4tUbO6rShKTksO/
         kFEg==
X-Gm-Message-State: AAQBX9d59KdqC9RT7ceZhm+ORaiJVCCeYNyJsd+p891wMTnA3hD/G7yN
        foo/g/S17J3h1lh6bQIlLUXodw==
X-Google-Smtp-Source: AKy350YjJNnwYqhcOXlluOiOJsiTKXd4N70OSqSIKSzCWUXZpXY4OVFNDnkBKV41HDKOOm5TUGc7XA==
X-Received: by 2002:a05:6a00:e15:b0:624:bf7e:9d8c with SMTP id bq21-20020a056a000e1500b00624bf7e9d8cmr5064578pfb.1.1680746638646;
        Wed, 05 Apr 2023 19:03:58 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id p14-20020a63e64e000000b004fb8732a2f9sm11110pgj.88.2023.04.05.19.03.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 19:03:58 -0700 (PDT)
Message-ID: <4ea9c4da-5eb8-c9b1-46de-93697291baa5@kernel.dk>
Date:   Wed, 5 Apr 2023 20:03:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     io-uring <io-uring@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] ublk: read any SQE values upfront
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since SQE memory is shared with userspace, we should only be reading it
once. We cannot read it multiple times, particularly when it's read once
for validation and then read again for the actual use.

ublk_ch_uring_cmd() is safe when called as a retry operation, as the
memory backing is stable at that point. But for normal issue, we want
to ensure that we only read ublksrv_io_cmd once. Wrap the function in
a helper that reads the value into an on-stack copy of the struct.

Cc: stable@vger.kernel.org # 6.0+
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/ublk_drv.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index d1d1c8d606c8..b7a28f5d9297 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1256,9 +1256,10 @@ static void ublk_handle_need_get_data(struct ublk_device *ub, int q_id,
 	ublk_queue_cmd(ubq, req);
 }
 
-static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
+static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
+			       unsigned int issue_flags,
+			       struct ublksrv_io_cmd *ub_cmd)
 {
-	struct ublksrv_io_cmd *ub_cmd = (struct ublksrv_io_cmd *)cmd->cmd;
 	struct ublk_device *ub = cmd->file->private_data;
 	struct ublk_queue *ubq;
 	struct ublk_io *io;
@@ -1357,6 +1358,23 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 	return -EIOCBQUEUED;
 }
 
+static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
+{
+	struct ublksrv_io_cmd *ub_src = (struct ublksrv_io_cmd *) cmd->cmd;
+	struct ublksrv_io_cmd ub_cmd;
+
+	/*
+	 * Not necessary for async retry, but let's keep it simple and always
+	 * copy the values to avoid any potential reuse.
+	 */
+	ub_cmd.q_id = READ_ONCE(ub_src->q_id);
+	ub_cmd.tag = READ_ONCE(ub_src->tag);
+	ub_cmd.result = READ_ONCE(ub_src->result);
+	ub_cmd.addr = READ_ONCE(ub_src->addr);
+
+	return __ublk_ch_uring_cmd(cmd, issue_flags, &ub_cmd);
+}
+
 static const struct file_operations ublk_ch_fops = {
 	.owner = THIS_MODULE,
 	.open = ublk_ch_open,

-- 
Jens Axboe

