Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F76F5B2328
	for <lists+linux-block@lfdr.de>; Thu,  8 Sep 2022 18:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiIHQJq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 8 Sep 2022 12:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiIHQJp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Sep 2022 12:09:45 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BFE1AF0A
        for <linux-block@vger.kernel.org>; Thu,  8 Sep 2022 09:09:44 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y127so18414851pfy.5
        for <linux-block@vger.kernel.org>; Thu, 08 Sep 2022 09:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date;
        bh=9ZFpt/foVGQHDYdWFxLDfNkzYkIk3H2JJygdZbdIkYI=;
        b=CKd584PJC4V0DVJotodveSDCdGCm9jOXzEkqpUHJj3DlRcgAvqhVsZ+KsZCCaRu9ZR
         gdczgohzBS+jl71eEZN/iX3pnBJBwaiJvTl46mOzUOywyX0gjgXkTeexP9kZqOS8r9c7
         APsRTyTcZZcYM34a47jlZX6l5/vWZQbuWJs30kjt0nfyXlk6C5OQmiWyFkYEDvLvwzQK
         TBxQ/fboQu9BFD5u51KPAS0+5wpzpHvrWH4f6mF8kLXfy1aH6boCKO1C3nBKlL2fdXLd
         BVWgQS8J+ETEGEZXC9n+YTAv9i+9hGrZTTOvE51oqZAh2YckrhyzPKvUBLHdLF6pug0A
         S1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=9ZFpt/foVGQHDYdWFxLDfNkzYkIk3H2JJygdZbdIkYI=;
        b=HHjn///m5WKl3HtyxqbuJmD0814e7BmZvv5iN3zjYjhOZPYUBT4Gn/R7s4Fr1pSqYJ
         Lbue3GIKC23TOUVCpIMxrFZS7s7vAVQK8xgSp8nUf30/kSDMrIy3Lk5ElHikjTboZzos
         JwefOAWKxIjylq+BzJrJYXX3nbPfAhKUier3RujPOX68jxE2zk+Pz0NkBafON5s7tmV/
         mTRvEI6a3EzJb2TlSpQCANRLGEXb4wZhXzKqg1zXMMzBO/iXDhzubNXMCMEJNP3DA6Hp
         /gtJEe21FMyBw/OXy0xE3OL+eIewTRvRyzTRRtc88zQZU6CCQ04x9gTkD0KTeNexizp3
         MXSg==
X-Gm-Message-State: ACgBeo3abAfEabPvbUFua0KZYXHUpzC0120gt5z8h8S4Y6VMKz+IJG8m
        EdhWhsSBBfnv0V/SzsoWMsWyBkANuUoCex0zYpo=
X-Google-Smtp-Source: AA6agR5M3PDAG/BAQXrY9Wg5Elxe5LLElJvItb0d5ErGW1XEc4pY9y3o4EbcqDP0N+J0XJ+/Z1l+IhcRO0wUyEKZqzU=
X-Received: by 2002:a63:170b:0:b0:430:93ec:7772 with SMTP id
 x11-20020a63170b000000b0043093ec7772mr8385034pgl.144.1662653383179; Thu, 08
 Sep 2022 09:09:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:902:788e:b0:172:abb9:6761 with HTTP; Thu, 8 Sep 2022
 09:09:42 -0700 (PDT)
Reply-To: cfc.ubagroup09@gmail.com
From:   Kristalina Georgieva <unitedbankafricau9@gmail.com>
Date:   Thu, 8 Sep 2022 09:09:42 -0700
Message-ID: <CA+WUezMhkh_aLnoA0Am2fWpbp+DHLnJEEHTbR6X6PzW6iCbBCQ@mail.gmail.com>
Subject: XUSH HABAR
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:443 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [cfc.ubagroup09[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [unitedbankafricau9[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [unitedbankafricau9[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hurmatli Benefisiar,
Men sizga bir oy oldin bu xatni yuborgan edim, lekin sizdan xabar yo'q, yo'=
q
Ishonchim komilki, siz uni oldingiz va shuning uchun uni yana sizga yubordi=
m,
Avvalo, men Kristalina Georgieva xonim, boshqaruvchi direktor va
Xalqaro valyuta jamg'armasi prezidenti.

Aslida, biz atrofdagi barcha to'siqlar va muammolarni ko'rib chiqdik
sizning to'liq bo'lmagan tranzaksiyangiz va to'lovlarni to'lay olmasligingi=
z
o'tkazish to'lovlari olinadi, sizga qarshi, imkoniyatlari uchun
oldingi transferlar, tasdiqlash uchun bizning saytimizga tashrif buyuring 3=
8
=C2=B0 53'56 =E2=80=B3 N 77 =C2=B0 2 =E2=80=B2 39 =E2=80=B3 Vt

Biz Direktorlar kengashi, Jahon banki va Valyuta jamg'armasimiz
Vashingtondagi Xalqaro (XVF) Departamenti bilan birgalikda
Amerika Qo'shma Shtatlari G'aznachiligi va boshqa ba'zi tergov idoralari
Amerika Qo'shma Shtatlarida bu erda tegishli. buyurdi
Bizning Chet eldagi to'lov pul o'tkazmalari bo'limi, Birlashgan Bank
Afrika Lome Togo, sizga VISA kartasini chiqarish uchun, bu erda $
Sizning fondingizdan ko'proq pul olish uchun 1,5 million.

Tekshiruvimiz davomida biz aniqladik
Sizning to'lovingiz korruptsionerlar tomonidan kechiktirilganidan xafa bo'l=
ing
Sizning mablag'laringizni hisoblaringizga yo'naltirishga harakat qilayotgan=
 bank
xususiy.

Va bugun biz sizning mablag'ingiz Kartaga o'tkazilganligi haqida xabar bera=
miz
UBA Bank tomonidan VISA va u ham yetkazib berishga tayyor. Hozir
UBA Bank direktori bilan bog'laning, uning ismi janob Toni
Elumelu, elektron pochta: (cfc.ubagroup09@gmail.com)
ATM VISA kartangizni qanday qabul qilishni aytib berish.

Hurmat bilan,

Kristalina Georgieva xonim
