Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1401142F5F3
	for <lists+linux-block@lfdr.de>; Fri, 15 Oct 2021 16:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240686AbhJOOqm (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 15 Oct 2021 10:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240679AbhJOOql (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Oct 2021 10:46:41 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7802CC061765
        for <linux-block@vger.kernel.org>; Fri, 15 Oct 2021 07:44:34 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id w19so38936932edd.2
        for <linux-block@vger.kernel.org>; Fri, 15 Oct 2021 07:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SrINTsJkJyQNn5NkmsQ24Qfw9wYKTJsI3rIhs9tC6FQ=;
        b=OK3sNJkyalyi6dhT9gua0R75rLmXnEMkr55zdez2DpLd2eQ6p0bIdBN4u9zNa4c/z1
         Om4BGJKJD2zwseNpeOMHtizqZqiUSfi7Lgto4WpMxhMAgpvsHtyaSpqwIKSRytx8qVNR
         nssDzQgWPUNo8vjY6AoVFGKD9ieskdSBl1eggP+qp+vr0qn/D/fgeboceNOV8378XBkG
         N+Kp8DH9y3Y8gjdzvBuZGf9CbCy7fLWDPl4XooMwvsHsFb1AOZHA65tIaPh98PKgi2a9
         GU0HEnJIO0eGS0ZnPco/KDuXVp10UbcLAhWACzcKYEIwQuKlzIr4WIHbB11MPb4lw6IY
         e4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SrINTsJkJyQNn5NkmsQ24Qfw9wYKTJsI3rIhs9tC6FQ=;
        b=y+NzkiZNiH9uG7bH5S3KOB68+k3BWOl9y8sthpuPsS1vcCKDFO/yNXEyur61PkE5fX
         Hcg57EB0fFJ7/+b4qE2nOjJB9D/dLHn1cIePm3s2S/2KblwExy6BLur+Lxpobd5/O0Ue
         mSSHolMSmSIKyeN3HsG1Af6+x3EQoordfUWO3ajKwv3VUg+FR6/ZghNQDOQgmtcLvX49
         TrFlmScRmlY9EynHpL03fSqT2s3RebRRAzBbbBuOvMKfXso/l6rGUZrtB67VBzrfbm4c
         tOVTwNUkp1WNZZdsK4c3UIX+SpP22OO+gTx+gBMbuhRsR8tOiGQjDaLi3qHGe8HdvFy2
         aWZg==
X-Gm-Message-State: AOAM530FmS5hwIVajTYxz9rATq8ta8k58xe4sUrrbEH0r9+D6oyN+iau
        vfSxq77tN3J151AOvf9QsSfnSL6vwvPc3Q==
X-Google-Smtp-Source: ABdhPJy488jhljVkPmTncID6CTjwLdHs38ijNQU6OBhmFmeusg4Kkab84eaPbCzdXhdYBwLvGEbvgA==
X-Received: by 2002:a50:d809:: with SMTP id o9mr18299382edj.149.1634309031090;
        Fri, 15 Oct 2021 07:43:51 -0700 (PDT)
Received: from localhost.localdomain ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id v28sm4605365edx.21.2021.10.15.07.43.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Oct 2021 07:43:50 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX 0/1] block, bfq: fix bug 214503
Date:   Fri, 15 Oct 2021 16:43:35 +0200
Message-Id: <20211015144336.45894-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,
this patch fixes bug 214503 [1]. Commit 2d52c58b9c9b ("block, bfq:
honor already-setup queue merges") has not to do with this bug, and
can be restored.

Thanks,
Paolo

Paolo Valente (1):
  block, bfq: reset last_bfqq_created on group change

 block/bfq-cgroup.c | 6 ++++++
 1 file changed, 6 insertions(+)

--
2.20.1
