Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B54D53F71F
	for <lists+linux-block@lfdr.de>; Tue,  7 Jun 2022 09:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiFGHZW (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 7 Jun 2022 03:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237638AbiFGHZT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jun 2022 03:25:19 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BA8C5E6D
        for <linux-block@vger.kernel.org>; Tue,  7 Jun 2022 00:25:15 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id me5so32807816ejb.2
        for <linux-block@vger.kernel.org>; Tue, 07 Jun 2022 00:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=OHbou33WPhW0PDy9/CZae9mIrL4buN3/FALSld4obAM=;
        b=qVrDof9vanH1ajQ6IVWvHD4BBDe5xTcJt7Q9aWkjfamvnkXfamNdFsiBONFS752ZFR
         Cgy6wyT4ak/7aOcCecYWKTGfd0TKtOI7cmdD2hPaRnMhaLG83G4nJbM+bjMcMB/ToGrI
         D1NyLnTJguZWAoVKBY5Z28c9ZOhWFjaBEzfWIsYw7EymiN2g1Hw1mOc7AS4DEVMsZBm9
         CPOs83Yg8AD9uISa27J2G6ueYuuO1ETOMYkyS0ifCrKMsDaX3XlNEXRQLwdpSWuQ4pyQ
         i6/mAMU8mP+86CIxhsnjpeoRb9v6weeJiulIuF17z+8LzAW28Fbz+aJDAKIfjl+0ciy0
         kneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=OHbou33WPhW0PDy9/CZae9mIrL4buN3/FALSld4obAM=;
        b=oWTsDfion/UNKVjucA9AivwMILR0k+jyU+PYbh6G/wpLCheqpYMlOE5SxmcY+ooykq
         4KhSxP0WXOV4UBSvEzJV1TISzIhfcpmWIvVnAiUAaYjDaAI2l/52DmymY5OZbM3a94CL
         WMeHbIYnA9FarkTbPgVEC9/GjcO+bNVGdDfq1rX+jhiW1pr4LTSi+u37+y6jsuUlGADH
         fyJUu3ZCmDv5kFu5+JIsRkrOJP41PCMcgrXx5dMcvhU+/nP94hNdcDbvV1K64lXxsXbY
         FvT0vzWLjuLRA3NlCyaxvXQPf1LxjglwIKs+R81YO5C5P22X7wl54sOHb5G9CoqEQxRp
         SN4A==
X-Gm-Message-State: AOAM531WBcROGllglFuhbwHmMU4Z8wUG6ANNsqGkbjBMachpOeNm6bcA
        8+23AqcSNxyCHXNZocPgFHQQm/lTSAPUkdzFY6M=
X-Google-Smtp-Source: ABdhPJwIvD3vOdI13uReqiZuVnPYUIN4V5zgHQ/dHq27CvUTKvdGXZZijRoxENuELWvoKRaRJg1HqWzhZb88K61h7aU=
X-Received: by 2002:a17:906:1c4e:b0:707:959:8cfd with SMTP id
 l14-20020a1709061c4e00b0070709598cfdmr25339945ejg.738.1654586713970; Tue, 07
 Jun 2022 00:25:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6402:26c8:0:0:0:0 with HTTP; Tue, 7 Jun 2022 00:25:13
 -0700 (PDT)
Reply-To: andyhalford22@gmail.com
From:   Andy Halford <fameyemrf@gmail.com>
Date:   Tue, 7 Jun 2022 00:25:13 -0700
Message-ID: <CAATdNateRSa_FebwZe5nba7aC_MVE_=LP4vy1DCLzAk67XF5Qw@mail.gmail.com>
Subject: Dear Friend
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.8 required=5.0 tests=BAYES_50,DEAR_FRIEND,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:644 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [fameyemrf[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [andyhalford22[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  2.6 DEAR_FRIEND BODY: Dear Friend? That's not very dear!
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.3 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

-- 
Hello Sir



  I am Andy Halford from London, UK. Nice to meet you. Sorry for the
inconvenience it's because of the time difference. I contacted you
specifically regarding an important piece of information I intend
sharing with you that will be of interest to you. Having gone through
an intelligent methodical search, I decided to specifically contact
you hoping that you will find this information useful. Kindly confirm
I got the correct email by replying via same email to ensure I don't
send the information to the wrong person.



REGARDS
Andy Halford
