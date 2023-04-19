Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780B76E7972
	for <lists+linux-block@lfdr.de>; Wed, 19 Apr 2023 14:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbjDSMN5 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 19 Apr 2023 08:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbjDSMNz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2023 08:13:55 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DFB5FDF
        for <linux-block@vger.kernel.org>; Wed, 19 Apr 2023 05:13:54 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d2e1a72fcca58-63b5465fc13so2465090b3a.3
        for <linux-block@vger.kernel.org>; Wed, 19 Apr 2023 05:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681906434; x=1684498434;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Eq/+hxv6rbp5uii7WLq/eUzzzvxSNpILeR22fC9c7Bo=;
        b=JL7gE0VNj7uriZDpfyjD7izaGr8+X5bjd+cWWcUXD8rHGsnBotCBYmQD7XpJzwHmLx
         FO0y67iJm3lQ+HQvg7JM4669WCOe5G4YI/7NPxI7nyGW/Uzpma9uYquo5Lr5C7sbLNrI
         J4M8oMT37l68PmxW8QEy0T9muDEWel5vZDUddwSo4aKQpsrTw2ENe+W5bix/1XLLPi7E
         CBwpyC/6ubhLgFiKf5PKKpfIckzPnioScRPQzv6AXPpcwl9prVgZ9Zmp/F7/hTLjqt3v
         DuidxHMshD8WCpG4RTIxzhyGqO6nx3ElP4gKYNrczXuq9Y2TBmmO6pRxdz++ptKiHX/q
         n/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681906434; x=1684498434;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eq/+hxv6rbp5uii7WLq/eUzzzvxSNpILeR22fC9c7Bo=;
        b=A+zTEre5gJU+CA+CH5U+f/4qo456Fsr7LVjBSqfJhPdsbl/x1q/7f5HgMyPxlaEmhb
         Lp9oHBC/Qei6HE+mGIr9+r+9fe9scZB+tLXaNMxNoMFuIFFPoNWj4VHAiYBg0B6sP4u7
         TKJNxo/Pb7IgznBJ8o4mGAqWSBiSpE8WHks8YF8VQf0dALwAtSH9V5ctUtGRelvB6/uk
         zvFJ4N2WTxAoDXXu1li5Or5FBMsK5l7imzUVWYsYghLVUMXluN6/D3jkJ0eHVpYneoK6
         4RCLMupCcmdu9A5ez4UX04nIzJonD0qk/oJhp+aniuqwgYqliXqRMLRM2jv4aFeh26Ab
         Vp6g==
X-Gm-Message-State: AAQBX9emQqqYrG1xdMy4gPmwumlNupPqqGquaw0FnnUwo+rseh/4urTy
        stoc/xELNmfyl0iULkqmxOgAJDKWkXacAHjTLbI=
X-Google-Smtp-Source: AKy350Z8193hSTj2Lk5/tNKd8Hngk4wkQLbbh+fhGOYHjwjNaNp8kbj8GzCZ8aSIB4cSdJOFhbgMep14P+fmSwLH57U=
X-Received: by 2002:a17:903:d1:b0:1a6:9430:5ac2 with SMTP id
 x17-20020a17090300d100b001a694305ac2mr1901272plc.12.1681906433836; Wed, 19
 Apr 2023 05:13:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:902:ecc6:b0:1a1:b667:3f87 with HTTP; Wed, 19 Apr 2023
 05:13:53 -0700 (PDT)
From:   Mavis Wanczyk <infoorgv3@gmail.com>
Date:   Wed, 19 Apr 2023 13:13:53 +0100
Message-ID: <CACrHrORC=93HmdrrgON80QYCp80s50vD3WDpYyZnSOCcsowksw@mail.gmail.com>
Subject: From Mavis L. Wanczyk Lucky Winner
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.9 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_00,DEAR_FRIEND,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLY,
        LOTS_OF_MONEY,MONEY_FORM_SHORT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY,
        XFER_LOTSA_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:442 listed in]
        [list.dnswl.org]
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [infoorgv3[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [infoorgv3[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  2.6 DEAR_FRIEND BODY: Dear Friend? That's not very dear!
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.0 FREEMAIL_REPLY From and body contain different freemails
        *  0.0 XFER_LOTSA_MONEY Transfer a lot of money
        *  0.0 T_FILL_THIS_FORM_SHORT Fill in a short form with personal
        *      information
        *  0.0 MONEY_FORM_SHORT Lots of money if you fill out a short form
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  3.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Dear friend,

I=E2=80=99m Mavis Wanczyk the $758,700,000M Massachusetts power ball lotter=
y
winner! I=E2=80=99m giving away some money to my lucky followers, less
privileges, natural deserter affected ones, innocent scammed victims
and sick ones.

https://www.instagram.com/mswanczyk6/

I donate to you the sum of $300000.00 three hundred thousand United
States dollars by courier. Contact the delivery officer with your
names, home address and phone number for collection.

Contact person: Mark Robinson
Email: odalysastro@yahoo.com

stay blessed as you celebrate and thank God with me...

Mavis L. Wanczyk lucky winner
https://www.instagram.com/mswanczyk6/
