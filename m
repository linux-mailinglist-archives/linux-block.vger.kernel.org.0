Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4718952E89E
	for <lists+linux-block@lfdr.de>; Fri, 20 May 2022 11:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243949AbiETJTS (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 20 May 2022 05:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345112AbiETJTR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 May 2022 05:19:17 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A698D6A2
        for <linux-block@vger.kernel.org>; Fri, 20 May 2022 02:19:17 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2ec42eae76bso80766027b3.10
        for <linux-block@vger.kernel.org>; Fri, 20 May 2022 02:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:cc;
        bh=jcv14XD1FEIAH5YEbByn5Xomdekt/dYfYEZFWkwU5FU=;
        b=RA2c0Kpx39xcjFnRdML110kV0bdm9iS63YM79bErumqqWKyvHcJWQPSZGlwoCyRALn
         mW++r+IeLitZHJUhNFu8/XlQDioRxQGZ5GqtbuH6vDJShoQ1sT08Z6YURYb0VY1YaPcN
         e8FIcoqnjAgt/9GAmJHv63hNBSP0J5HtUrR95dE0KwzA9HK+yZ8AkeZCn62VDW10KPSq
         xFBc1pmdYQghtreEVDnOQYkeGdQ42MBjni3SFwnZ157u7MHN/Bl/MFK1FcxT5HuGfUuL
         BZL5zwCX9wMlFkcFMCpe9b9bSneU+ir1puy/4WivYC1EW10M6bWRMeVhZgGWuQS6f63F
         4NKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:cc;
        bh=jcv14XD1FEIAH5YEbByn5Xomdekt/dYfYEZFWkwU5FU=;
        b=N7Hpt2r+DXbGFsGa2nJrZj/yO9+4MT+toiZ0KK9IJDdeRacfdCdeqmTU17lOnrxXo2
         wtjIr4SpPt1R5f9tCXSVYLrvzbXwJ3dznxCvLG1zYaaHScAfi7KBB4eQe3Z9o8DUCB1H
         6YVHwJ+fpRxQ9oA1bdaSR4UU9r7XRvazsJ/Oe0rtLVM4QJOagxEOqfvNknlf89oheCGk
         kPr45PClb7aKqWPadGMqxisbNCMeNux3DlklHCsolslD6LRELllby8QHuBU+Boc0a/5+
         nxXiPljR/1KCdT51Vks6d7jrjhe5Is3SHiX04/aC9OsrhNOp05HP8JfBOodRmqTVnlYD
         8ZFQ==
X-Gm-Message-State: AOAM530IU5bfdAACoWdnuMSrXsuGoW2MNhEBgTay3pTCm4/FQZl/PEDO
        HvEjBTI5vi6ONHn4uvl1gS8jBGSjSAo0dDd7Z6k=
X-Received: by 2002:a81:18cb:0:b0:2ff:995a:62b1 with SMTP id
 194-20020a8118cb000000b002ff995a62b1mt249996ywy.70.1653038356343; Fri, 20 May
 2022 02:19:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a81:61c5:0:0:0:0:0 with HTTP; Fri, 20 May 2022 02:19:15
 -0700 (PDT)
Reply-To: israelbarney287@gmail.com
From:   israel barney <abasszakari0@gmail.com>
Date:   Fri, 20 May 2022 10:19:15 +0100
Message-ID: <CAB+02OHPTbkj62sYKY1qkJVc7cnw9=473wetvsoETJNX3ejotA@mail.gmail.com>
Subject: HELLO
Cc:     israelbarney287@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        MALFORMED_FREEMAIL,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URG_BIZ autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Greetings to you! Please did you receive my previous message? I need
your urgent response.

My regards,
Mr. Israel Barney.
