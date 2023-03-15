Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0F66BAD99
	for <lists+linux-block@lfdr.de>; Wed, 15 Mar 2023 11:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjCOKZG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 15 Mar 2023 06:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbjCOKYt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Mar 2023 06:24:49 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E01125281
        for <linux-block@vger.kernel.org>; Wed, 15 Mar 2023 03:24:48 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r18so16820887wrx.1
        for <linux-block@vger.kernel.org>; Wed, 15 Mar 2023 03:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678875886;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3tQa/xAjjFjMbYTIPvabJVdNLC/DkLFMMTZCH3qWNU=;
        b=azB3VsTaBYLJT09bbUg1qIllWAyEL9UjuSqh8RVtU4yVkMpcB6lrqRoVPHu+/vtKFl
         iCm5nohZiRdZi5niRSb4moixJNqITNDS96uAO2MwWj04ajTpeZv2c6f8+0aLD/W9hNbT
         +OqZnfDh9DmAX7JBwLkLaboP+5hA3WFRMvpSQPT7sWm0/KmSORzoIUjDVdtb1XtusLlM
         PTB6zjXmvRpmgk9/8t4/be/vm2ZYHZRYHh0mIJxEK50rwNBEHauYlPn4cAULo9WGfefk
         xS+ytoTNJu5gULuwflsWoFStUlQLyB/0qeCneB83t1J12GvisctYvGa70OQ3yIl2ilQo
         nJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678875886;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N3tQa/xAjjFjMbYTIPvabJVdNLC/DkLFMMTZCH3qWNU=;
        b=OuFyUkBiqVRAHeUqOlwjHOCVvIVRosmh+SipSKDONaiy4t7DUq6sYFsGr7L4ZP73to
         WivHvJSF3spqvyDj/tgsT4447OtWiijfKhYz69GutA+gOJrz2RROs7ycIKSLyg19psMa
         RG43RmXH+1nC70ZyEdPheMeVLLEcER7hW2eRsUekryLdXSDzLe+lO+piClCNa3S8/R0y
         uct9fxcH0o5wtpmucG3U+oAoPXVQuDzAq/rpaxn2BiepvGjfC2L4rzP6qBwp5ZCyOnoq
         HRMTWHzgYgnKSWBUfLuyCM5ck3vZZ0yKflvHwxnK1gs4UwrmZYBNytRRAEJNIQHKK5LN
         +ffw==
X-Gm-Message-State: AO0yUKXX1Kugp4GqrWMk7r88QWg4mDqqLdxQtORvxjae5MN3XYtbyEDW
        JFB9rZkZ0ZZ5/vhFV7jrgpT2uzuREghiMpBE+Uc=
X-Google-Smtp-Source: AK7set9LuN4XHzi8zfdgCTA6QywkI0RqJBKZNAUHhxXmeIAXlOW8RT2Iz3IIvAssjXaeGMisy8T0M8taimWjTl4WhmI=
X-Received: by 2002:a05:6000:1081:b0:2c7:17b8:5759 with SMTP id
 y1-20020a056000108100b002c717b85759mr360004wrw.3.1678875886431; Wed, 15 Mar
 2023 03:24:46 -0700 (PDT)
MIME-Version: 1.0
Sender: suleesther97@gmail.com
Received: by 2002:a05:6020:b827:b0:25d:f373:2044 with HTTP; Wed, 15 Mar 2023
 03:24:45 -0700 (PDT)
From:   Elena Tudorie <elenatudorie987@gmail.com>
Date:   Wed, 15 Mar 2023 15:54:45 +0530
X-Google-Sender-Auth: y58BbmkAX6T92gVmzwSGpeLU9vc
Message-ID: <CAL53L2e37HNY4ZEbvZ3sc1VF5VPPbQEN-xdk-0jpsA3zAdHDfg@mail.gmail.com>
Subject: Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I am Ms Elena Tudorie, I have a important  business  to discuss with you,
Thanks for your time and  Attention.
Regards.
Mrs.Elena Tudorie
