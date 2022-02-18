Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F044BB591
	for <lists+linux-block@lfdr.de>; Fri, 18 Feb 2022 10:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbiBRJ2m (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 18 Feb 2022 04:28:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbiBRJ2l (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Feb 2022 04:28:41 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A475512D932
        for <linux-block@vger.kernel.org>; Fri, 18 Feb 2022 01:28:25 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id bs32so7377472qkb.1
        for <linux-block@vger.kernel.org>; Fri, 18 Feb 2022 01:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=kXW4q7S4Jg2rtxoPxio8ec2bXWVGT+1Urze9RICskNQ=;
        b=LkCeQMWPCxdBepy9IGSmynbo6TLAXf8FpXpufFd9YyPw6BUkHR5rhb5H6SrNjxrtTC
         bLKPabwUxOMJpBZ8z2s6V1aaQRNo7z2ECMY4jXU2ZLjSsI5Z4DwgNgOVhmqI8EbE43u4
         ftQo3Lvh7596KjGlT5UH78n/IKT07TXkhIVkjIW7Z6+wK0yBCi6QO8lpMmxwl58BxGMM
         aDwwXj0+kG79aQkCgbOjmaAK8HRbzvP5ICTRsDC61wfp8me6QMlIlyIe5sif1iUYfTNn
         /5llEUip6J5uZm8giIuDQNydPacrzGX9SqrPDhb5dUDSo9KpolbqSvpwJsQ7iIvkUUGt
         o/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=kXW4q7S4Jg2rtxoPxio8ec2bXWVGT+1Urze9RICskNQ=;
        b=bOKVfQvBh4nBbDfzpkeiEdWgiOcheCi6stXdYHv23TrvADJiK2ANEmCgu9ShdTQ19u
         nHQJX4qjs2w7TQdx48ET71kVr2DthHInLXlFi0EFJGDWdsiZtY9QhGh+3sqFN5sNXw3o
         C/U3i+JPtE13vo5Y4cfkNGJWEX+ofiUHNIaMiEKcjf1mWg473KoKiShEXfsKySBzy5Np
         +MSpyS1mU+r08nOViRdulRwG1aFF4kcZm0buzE4xASljfSNNVfqHJQC7ZNQq/ndPmgjC
         sNvSWPlWLMs6VK5k7XQdE1/Iz2oZdajA3KujNgY/sAHnEe4E8Gu+Mov1rdXDkApMOkUE
         WGOQ==
X-Gm-Message-State: AOAM5321MPeuLdaIRs5kjGr7QQsKs5/o5+LAPdqKfbVD29es6gVI9nuW
        jJoiNG6YekEnPTFDTxg2Qq726XLgY3ukgJXAHOE=
X-Google-Smtp-Source: ABdhPJwjZdwJbG1VG+WxrUtulpkpPN20unU7UMnL25YSvYqMeeCSb+lu+ZneI8BlK0J8SFB92J4VsEeHiy3FXDm2S/k=
X-Received: by 2002:a05:620a:170b:b0:4b2:acf5:d06a with SMTP id
 az11-20020a05620a170b00b004b2acf5d06amr3991766qkb.327.1645176504252; Fri, 18
 Feb 2022 01:28:24 -0800 (PST)
MIME-Version: 1.0
Sender: nicolemarois101@gmail.com
Received: by 2002:a05:6214:1d23:0:0:0:0 with HTTP; Fri, 18 Feb 2022 01:28:23
 -0800 (PST)
From:   Miss Qing Yu <qing9560yu@gmail.com>
Date:   Fri, 18 Feb 2022 09:28:23 +0000
X-Google-Sender-Auth: E4ppi_REFXbtbiPOICOTu8My_fw
Message-ID: <CAKZDbpx7HK24z8z9NSPhe9a5pOQ6ZG837HZsoLkCwhumGmFjOA@mail.gmail.com>
Subject: Hello!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_SCAM,LOTS_OF_MONEY,MONEY_FRAUD_5,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I am Mrs Yu. Ging Yunnan, and i have Covid-19 and the doctor said I
will not survive it because all vaccines has been given to me but to
no avian, am a China woman but I base here in France because am
married here and I have no child for my late husband and now am a
widow.

My reason of communicating you is that i have $9.2million USD which
was deposited in BNP Paribas Bank here in France by my late husband
which am the next of kin to and I want you to stand as the beneficiary
for the claim now that am about to end my race according to my doctor.
I will want you to use the fund to build an orphanage home in my name
there in your country, pleas kindly reply to this message urgently if
willing to handle this project. God bless you and i wait your swift
response asap.

Yours fairly friend,

Mrs Yu. Ging Yunnan.
