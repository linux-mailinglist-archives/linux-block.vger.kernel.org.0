Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAC04F08DC
	for <lists+linux-block@lfdr.de>; Sun,  3 Apr 2022 13:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbiDCLC4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 3 Apr 2022 07:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbiDCLC4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 3 Apr 2022 07:02:56 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E6B31538
        for <linux-block@vger.kernel.org>; Sun,  3 Apr 2022 04:01:02 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id y36so9472203lfa.6
        for <linux-block@vger.kernel.org>; Sun, 03 Apr 2022 04:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=YVJDxNPPESnWyXncfNCf0wvGb0N0arKBS71GbYEv53s=;
        b=HeE4+RKxmcZ5WXBaFCLMBJPg1Tg6gAPGVvPPwwZdCkaORikWGa9FtiRFdhpsVP4eY+
         Jk5X6viP7Jg20UuhWQJdTUym5sluPcW+p0RWhAa1VM9fbGd0vXrOI3l3HTlwtDYWCZFv
         JuODIsAicoYginlqNIvDXvLxMoJn2TtDZtsy+vXEorCyoRsk6ZNR8j/HcvhNsNMk+1z9
         ooQY1zC0V8PuvNqKdWN6SCjKhM5q2gGaM+/8LTjPZKd1/wJRuP7cT2KsEy93NBaX3a18
         ExmsfphUNMTX6XPXtRj0/a8uhfIlvhy8zfrCs++ytA6gEf5XviD251T7RZcMnqLM04V0
         w01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=YVJDxNPPESnWyXncfNCf0wvGb0N0arKBS71GbYEv53s=;
        b=6Op8md3wxCRncrJmJbBXxMiV7Ry3ZDYQzu7lgIk0j35a8Zc+Yy3CNScXBVudRrl4yH
         2/OC8TIlFKRT+3B1YnuqD9tmcQwvnNPapf3P0q617ougzrxabujwsLE5Zuott5CztVQc
         wljGbrAUmKQ8UzIKuW55rOuTGa/9825b/sjfOiA08lMuC5eALZIg9c6v3P9Qa4LbtnTf
         HzSqtxDGZJNi0Bopz6GpIQ8By6ivQJp7WFa+qfnhBGNZE0lMugGYrxUgjJrNG9aioT6d
         ZppFiMdrnYRiGQyiEF8Oqu4BcrajRpWfRacecr4Q2zCBJScPEGumE7YzviojvVllrDj4
         y6/w==
X-Gm-Message-State: AOAM530S6wL6BhY1YzphwI8Wtq9FBjWYkPO5xODpmdcrOzUhbk5FnSy0
        8vOggS0A8T4FLeaU02XjbEohAzrbgklBkaVQ/eA=
X-Google-Smtp-Source: ABdhPJwY51rJALhnpqB+TVvnlHwaExbU48AnKH4IUG6AzwfL4TGkwQUEcyPVeSV2NXL75WVwQUon/YdW1cDsuolOjsc=
X-Received: by 2002:ac2:4194:0:b0:442:ed9e:4a25 with SMTP id
 z20-20020ac24194000000b00442ed9e4a25mr18666159lfh.629.1648983660522; Sun, 03
 Apr 2022 04:01:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6520:1d6:b0:1a5:e97a:9064 with HTTP; Sun, 3 Apr 2022
 04:00:59 -0700 (PDT)
Reply-To: sara.adner@outlook.com
From:   SARA ANDERSON <sara.adners@gmail.com>
Date:   Sun, 3 Apr 2022 12:00:59 +0100
Message-ID: <CAC9w2dJPBggWmSxOWRkUQNNZfaY51LCCX8hFuhEkat9cyvxgog@mail.gmail.com>
Subject: Hello,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

My name is Sara Anderson. I came across your contact and noticed we can
be of value to each other. I have a proposal that i want to share with
you.

Your prompt response will be appreciated for more details.

Sincerely,
Sara Anderson
