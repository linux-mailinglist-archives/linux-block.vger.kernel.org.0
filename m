Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B094D65C254
	for <lists+linux-block@lfdr.de>; Tue,  3 Jan 2023 15:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbjACOyx (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 3 Jan 2023 09:54:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjACOyw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Jan 2023 09:54:52 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216ABF5E
        for <linux-block@vger.kernel.org>; Tue,  3 Jan 2023 06:54:51 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id m18so74164837eji.5
        for <linux-block@vger.kernel.org>; Tue, 03 Jan 2023 06:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2twQ37jPMe6VwAuPSxCgfvCJRlKd1+KCYukDJt0+UY=;
        b=CeDKvgrP2Fi7W9oc9gbC3tPLfHuC7GLZK0AocpjOpT1nzmkcpbOmBhlCgNDNglRl56
         TaqdLp3byCOMjlOdCoweDP1FfxhDKFYx7/PlqWNtyk841RhnknzicaGnPnXi6kFipaGM
         XOYSJvnUwH0vas+W5LErQDnmxDAmoy3DXGbbVcKdzWbPxil7vYrnRT8waTM9mDqJoh8P
         Q/oum9WCETFMjwUq4NlqR5u7XWKobwwG4SA8z9LRsjqZmkRZxszn1aFraO9LLJ8TjxVt
         oCtcQvVkSs2UpP/GrTIRNRSld5eRWfaG3W0VYpZ5WIvU/yG+jrXECgRoM52/4wVzysCq
         Z0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e2twQ37jPMe6VwAuPSxCgfvCJRlKd1+KCYukDJt0+UY=;
        b=CNk6kGRm6hHvchSr/odXrwcfkdFxkvwZHGOIsviCmqjjAF0moUXLr8SNgo3mBUcgUL
         RJV5o3ZAkLKmlnw2etFKiGhYMZNp41FxFfrD75xChD+jXQjxBIR6qJixRg/rkJ1DWyYC
         EeD2EXSsJfbIiBxJfFuUvMQy/OahIyepZxezsAlnhe1deLmOJY7Zv76qokXdG1FOrJg5
         4p4ICB+TnA1CojyZfAaWcoJEQEf8legUMXn1oZPI7s2jGodI4EuLyMyg8qFf3kL/NfYd
         9Jsm7l2mW37SQTWU1+NmXCLsfsvtQziIKDIRqArZKUBr1IZkeqYbmLykC7x39Y+dJTM6
         8ioA==
X-Gm-Message-State: AFqh2kqks0f6dVPiuXCvZ4uy7RsJQwQiosKcxXDwmSUSScVvU9prl/zD
        JmAD6g0DgKxBIrttgGWk/z/UuA==
X-Google-Smtp-Source: AMrXdXtw1GtV6Yw8DGLoCa5bl5+sfTyvyIlHFCSBuVF2i7tt7fm2WYFgr/F8/aAel337A+NGoRACTQ==
X-Received: by 2002:a17:906:33d0:b0:7e0:e1a2:dd98 with SMTP id w16-20020a17090633d000b007e0e1a2dd98mr38598330eja.67.1672757689696;
        Tue, 03 Jan 2023 06:54:49 -0800 (PST)
Received: from [192.168.20.233] (mob-5-91-46-2.net.vodafone.it. [5.91.46.2])
        by smtp.gmail.com with ESMTPSA id fy11-20020a1709069f0b00b0084ca4bd71b8sm5020321ejc.208.2023.01.03.06.54.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jan 2023 06:54:49 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH V13 0/8] block, bfq: extend bfq to support multi-actuator
 drives
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <9a01e386-0fb5-b074-a7b1-7e4bcf1ca204@kernel.dk>
Date:   Tue, 3 Jan 2023 15:54:47 +0100
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arie van der Hoeven <arie.vanderhoeven@seagate.com>,
        Rory Chen <rory.c.chen@seagate.com>,
        Glen Valante <glen.valante@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0D112272-05AC-4919-9454-8BA6057CDBB7@linaro.org>
References: <20221229203707.68458-1-paolo.valente@linaro.org>
 <9a01e386-0fb5-b074-a7b1-7e4bcf1ca204@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.11)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 2 gen 2023, alle ore 17:53, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 12/29/22 1:36=E2=80=AFPM, Paolo Valente wrote:
>> Hi,
>> here is the V13, it differs from V12 in that it applies the
>> recommendation by Damien in [2].
>=20
> This doesn't apply to current master. Can you send one that
> does?
>=20

Sending a rebased version ...

Thanks,
Paolo

> --=20
> Jens Axboe
>=20
>=20

