Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5CB6485A5
	for <lists+linux-block@lfdr.de>; Fri,  9 Dec 2022 16:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiLIPd2 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 9 Dec 2022 10:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbiLIPdV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Dec 2022 10:33:21 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC5F8F08D
        for <linux-block@vger.kernel.org>; Fri,  9 Dec 2022 07:33:20 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id b3so7597405lfv.2
        for <linux-block@vger.kernel.org>; Fri, 09 Dec 2022 07:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=ImNzBE3SlxRlVIPcifzS5JYjvJJ0yu9Pcf5kr6WJysFeUVzEC7UdQ0bmmbVunCMViY
         E0MlsJxem/Hz01Y8SyHlWM9DBMZaiHK1jMGOMKkh8dYgQM3+FEhyuyT8IBNLAd2H/U2e
         GzfKyW9CF1r3HpmON7O14EwkLeviC5pDTfEvgA1nOSi/mZFC8KMOUiH/6mquksUpIG0H
         qsUzY5kpjUASHUPUCoDt0GoYOXmYQEOZp3krgLSmurmT2wHSnu/ZUrRutWFZnLeuTDWH
         iWqxULpAWAmX385HAgonXg7/urodLc92Vd5hri2U0vDQUHLt1jApr5gaPrHw0m3b7aeS
         M0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=wHKMJTID6dyMbQRKRKkTW5FKqdw83arHoyFMDXmyhA8D1U8g5qVUJhMXPUCq61042B
         it2iSjyTbuxNnjyrwnH3hDWuOmVglcmjqT3h/290qzCZKFhP3y5M7f7bpUhqpl4V31sz
         sJ8KgtVEIrPgH0UOukhX/EUSJQlLvO43VZn6cok+yxm0ZdYwn/Hz29ZZO/Sge9yHqjiN
         Ilu53KmUgXrooM2IocrdQRI834zV7lnszZNBEb/U/yZWcO3NZi+YnfOAAqBxbdsOW0QG
         /4JBGhm32igJzNvKSLUTEZCjfCAcYjNPAVbdCQDMrWq/ACMDTt9MA9BnzJnCp7ayLxkS
         odow==
X-Gm-Message-State: ANoB5pkkjCagIZU2peRQWjWdDyJKMj0JjzKC5JZ7d07f/fn8jk9e3+Zx
        Tlk67BLijlZ3/sBXj4Vp5X9CMOa7tNGZDimp8ag=
X-Google-Smtp-Source: AA0mqf6D6kxSW4zDDTaH0/5a6BIP6RsAc9Q5jTUD/01/ya+WnXoO/vjDBDDpP/ZeX3uGLCm4F5Io/ktuB6phl8ShcmQ=
X-Received: by 2002:ac2:488e:0:b0:4b4:cf32:e105 with SMTP id
 x14-20020ac2488e000000b004b4cf32e105mr31530896lfc.110.1670599998863; Fri, 09
 Dec 2022 07:33:18 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a2e:a988:0:0:0:0:0 with HTTP; Fri, 9 Dec 2022 07:33:18 -0800 (PST)
Reply-To: Gregdenzell9@gmail.com
From:   Greg Denzell <anonymusxt2@gmail.com>
Date:   Fri, 9 Dec 2022 15:33:18 +0000
Message-ID: <CAKr3oRRe+TLWTuDixFQK1dKgOEdNGVF1uL2LNXpgrc8kkfRbrA@mail.gmail.com>
Subject: Hello, This is my second message to you regarding the funds of your
 late relative. I shall send you details after I receive your response.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,EMPTY_MESSAGE,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:129 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4991]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [anonymusxt2[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [anonymusxt2[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [gregdenzell9[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  2.3 EMPTY_MESSAGE Message appears to have no textual parts
        *  2.8 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


