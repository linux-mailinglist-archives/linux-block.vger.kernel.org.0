Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC91635A75
	for <lists+linux-block@lfdr.de>; Wed, 23 Nov 2022 11:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237314AbiKWKqb (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 23 Nov 2022 05:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236457AbiKWKqE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Nov 2022 05:46:04 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03F310EA2D
        for <linux-block@vger.kernel.org>; Wed, 23 Nov 2022 02:33:29 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id l190so17020289vsc.10
        for <linux-block@vger.kernel.org>; Wed, 23 Nov 2022 02:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c5E68Sr4LhT6Cylt6+xpmAj6iycfUFIjwiLn6lUKtfc=;
        b=XzK1rwGAgmXs1FPSOtdYxCG+6IPDXNKn2fjs1JBUkL/2YwQikRkSikYMWXsO8jSZSw
         hgXvQCC3J1hmQ/40gI1piY5p+7e60zqaM6lqQNNwtRA4Lq7toKBQxSkRXeyDFq5jYJuL
         NDJtjea1FzIRkg7LHwKHs7n1qr8fs/DQbS/iJJrDFiwsNgSgNFRIyp9CIZJllyZhkdFm
         FifLQ+i9cshqx2G0pbavrcpSl0FLymRMSQl/aIRLTAgiwDvtpPVgyMkPvyi8MhETKGt1
         FVEs+MM6zpNO110E5+gug9GvvjZvgkY5aoJnUtFObqsHYPlkDzFGMeJBNj/NJ+4Kw7aI
         WrTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c5E68Sr4LhT6Cylt6+xpmAj6iycfUFIjwiLn6lUKtfc=;
        b=AEcRE4to9yEOs+0CbMGlqs3Etaz+z5esoraYFEcvBGX9BjHsb49p4F6LUUj5EliIpP
         xOE0OcAGiok1JRv24AFJ5GB+ax5rdp4Zxg1sx+nXLSN3fv2+3VSUatL/uM0VOGA9b0kM
         LFmu46Ojf4x74R7Dmsmm6WGkBiuGc8PkvE7YU2c6NEmH8CAqMhpXst0154AlSeTLWXPo
         lMxI5u7LsCnxTE8BJUIKFipLPjciJFQImv9LUgBTr0C87+6Vz5o9et1nF6uVUX440Z90
         hiZS5haLnIu2/Y+oBzIKlN5zOfebYJerjxH+1C7cb7IV6XDodW8k7LDOShtkpFbPGg/1
         BUmA==
X-Gm-Message-State: ANoB5pljiZ4pTZCbZiVMoXMSvVH+2rJdLH1/12fhjjQ/Ob4P/L41GiLs
        drbQHnP6+eDfBlyuszLDiYvC/nOZ9C+dYsYZlvA=
X-Google-Smtp-Source: AA0mqf4MtKVi+gLlzk8CqgGYcgWsGHreylPBMUOVPjepAB11IhYlzHHrHKpzQfFejCA1UekmfvklzBIFwhOnAg9Xvj4=
X-Received: by 2002:a05:6102:25a:b0:3af:2625:b2bd with SMTP id
 a26-20020a056102025a00b003af2625b2bdmr4316186vsq.40.1669199595775; Wed, 23
 Nov 2022 02:33:15 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a59:cd86:0:b0:32a:c6ce:9c22 with HTTP; Wed, 23 Nov 2022
 02:33:14 -0800 (PST)
Reply-To: hegginskate7@gmail.com
From:   Heggins Kate <hegginskate7@gmail.com>
Date:   Wed, 23 Nov 2022 10:33:14 +0000
Message-ID: <CAEAJ=Vzxqt=JJCD5-0qTCDHZ7sgi+hMWZd1K=RZRrmvkFrGuMg@mail.gmail.com>
Subject: HALLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hallo, ich hoffe du hast meine Nachricht erhalten.
Ich brauche schnelle Antworten

Ich danke dir sehr.
Katie
