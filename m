Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3088C4DAE60
	for <lists+linux-block@lfdr.de>; Wed, 16 Mar 2022 11:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351029AbiCPKnU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 16 Mar 2022 06:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239636AbiCPKnS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Mar 2022 06:43:18 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A440C63524
        for <linux-block@vger.kernel.org>; Wed, 16 Mar 2022 03:42:04 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id t1so2172288edc.3
        for <linux-block@vger.kernel.org>; Wed, 16 Mar 2022 03:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=CNNPGySxSq7bZ1La6vvay1kp1T7RaMnfdFjrr49KhAk=;
        b=NQ4IZQ7LV4axjH5VKIGbH/q7HUxbePeZyiw5I288ZreJ0T0khomjZYethD1RmY9YqK
         PLdR3xV4HAsDN8K4ZsQsoiAUPgPN5WYbpQuG4uskgTxx88eiG4d4Q7uxsPLuDKF0RquB
         TL92sgkKVHQTfJ9L9vC5m51k0N/2lnF9pAQyIZaf87pH/X/IXCw5eHocTClIxgd4hWLX
         nWgc4X42o0607vJkflRX53hjlUQsoPyHTxlR5bc0W1tO7x9HQ57MJESggntkqByuUjA2
         HOP3otLuhvNgtaRE97TogN7nyk5TnPuJFMMUKFEQglK0R+/WZ6WYsE+2JiCXe3urOQZi
         8fMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=CNNPGySxSq7bZ1La6vvay1kp1T7RaMnfdFjrr49KhAk=;
        b=Z3QjVEukrmeYrWOxlx9VQVPW+KLFxmpCnpUY/EHW+J3PcIwulkp+ugcW0JUTgcI97B
         SRNXwEjZ04DQuNB3kyOvFDcsakwIhD9+h637vzqFNsL+bowLIjcDR9iYL/RMNXzTXg8i
         6kT6Xp9k+7L10ENCswBamw4DBzIFNBSuN73Z1N4CnCL+8d9VAFDZcAE8jKz4UGXe+fBX
         oOVV4WmgptbYwc98ujuKhMQDRR6IMqkdUgxpgw7Vivi+vQMCtWKkgA5jA8Mu58TPp5MO
         eazWAjLH6hBsb+m3yDHOGCmOHFDvTOsOA2zCik2z7HF2a14RW+d1ERzFRs2n0fGkrgzp
         5i2g==
X-Gm-Message-State: AOAM530jsqhdRMladJhp4YznVaGBBh/EQrz1qRWOCQ1PDtQWYMFab/7U
        Ob3wMhQPu7r1lJ+QKZWQ7rQ/JAbh7HW4WcGb0ho=
X-Google-Smtp-Source: ABdhPJxHrSt+CF9unJd3keB7gYI5Tpe5fZ80GTNYrSbuShHrW7+eygMXP3fhmjrANS1HAvl/gBERkn4wz9UEZhYUGDg=
X-Received: by 2002:aa7:cd81:0:b0:410:d64e:aa31 with SMTP id
 x1-20020aa7cd81000000b00410d64eaa31mr29462480edv.167.1647427323091; Wed, 16
 Mar 2022 03:42:03 -0700 (PDT)
MIME-Version: 1.0
Sender: mrslila67hber@gmail.com
Received: by 2002:a17:906:1751:0:0:0:0 with HTTP; Wed, 16 Mar 2022 03:42:02
 -0700 (PDT)
From:   "Dr. Nance Terry Lee" <nance173terry@gmail.com>
Date:   Wed, 16 Mar 2022 10:42:02 +0000
X-Google-Sender-Auth: q4mG5HrvkBhNpApN45wZrF75xgM
Message-ID: <CAGq_i_1WGAZ8RvOCGo-3s2y1cp2KAxnarTU1eYfhmRaZJbOTFQ@mail.gmail.com>
Subject: Hello My Dear Friend
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_SCAM,
        LOTS_OF_MONEY,MONEY_FRAUD_5,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:541 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrslila67hber[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 HK_SCAM No description available.
        *  2.4 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  3.1 MONEY_FRAUD_5 Lots of money and many fraud phrases
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello My Dear Friend,

I am Dr. Nance Terry Lee, the United Nations Representative Washington
-DC - USA.
I hereby inform you that your UN pending compensation funds the sum of
$4.2million has been approved to be released to you through Diplomatic
Courier Service.

In the light of the above, you are advised to send your full receiving
information as below:

1. Your full name
2. Full receiving address
3. Your mobile number
4. Nearest airport

Upon the receipt of the above information, I will proceed with the
delivery process of your compensation funds to your door step through
our special agent, if you have any questions, don't hesitate to ask
me.

Kindly revert back to this office immediately.

Thanks.
Dr. Nance Terry Lee.
United Nations Representative
Washington-DC USA.
Tel: +1-703-9877 5463
Fax: +1-703-9268 5422
