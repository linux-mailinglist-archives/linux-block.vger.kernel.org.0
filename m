Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1048F784E4D
	for <lists+linux-block@lfdr.de>; Wed, 23 Aug 2023 03:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjHWBje (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 22 Aug 2023 21:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjHWBje (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Aug 2023 21:39:34 -0400
X-Greylist: delayed 918 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Aug 2023 18:39:32 PDT
Received: from symantec4.comsats.net.pk (symantec4.comsats.net.pk [203.124.41.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883C1E4A
        for <linux-block@vger.kernel.org>; Tue, 22 Aug 2023 18:39:32 -0700 (PDT)
X-AuditID: cb7c291e-06dff70000002aeb-3b-64e54ad37ded
Received: from iesco.comsatshosting.com (iesco.comsatshosting.com [210.56.28.11])
        (using TLS with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by symantec4.comsats.net.pk (Symantec Messaging Gateway) with SMTP id 40.DA.10987.4DA45E46; Wed, 23 Aug 2023 04:55:00 +0500 (PKT)
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns;
        d=iesco.com.pk; s=default;
        h=received:content-type:mime-version:content-transfer-encoding
          :content-description:subject:to:from:date:reply-to;
        b=Ks5OEUHMW1q3KP4KalDiCsz+su19w7+eq0tCXG3NBFRqmHZioVHQ8gOQLlCt3mJqY
          P+2HlkRxutiyDk0HI+kIUbn6hmTLJiqcnBP/hDdguLd1TVwSgwWO6b8qXRSENJdgT
          IouilZ5O80l6cyQRCTflfPuGOjxkYIgrZq0vdjWh4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iesco.com.pk; s=default;
        h=reply-to:date:from:to:subject:content-description
          :content-transfer-encoding:mime-version:content-type;
        bh=GMzYzcyTxDsE6wX/XHG6MHqAdAiHrhqbmmLQ/TZ1QnQ=;
        b=bnZDRxIBCtP0dUhJQTD8UQwDhDoIyMswYlDpaE44614EfsHc6bQmDDmBfhOHDVrF2
          OIRz6CgYaMbqmDSubHGhB3JuiMCgKwHLDRnAyYB1kA2SYLJjeJfBJNHhUwAX2JJna
          VMsh9LbfQtOAfhZmecpA0GPiaauMGhTxMOFW00z6Y=
Received: from [94.156.6.90] (UnknownHost [94.156.6.90]) by iesco.comsatshosting.com with SMTP;
   Wed, 23 Aug 2023 04:30:58 +0500
Message-ID: <40.DA.10987.4DA45E46@symantec4.comsats.net.pk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re; Interest,
To:     linux-block@vger.kernel.org
From:   "Chen Yun" <pso.chairmanbod@iesco.com.pk>
Date:   Tue, 22 Aug 2023 16:31:13 -0700
Reply-To: chnyne@gmail.com
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsVyyUKGW/eK19MUgw97BC323tJ2YPT4vEku
        gDGKyyYlNSezLLVI3y6BK2PJugssBbuZK9r6F7E0MD5m6mLk5JAQMJHYtOYsG4gtJLCHSeLA
        3uAuRi4OFoHVzBJPDm5ig3AeMkvcu3GaEcQREmhmlPjd9wushVfAWuLAxFksIDazgJ7EjalT
        oOKCEidnPoGKa0ssW/iauYuRA8hWk/jaVQISFhYQk/g0bRk7iC0iIC+xbEsXI4jNJqAvseJr
        M5jNIqAqceX6WhaI66QkNl5ZzzaBkX8Wkm2zkGybhWTbLIRtCxhZVjFKFFfmJgIDLdlELzk/
        tzixpFgvL7VEryB7EyMwCE/XaMrtYFx6KfEQowAHoxIP7891T1KEWBPLgLoOMUpwMCuJ8Ep/
        f5gixJuSWFmVWpQfX1Sak1p8iFGag0VJnNdW6FmykEB6YklqdmpqQWoRTJaJg1OqgfHatzmd
        a+rXlDZmWQbruKzJfb4g8QhHSGfryzy/U69yWN/reRo4u4QlSW2pOyh4qOk746ZVGiuXHv8f
        rbWFU8STMd00o38v3xMnzXNWfcKTHfstLTxFTlRO//3zk4B386+MUys9m7jf7o+9WxJjf6bK
        +oy6yCI+wfWb+rLZ3ij0ent8VhGRVWIpzkg01GIuKk4EAADbK6w+AgAA
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        RCVD_IN_DNSWL_LOW,RCVD_IN_SBL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: iesco.com.pk]
        *  0.1 RCVD_IN_SBL RBL: Received via a relay in Spamhaus SBL
        *      [94.156.6.90 listed in zen.spamhaus.org]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        * -0.7 RCVD_IN_DNSWL_LOW RBL: Sender listed at https://www.dnswl.org/,
        *       low trust
        *      [203.124.41.30 listed in list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Re; Interest,

I am interested in discussing the Investment proposal as I explained
in my previous mail. May you let me know your interest and the
possibility of a cooperation aimed for mutual interest.

Looking forward to your mail for further discussion.

Regards

------
Chen Yun - Chairman of CREC
China Railway Engineering Corporation - CRECG
China Railway Plaza, No.69 Fuxing Road, Haidian District, Beijing, P.R.
China

