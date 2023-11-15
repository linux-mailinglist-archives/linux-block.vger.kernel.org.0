Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02EF7E2E59
	for <lists+linux-block@lfdr.de>; Mon,  6 Nov 2023 21:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbjKFUml (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 6 Nov 2023 15:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbjKFUmk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Nov 2023 15:42:40 -0500
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [IPv6:2001:41d0:203:375::b6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A217D71
        for <linux-block@vger.kernel.org>; Mon,  6 Nov 2023 12:42:37 -0800 (PST)
Message-ID: <ebd87e1e-f941-498a-870e-15743ca3fb1f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699303355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=lxSSHLlpMAVuMGFjx50YyUPGJuUALuzSwXJlLTkwHUg=;
        b=Vre5kFlKRNVZua2gus2elLHhkFMxkqdUYeTN0eTf58d6alUSSBwj5NLFgY4YBwEKSypbV+
        FGVxbUHUKgVXFUzNI1UCRG28T3uvVFFdo1nZvcC+rINZ5K53K0/Lucnup0yUMLMSRUHsit
        JNaan89ZXHgIyzxRymDmyEyfJXeAIMs=
Date:   Mon, 6 Nov 2023 23:42:31 +0300
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Vasily Averin <vasily.averin@linux.dev>
Subject: zram: zram_free_page calls in zram_meta_free
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The only place where content of zram entry is accessed and even changed without taken zran lock is
zram_free_page() calls from zram_meta_free().

It does not look like problem because zram should not have any users at this point,
however I still do not understand why this is required?

Is it performance optimization? But zram reset is quite rare operation, I doubt it is called
on some performance-critical fast path. Am I missed something perhaps?

I would like to add proper zram_lock/unlock calls around zram_free_page here,
and would like to clarify,perhaps you have any objections?

Thank you,
	Vasily Averin
