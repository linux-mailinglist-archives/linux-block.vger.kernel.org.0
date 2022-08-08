Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D0A58CC4B
	for <lists+linux-block@lfdr.de>; Mon,  8 Aug 2022 18:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243621AbiHHQnU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 8 Aug 2022 12:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbiHHQnU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Aug 2022 12:43:20 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C6813F99
        for <linux-block@vger.kernel.org>; Mon,  8 Aug 2022 09:43:19 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id m4so17655522ejr.3
        for <linux-block@vger.kernel.org>; Mon, 08 Aug 2022 09:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc;
        bh=K/FYN1zvN+b7oXMhqI+KTbmCOwOgcniR1F6fn5h0uqE=;
        b=noNDG6YWrcgD40ff1YZhk/tXMMllGvlqRYf8sqRYjC8J8sNmPRBg8VzBusvs4DZXMX
         iwgJBl4D8WcKOCXWulaIXJcS3GCwNLgm3IcsVeBJrfPFL1aJJhEDnBCfiMDqmSwPRC/P
         0Ncgaz2YntA365FFDgNaZQS6nSEettVFJOWaP2atp7OC80kVFrsQG3nUsACv8m57egrB
         EqZwVODBS/LnKJ3t7dkLDztAPQ/3tsozkkZyUXBc4Ea4crULMvnjQGWDBtGqb5837Fvf
         lV7kom1FQ8siiOYpENhFugC9gnD6l/PEIHFXUYF7NO3LFkOX5ODbSzLATDc6UEd3hZpU
         pPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc;
        bh=K/FYN1zvN+b7oXMhqI+KTbmCOwOgcniR1F6fn5h0uqE=;
        b=DIlLxAYarN9/vbABIpFfwdiBf6J1EjA3OhOKeKazD3bvB+3vhSrBkEufWgIusvlBl7
         4snpulqJ0XZf5UauEuUO4LEq1fGVdaQpXJSeAJUVVCpYq8YOIvpI4Q38aC8bly7C7ySY
         cVwtF7r2vYioU27KevN0pnGXl1K+WQILfbKZliAvIY2FstnIXZM85/wP9Yt78gLz1EdN
         NnkSDPt5fRkWcrZHmtNdE24RzEICv622OtiDHOxAcHExE3TH04WHVfyUh3q0ITtx4Dy7
         mCPowuE6uWdkKzr3BQv+Hg/x6bbYmyk0O0iwKBiMxBSd52OPEm9Vi1OV9T07GUsUn/O8
         836Q==
X-Gm-Message-State: ACgBeo0coFPQcJv9F6ZOXPEtf0BGYT5NGjBEm9bFSuSY+fY+zkdbWOsC
        KTwEi2rmBKr9Dj6G4ExdNB+0uKNz/hLJ3AuOzRg=
X-Google-Smtp-Source: AA6agR5Jw486x9fYlymLHvAFmH+nCaI1uJwN4yFuZe2tizgKYJFS7ch6sZis6tnfh4TYXJFc97CeFq9PD/H+2+ayPN0=
X-Received: by 2002:a17:906:29d:b0:6f0:18d8:7be0 with SMTP id
 29-20020a170906029d00b006f018d87be0mr13995355ejf.561.1659976997561; Mon, 08
 Aug 2022 09:43:17 -0700 (PDT)
MIME-Version: 1.0
Sender: salamtilkainatilkainezesalamti@gmail.com
Received: by 2002:a05:6f02:c691:b0:21:224:21b9 with HTTP; Mon, 8 Aug 2022
 09:43:17 -0700 (PDT)
From:   Kayla Manthey <sgtkaylamanthey612@gmail.com>
Date:   Mon, 8 Aug 2022 16:43:17 +0000
X-Google-Sender-Auth: XeUUN2Ijoaf3IxsBNoOuW-6UZcA
Message-ID: <CAAAW_LTLXDP-Erx6WEwtvKM8DFFMOjPRxjEhA6FBMWn5DeVU2w@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello how are you? I hope you're okay. did you receive my two previous
emails?  please check and reply me.
