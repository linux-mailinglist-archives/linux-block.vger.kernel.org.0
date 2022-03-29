Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A040A4EB5FD
	for <lists+linux-block@lfdr.de>; Wed, 30 Mar 2022 00:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237333AbiC2Wbm (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 29 Mar 2022 18:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237306AbiC2Wbl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Mar 2022 18:31:41 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70306FF41
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 15:29:57 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id r7so11185723wmq.2
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 15:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:mime-version:content-transfer-encoding
         :content-description:subject:to:from:date:reply-to;
        bh=+v//v9bV1cKxYYqp6E5HrJfuFydY/JXcjMGnmfr7lM0=;
        b=fRxoLKijPXX0gWfSOADlQcwJyTx9LOR3ai7H4p1b6MaHFMoY3Ehr9cfIqKo45k670M
         UjDn8631ps03bSlJ4ErgBM7ueop2W498H8a7zH2NF/L4GYi1ysQoa0+qK0KiKyQYpGLC
         e3ZVmMm/BsUvh2K3x98jKCntUQ7AZ8mxpL1RG6Of5TBQb+j8qGVJWD1ynzOZV/+3u19Q
         VV3W75toqmVvjdL042AGmSq35C4X8qm2dnAXC7aLK332YwurD9nQHyuETpWhd5B6I88S
         wKM2s9QH3qAPRIEa91TDC9FHj19HdDBTm+C/gMTrXCeyK7TSbT/y/dQGeIGlK7vwFQQ8
         CFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:content-description:subject:to:from:date
         :reply-to;
        bh=+v//v9bV1cKxYYqp6E5HrJfuFydY/JXcjMGnmfr7lM0=;
        b=BG/jP8nHVBOMtQR6Thr3fVUI0rOxqPGy6QaH7GTjf1kGebO9i+xoDHKuCQFwTywzMz
         BvzVOrJ9RGuZb376+vDeYgexoSwQuGqiyMbAW5EjP0gqVjsgZ7fONCJ5ad5uT9UGSQpb
         SINBC1x/lo4uVhJZ0gsVZMLXUhh/rTDqyzvSXX8ENilUUQVibYeKtU4FTtJf3VPL2AOb
         FHbKRNBsUpaKgJ+E+cqtbObYeaU04PbcOyn07SJFszXaAs7wQsTzP/Wjh4kfc/i2grQy
         zWIMMVX8SIuyeuRgZSWT3UwG6rpL86FWw0OIAjfQViLP/jpoA3q3OR68Kypc0Swe8L6C
         Qoig==
X-Gm-Message-State: AOAM530XTVVpdnmDie8bq9pH/y5ai4LQX/HKWvGmXA03lF96EgBDlKOP
        OpgrCvL1pYRcM5ltKckO8lg=
X-Google-Smtp-Source: ABdhPJyIL3P5FjUoxMzCSx4fZboQPNj/ixRJLaDL0tNODa/398Zql8BnZJEVi5uPvh9wQ9pEHk/SjA==
X-Received: by 2002:a05:600c:511b:b0:38c:cb1f:b90f with SMTP id o27-20020a05600c511b00b0038ccb1fb90fmr1534024wms.109.1648592996116;
        Tue, 29 Mar 2022 15:29:56 -0700 (PDT)
Received: from [172.20.10.4] ([102.91.4.187])
        by smtp.gmail.com with ESMTPSA id n18-20020a5d6612000000b00203fbd39059sm16005026wru.42.2022.03.29.15.29.51
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 29 Mar 2022 15:29:55 -0700 (PDT)
Message-ID: <62438863.1c69fb81.4d4fe.f2db@mx.google.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Gefeliciteerd, er is geld aan je gedoneerd
To:     Recipients <adeboyejofolashade55@gmail.com>
From:   adeboyejofolashade55@gmail.com
Date:   Tue, 29 Mar 2022 23:29:46 +0100
Reply-To: mike.weirsky.foundation003@gmail.com
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_US_DOLLARS_3 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Beste begunstigde,

 Je hebt een liefdadigheidsdonatie van ($ 10.000.000,00) van Mr. Mike Weirs=
ky, een winnaar van een powerball-jackpotloterij van $ 273 miljoen.  Ik don=
eer aan 5 willekeurige personen als je deze e-mail ontvangt, dan is je e-ma=
il geselecteerd na een spin-ball. Ik heb vrijwillig besloten om het bedrag =
van $ 10 miljoen USD aan jou te doneren als een van de geselecteerde 5, om =
mijn winst te verifi=EBren
 =

  Vriendelijk antwoord op: mike.weirsky.foundation003@gmail.com
 Voor uw claim.
