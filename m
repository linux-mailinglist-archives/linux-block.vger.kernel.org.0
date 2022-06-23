Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57738557F3D
	for <lists+linux-block@lfdr.de>; Thu, 23 Jun 2022 18:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbiFWQD0 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 23 Jun 2022 12:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbiFWQDV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 12:03:21 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F9736E0A
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 09:03:20 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id eo8so29250685edb.0
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 09:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=mTe6rsF1WlocKfWRCIawejpNJl6lRYSIlYxDz8jltlQ=;
        b=Oo54/7EXRXBUyLwVCXSuq1fJyMIZ4fW39DUCSH/oLByFn2aUQBw/pvk81Brs1f3L8U
         KUhxxAMgvQDXg49Gld7tTqXkjY+s52EBYYiVXYy2PvPjunbBkSzU1fpIHc43sx/hIuq4
         svIS3GABSbEOW0UFc08W4WIhZ1H7pA2cVGisVTEEXKJl2RvaYPq+2Lxzn3pQ5xT2W101
         qMzgPL1wsAkWfkQCwgEj6UAe20NZhXaP4+ewR7bSSQfHHFgvagmKec/QejOPMWQ1TJ7Y
         7yBlJWNxsq2oWu7wdWlmgk88lGY/oa2lyMO5B3kThJ97JMGlsziIqZWrY8Bz7S0f0a9q
         idQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=mTe6rsF1WlocKfWRCIawejpNJl6lRYSIlYxDz8jltlQ=;
        b=a7dUAJ13FOqISwDyH4Ym30vj06LXpvD3s/pJMIEQIf7DH3Fyerv5FKnmAnJj7sKtan
         8Yw2VVVRPqsXCPquk5O5REhDIC1FmKeQT3KnUMLBYu7WBBEZUZJQdacDe6n2zbGH4Giq
         Um6yfJhZEkHPTfMqWYWsMvSbESosX2RydO0VJn6pPHC2pg/nNAXpBi2YHCoCg3bd2Iav
         3zIbne71l9w8Tl1JqEoRIyqK+RASiQz5sIOy/1L6IwqNxkLvcWeyDQRJMfkEa+ElatCD
         uzsgMOwWfqvDamKJs+yZxdFW4tIKZe2Z8ardMyzK44SjWwo8g+gLxiq58pH/tAwRZrbf
         hkgg==
X-Gm-Message-State: AJIora8YxXTenzaAR4x4AuSNCvvCJJxvehERR/rQQ5bYqTbZZzQ0BBA4
        VlAmuN1vevQZOIH+pFfLhKbrMUGlF4t4VLEyHM0=
X-Google-Smtp-Source: AGRyM1tHrFzVKEdz/hOz/utjDqBM5pnm53oce0BM0LDgCKw4GawhkTarc3dkflNbtgI0splIZ0QwxCx4sHYpu8c12x4=
X-Received: by 2002:a05:6402:50ce:b0:435:a2bf:e44d with SMTP id
 h14-20020a05640250ce00b00435a2bfe44dmr11822051edb.386.1656000198020; Thu, 23
 Jun 2022 09:03:18 -0700 (PDT)
MIME-Version: 1.0
Reply-To: zahirikenn@gmail.com
Sender: salifissa01@gmail.com
Received: by 2002:a17:907:6089:b0:712:57a8:5cc7 with HTTP; Thu, 23 Jun 2022
 09:03:17 -0700 (PDT)
From:   Zahiri Keen <zahirikeen789@gmail.com>
Date:   Thu, 23 Jun 2022 18:03:17 +0200
X-Google-Sender-Auth: Om42RJtW1Jna-HZxiF01Fep6mKE
Message-ID: <CAKZj0cpar5rDmMBPtsJ0EtxEi8OgLBm-E9n05VAR7BtFnusNYA@mail.gmail.com>
Subject: URGENT.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Good Day,

I know this email might come to you as a surprise because is coming
from someone you haven=E2=80=99t met with before.

I am Mr. Zahiri Keen, the bank manager with BOA bank i contact you for
a deal relating to the funds which are in my position I shall furnish
you with more detail once your response.

Regards,
Mr.Zahiri
