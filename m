Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C649379F0E3
	for <lists+linux-block@lfdr.de>; Wed, 13 Sep 2023 20:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjIMSJc (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 13 Sep 2023 14:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjIMSJb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Sep 2023 14:09:31 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B80419B6
        for <linux-block@vger.kernel.org>; Wed, 13 Sep 2023 11:09:27 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d814c00a801so117947276.1
        for <linux-block@vger.kernel.org>; Wed, 13 Sep 2023 11:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694628566; x=1695233366; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oe65b0whaWRnNllzdFmRrJJiqTy+Id9oALP4andU5pE=;
        b=P8/7s1Esi3ch7IsFdXbT1o98T2xRH44VLgozAqDqVAylcpPBOkAyyk32XTqw9D2yRx
         nnL3Ia4e9Hs6DPhiikzhimvpWz8xIucUikJTmh5TYJ7EN9tN+rwOfJS/3ZsZG61+WcM6
         v5VOA3n9O84Qc9amL5pecZ3Md4faiUl2Rn+CjFJOIuCu+RUsAaitHADDCwn0I/Gkp+0M
         FYwn3+VeCNrJ3s3KtRK9rCl46rE7HS9q32IPB9vVWczIST+4RUEcUNnh/GVzCt6HOBqa
         CWw/z0yE35jwmM4I4vN+0nNW0GAJESEa1hEh6liTy8QWCr5UT4bI3nMCByFL9Mz4Z/7o
         xRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694628566; x=1695233366;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oe65b0whaWRnNllzdFmRrJJiqTy+Id9oALP4andU5pE=;
        b=ICNIK2/6zDUo0uhsdAvp5ESZL6NcH8zppQ5qRPfmEo49NB5Po4o5FszsZHPjeSnri8
         8z/eVjf1POPNKkGIr28ZnjZV9EZ9ep+NMJi7BVW82F7f2rzhi5EzcQgVLTrKMkvEKgna
         4ji74fNeNi10ECUqqL7SKAPwYg/io42pBu2NVnpEEJKeeOTTmQtH6E0B6lcLZGMJpEnQ
         FAwBnTT3tgNEJ73oDqRynvH6aduB3hErF0smgMH4YPo4RMTswiSOuHSeBcyrQ/OmLVLp
         hLbx/Zpiyq5t5Rpmx9V4r+9yO16k8BFx+nWpqkAqIisS8v4S/HgbVjuYwJ1Dn2G+vVH5
         6oiA==
X-Gm-Message-State: AOJu0YzEVHuRy1n3n8vE5MKwswcWd0+7j4lKUubXiozC0zKHGF7ZcDq3
        1YyYcstY0VaA65giJOkANiXMivaIPnRPhPsIsms=
X-Google-Smtp-Source: AGHT+IHWQg0oRvoGM3QXmM/0wFf//dETlvhVdxvkxC2DbQn4N0ZHImSxceoozN7WAFbzOnbvwghAuzH/djRCdU4LUzk=
X-Received: by 2002:a5b:481:0:b0:d7f:943c:1824 with SMTP id
 n1-20020a5b0481000000b00d7f943c1824mr2993097ybp.20.1694628566521; Wed, 13 Sep
 2023 11:09:26 -0700 (PDT)
MIME-Version: 1.0
Sender: brunellelaurence69@gmail.com
Received: by 2002:a05:7000:3750:b0:50e:af10:52cb with HTTP; Wed, 13 Sep 2023
 11:09:24 -0700 (PDT)
From:   Hannah David <hannahdavidw12@gmail.com>
Date:   Wed, 13 Sep 2023 10:09:24 -0800
X-Google-Sender-Auth: U7ywWfrZxOA_fGQ7YVOXUwUlG1c
Message-ID: <CAA4znVgSacaJNjGm6i38x11o-CxwcVBBNPUxied2+hYiOi=qwg@mail.gmail.com>
Subject: Good Day My Beloved,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Good Day My Beloved,


written from Hospital.

It is my pleasure to communicate with you, I know that this message
will be a surprise to you my name is Mrs. David Hannah Wilson, I am
diagnosed with ovarian cancer which my doctor have confirmed that I
have only some weeks to live so I have decided you handover the sum
of($12,000.000 ,00) through I decided handover the money in my account
to you for help of the orphanage homes and the needy once

Please   kindly reply me here as soon as possible to enable me give
you more information but before handing over my bank to you please
assure me that you will only take 40%  of the money and share the rest
to the poor orphanage home and the needy once, thank you am waiting to
hear from you

Mrs,David Hannah Wilson.
written from Hospital.
