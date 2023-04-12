Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435886DE929
	for <lists+linux-block@lfdr.de>; Wed, 12 Apr 2023 03:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjDLBxw (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 11 Apr 2023 21:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjDLBxv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 21:53:51 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C5140E3
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 18:53:45 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-632400531a0so90306b3a.1
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 18:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1681264425; x=1683856425;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ecco41ToXIzKwlBu01cW19u/XikU3NQL+Oz5QDFXdAA=;
        b=fu2lv108LU2uSwdxJz3IDoiJ1ZVrmR4oiRivtcHSU/D4sHvxgl6VCq6y3xsZbsWfl7
         Law1wVBC61WANmWjyWJdtkRAdWabBYHB6dk5UHXuC1fxNUI9aG0gAxy3TeRVOcnOJi6N
         WnFmxozAIte7tRl+LN52cOii/AgA1+2ETBZBAjWbtXn8niMeci4IQgtY1/PlylZk2yFn
         3Idx3k8UY31ooedcUrhzIshudLeGfaL6jn/A5/au7dtBwlLsoOSDs54TlXavNCxstRnA
         DY2S9ldjy/Ix0fxiAWjRpSIpghkSfF2e01bMloZIQ0QvSVVPDNuvgG85He4lSkcLTkI0
         Ge3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681264425; x=1683856425;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ecco41ToXIzKwlBu01cW19u/XikU3NQL+Oz5QDFXdAA=;
        b=1alIzHR6CGbpeehkDOaTqc5OxIl1cb4mTxH0sH16St+wtZs+9EsggE5Ye0WENsE89P
         LfGbiFkVqvS2RiEceBoLAnGyl26Y9IAFYr+la2bKjEeo0Vc6ZFVaq6kwwIWK3pAvb8gK
         ACSuWOj5emHaeadTov6Xzf4UqyQIrA5iKCpQbHGWVYZw8lMB+CPU+BktVpw+Z6qKQYsX
         JS0QoQ2WcdkJk04oLS8y4oHfhJcU7g0OAQjXfcATAflnQPFDr6uSxGceZnSR03f0GKGQ
         VJlmXl606z8CnMsAvyfFzkIBIhQm8ZChGTOkL0L4cpgkVUChDSIInMlHbI5eUqR+kxoh
         8Jvw==
X-Gm-Message-State: AAQBX9c9hnXCtZgFzLeB6lA5uzw1HXX+TjXfsiQqEUI8wFGc/yDmstEq
        9N5HF9hmQiU0B7oapPExRjkZB6teti2dGQvQG3Y=
X-Google-Smtp-Source: AKy350aqbfGVLk1UqCZY3h9mD+nlXLt1Uiv4F307dIPI7p4WMTpvm6cntlIUyceTppGKPFr9VSIz2Q==
X-Received: by 2002:a17:90a:af89:b0:242:d8e6:7b68 with SMTP id w9-20020a17090aaf8900b00242d8e67b68mr16112712pjq.1.1681264424786;
        Tue, 11 Apr 2023 18:53:44 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t21-20020a17090aae1500b00246952877d8sm241061pjq.34.2023.04.11.18.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 18:53:44 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20230405142017.2446986-1-sth@linux.ibm.com>
References: <20230405142017.2446986-1-sth@linux.ibm.com>
Subject: Re: [PATCH 0/7] s390/dasd: add dasd autoquiesce feature
Message-Id: <168126442400.57655.14741497300535913471.b4-ty@kernel.dk>
Date:   Tue, 11 Apr 2023 19:53:44 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Wed, 05 Apr 2023 16:20:10 +0200, Stefan Haberland wrote:
> please apply the following patchset that introduces an
> autoquiesce feature for DASD devices.
> 
> Quiesce and resume are functions that tell Linux to stop/resume
> issuing I/Os to a specific DASD.
> The DASD driver allows a manual quiesce/resume via ioctl.
> 
> [...]

Applied, thanks!

[1/7] s390/dasd: remove unused DASD EER defines
      commit: 861d53dbed4cad8cf1bbef692111f2215e02c38e
[2/7] s390/dasd: add autoquiesce feature
      commit: 1cee2975bbabd89df1097c354867192106b058ea
[3/7] s390/dasd: add aq_mask sysfs attribute
      commit: 9558a8e9d4a681e67b3abe9cabf3e3d8825af57e
[4/7] s390/dasd: add aq_requeue sysfs attribute
      commit: bdac94e29564bab9f24c2700f16ff11f31af7c11
[5/7] s390/dasd: add aq_timeouts autoquiesce trigger
      commit: 0c1a14748133024a33aa8ffd763ca7f5c03bb27e
[6/7] s390/dasd: add autoquiesce event for start IO error
      commit: d9ee2bee4a63844cd9d1e0d00b1e3c49eacd1c2f
[7/7] s390/dasd: fix hanging blockdevice after request requeue
      commit: d8898ee50edecacdf0141f26fd90acf43d7e9cd7

Best regards,
-- 
Jens Axboe



