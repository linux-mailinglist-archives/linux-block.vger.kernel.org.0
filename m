Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34587134DD
	for <lists+linux-block@lfdr.de>; Sat, 27 May 2023 15:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjE0NDQ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 27 May 2023 09:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjE0NDP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 27 May 2023 09:03:15 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03396F3
        for <linux-block@vger.kernel.org>; Sat, 27 May 2023 06:03:14 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3942c6584f0so563660b6e.3
        for <linux-block@vger.kernel.org>; Sat, 27 May 2023 06:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685192593; x=1687784593;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZcNYarXVGxdOBKUVVQQ2FZGbj+A4znodz1TEj5svgI=;
        b=AIJ3L2GmYkD/HSA3aaCxnxyVjHZ38i5kA3qef3fw4OTl5SIuW3KSTX7W2IvwjS+w4M
         NHGSCuB+NWRJwJ/gDSYktRJIRn17O/tfwBLjvbKpIZntru7mzYkupa9uhnAgRUe+p4j1
         S32al+gKWmA24ewle9e+ul0ZSPFsOj3/HvvYhVUI04M+E/jiLlsazwP0MjXzUFNTTNpj
         iJHX+APMWKB12DZlJ9/dzggdwK193JUko15XT2n9G3Fp+HHq/9AOzfcL95IPhg6r4eRI
         1qF3vfdrUFUnlWY6jLZUjqJknDHDcj1lNA/WHj4+OXczoZc07v8Jpbhm/Mkx+DrBdkh6
         inYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685192593; x=1687784593;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XZcNYarXVGxdOBKUVVQQ2FZGbj+A4znodz1TEj5svgI=;
        b=D3+0RKN/ESSrWuNpgqvsEt3PAhVxuUTJaYoyT3ogaWZt5S1DXCBCdI/Dmj9K1yz373
         wAR7h4ezmRkPa1NcaLHF/kiVKmiNaM2TwWKOeApHLk+H5sy0L4yrTMKKKuxOocrR0k94
         NtseofiuX6k4Xlf/Lkotkl0w8AhkkEd0SDuHiZu9mEVK/+og07Lg6Ykux3x4A/KoDMdk
         ZVAAn1jtQDrfTEdn7Htk8optG3HmHB09URcTeN2MD+ASZWnoQs++XRvbUTU5pYZqyZEr
         qNAA+EdBeAg2kGiSrQDdCx7JHyXp3pmPWWG0Cwplq1MOHnF9BQ1Nvp74h3mw0o0LMJyG
         3lhQ==
X-Gm-Message-State: AC+VfDwZKsiqe9np854OayTNVCURk4PPcqCmcHycx6+SedRdTpHcvqU2
        zK7JEBzs+G99bu+pm9qRb9tjfbNhpnO/E+stRE0=
X-Google-Smtp-Source: ACHHUZ4pxkuZP8CBTqYah5dCG2wFwrexasq0vxyBK6fq2VYm+vXabgahlUyGqtCw9A30Stzukl/Kps8IqVZsBJQ/Aeo=
X-Received: by 2002:a05:6808:340d:b0:398:132b:7462 with SMTP id
 by13-20020a056808340d00b00398132b7462mr2194709oib.54.1685192593006; Sat, 27
 May 2023 06:03:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6359:4293:b0:121:4db0:43d with HTTP; Sat, 27 May 2023
 06:03:12 -0700 (PDT)
Reply-To: laurabeckwith002@gmail.com
From:   laura beckwith <pcole2019@gmail.com>
Date:   Sat, 27 May 2023 14:03:12 +0100
Message-ID: <CAMq-ndMcEqn7yrxcjk9jNLbbwa+w5cdEiJ6f=T00eKzxwSB-Tw@mail.gmail.com>
Subject: hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:22e listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [pcole2019[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [laurabeckwith002[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [pcole2019[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.8 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.7 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

-- 
My warmest greetings,

May the Good Lord bless you as you read this message. I am Mrs. Laura
Beckwith, I have decided to donate what I have to you motherless
babies, Less privileged and widows, because I am dying and diagnosed
with cancer about 2 years ago. I have been touched by God Almighty to
donate all I have to you for the good work of God almighty. I have
asked almighty God to forgive me and I believe he has because he is a
merciful God. May the good God bless you abundantly, and please use
the funds judiciously for charitable projects, motherless babies, Less
privileged and widows. I came to this decision to reach out to you
because I have limited time on this earth. I don't know you but I have
been directed to do this by God almighty. If you are interested in
carrying out this task, get back to me.

Reply at: laurabeckwith002@gmail.com

Yours Faithfully,
Mrs. Laura Beckwith
