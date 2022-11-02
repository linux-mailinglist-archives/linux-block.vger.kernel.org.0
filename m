Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7955F6160C3
	for <lists+linux-block@lfdr.de>; Wed,  2 Nov 2022 11:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiKBK0A (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 2 Nov 2022 06:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiKBKZ6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Nov 2022 06:25:58 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4423F24970
        for <linux-block@vger.kernel.org>; Wed,  2 Nov 2022 03:25:58 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id e2so8708091vkd.13
        for <linux-block@vger.kernel.org>; Wed, 02 Nov 2022 03:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ddKdS4x8c4ZSI9PbKdla4xMHlbecpUYnHnf7KqPY/v4=;
        b=PRwQsumImJ1w+A81klK5cl5HbSQMLLj+xdE65DAptFirzwRVucG7L0cAOBTIgYwcGP
         Ef/MTQ/6PWdAsIAmRwGvGJi6qNadskzRF3hMBun/Hnlc50A6QXrlG34GVTiCPzzkadF/
         EbyZLZbyPlYfGWSR/20uMIV1XpH2S5Q1A9CcKVQ7r7aAZ2xS0vXfJKUQE6UthBFsVZ2l
         ptWwhY1Q5n7zCpAF/LI0owO2FT7KAKnH9Uf/JrEVWQ5JQaZUqCIqQWmMKIPFgg3FxedV
         4Crcj7XkYcuPKV8JyhTCcfxb25rye2GsmoezxZqQA0kZjxmAtXmIgJyHlYAfOHSyzknq
         Se0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ddKdS4x8c4ZSI9PbKdla4xMHlbecpUYnHnf7KqPY/v4=;
        b=fO3BWCBPhQ5NZJrEXHEAHWqTTTEm41y85Pd5MCx196BnJN4YqRH9IfDM71k44SiMiq
         kFnti+fltSPk3hX9pEh4/c7aKqKVIYZO0DCIPEoQZYZh8SgDTnpDNqMgP7ES8WELnk/X
         eGaO+YkXXhLFf5G9bQl6X+62DDCkEy4RHwf15I2KXlDkBDt5Sjxq3whqrbOdSWm05V6p
         ybFflaOQ6AaptZlo0zuilalUOLwmAZhpEXSdwAsXS0DSGWjjVJ5fwg/LEAnLfo8gy8v3
         DEsJheitVI9Nan/0pa5P9boMH1NCvd8rBaUL4CPz1HsSKxW4dRe+DKTcsJk3RjONiYoB
         fDUg==
X-Gm-Message-State: ACrzQf1Dkfm9+X44NmmfgHGJca8Bi0jkCT5TS+WcGwZRrkWiziQhMmCR
        qKRlj8FDfDH3Q2zpuOoH0x1fzfXvV05EoLl4iG8=
X-Google-Smtp-Source: AMsMyM4cDsgn9soSrkV/Cu1RCT5jVdcQzug0ImUZ4Z4LOwyKmBMTyh5ryRigeiyCaKvPkh8CkDAYEhIRZK4c5Z/HEj4=
X-Received: by 2002:a1f:e9c6:0:b0:3ab:aee7:841f with SMTP id
 g189-20020a1fe9c6000000b003abaee7841fmr11475654vkh.19.1667384757376; Wed, 02
 Nov 2022 03:25:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac5:c764:0:0:0:0:0 with HTTP; Wed, 2 Nov 2022 03:25:57 -0700 (PDT)
Reply-To: subik7633@gmail.com
From:   Susan Bikram <jbi880375@gmail.com>
Date:   Wed, 2 Nov 2022 03:25:57 -0700
Message-ID: <CAHiEHe-WJ2p2=fLeHdq+Ga40V-ofpmNkSHCKG5+bvNqMxsnZBQ@mail.gmail.com>
Subject: Please can i have your attention
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:a34 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4988]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [jbi880375[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [subik7633[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [jbi880375[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Dear ,

Please can I have your attention and possibly help me for humanity's
sake please. I am writing this message with a heavy heart filled with
sorrows and sadness.
Please if you can respond, i have an issue that i will be most
grateful if you could help me deal with it please.

Susan
