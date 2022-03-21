Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF524E2ABF
	for <lists+linux-block@lfdr.de>; Mon, 21 Mar 2022 15:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349248AbiCUOa3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 21 Mar 2022 10:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349408AbiCUOaP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Mar 2022 10:30:15 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8497558E5B
        for <linux-block@vger.kernel.org>; Mon, 21 Mar 2022 07:26:14 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id g138so7910321ybf.5
        for <linux-block@vger.kernel.org>; Mon, 21 Mar 2022 07:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=wZHnqBSae63vK9bA1tspxWUm/wGqXcwXQvPA20fn1E8=;
        b=RxoXLnoM/seN72WejG4jeqZCW3u9lcqPFeyYzL5bFZ/M7TGoWzCHPeLf7WEaRufeoO
         cBhuBJESuTnsEi5g9yk+wf1IJb9IQhiJvqmWzbqRRltYAoTxN2BhkZsrkae8bQ4qq40Z
         AF2Kx37zA3iG06IdplevsX91W2/wc2FgCld9G0xgXI5PVmoI9sW7S8CEEU5fPiQP1kmL
         N47bzt1kHhTiP/0X2WQUQc5qL4tZ2uTtlaMDSKKwVefv9y4LEpzWM7Zvy5LtTAV9qoBu
         30y8haPCJW3i5ozsacvPHMjS5Ff8pvAPjfs159VesuTzQ0+Qh0FDtpKeXbVrSGvRH/d/
         g4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=wZHnqBSae63vK9bA1tspxWUm/wGqXcwXQvPA20fn1E8=;
        b=x4I+SbfjGOG+YIMgxj8yFeQWUTgbjVbOT5cShWRDWlVZQc7cPaPYpupzTAqqWTW5/z
         Tyc6s8TjLNV5wY9dXXW5ieEyeyMNEeCEXuPzCEvwrlZJ9QCEXs8cwT4MHmzjSOUGrR9c
         BT3qjNeKCEPvjz1vfm7TqFmpXuGYFbc9WCcz/bs5BoIGfLAJJd4lvFjfQIwWdgLd25x3
         z4jR8vcBovsGTO2mWxeXd0hX76L08Cq12sSJzx+yY4fJV7KA/9UoHHMzKfkmc2rhB4hj
         +q1+6r3HXkZsG4nOHRmHB3em+RQasNHIFHPzlRGj4KIn8ezOLnm3lGiAZfyAxiG777jv
         u1Ww==
X-Gm-Message-State: AOAM530qnVHFGujXHz60bajSzwy86fYjQwMycP7ir0T6+Oc2ex0jFlqo
        PtlhfzYz4lZKi6wV4swZ1H8ceeCIgBe2Om4ycG8=
X-Google-Smtp-Source: ABdhPJyQ+BcbNvMRleX5zh7GojOOVirMgwa7oT6tJvw4PeOws0/+OhSl6ZaY5KxPQpgFDuGcI9y2x6bG4IiBYbJLumQ=
X-Received: by 2002:a05:6902:1388:b0:624:6892:5495 with SMTP id
 x8-20020a056902138800b0062468925495mr22381739ybu.379.1647872773809; Mon, 21
 Mar 2022 07:26:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:1713:0:0:0:0 with HTTP; Mon, 21 Mar 2022 07:26:13
 -0700 (PDT)
Reply-To: orlandomoris56@gmail.com
From:   Orlando Moris <pedroati060@gmail.com>
Date:   Mon, 21 Mar 2022 14:26:13 +0000
Message-ID: <CAKX=hRsVXW_MEwqDDswSg+Awv=2LjhqMfNfCX0w9QyZQAT5fzw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b36 listed in]
        [list.dnswl.org]
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [pedroati060[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [pedroati060[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [orlandomoris56[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.8 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  3.8 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Po=C5=A1tovani, obavje=C5=A1tavamo vas da ova e-poruka koja je stigla u va=
=C5=A1
po=C5=A1tanski sandu=C4=8Di=C4=87 nije pogre=C5=A1ka, ve=C4=87 je bila izri=
=C4=8Dito upu=C4=87ena vama
kako biste odmah razmotrili. Imam prijedlog od (7.500.000.00 USD) koji
je ostavio moj pokojni klijent in=C5=BEenjer Carlos koji nosi isto ime s
vama, koji je radio i =C5=BEivio ovdje u Lome Togou Moj pokojni klijent i
obitelj sudjelovali su u prometnoj nesre=C4=87i koja im je odnijela =C5=BEi=
vote
. Javljam Vam se kao najbli=C5=BEoj rodbini pokojnika kako biste mogli
dobiti sredstva po potra=C5=BEivanjima. Nakon va=C5=A1eg brzog odgovora
obavijestit =C4=87u vas o na=C4=8Dinima
izvr=C5=A1enje ovog ugovora., kontaktirajte me na ovu e-po=C5=A1tu
(orlandomoris56@gmail.com)
