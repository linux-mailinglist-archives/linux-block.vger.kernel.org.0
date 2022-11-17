Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71AD962E882
	for <lists+linux-block@lfdr.de>; Thu, 17 Nov 2022 23:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbiKQWex (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 17 Nov 2022 17:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbiKQWeW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Nov 2022 17:34:22 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6EE13DFF
        for <linux-block@vger.kernel.org>; Thu, 17 Nov 2022 14:34:21 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id ft34so8646207ejc.12
        for <linux-block@vger.kernel.org>; Thu, 17 Nov 2022 14:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6z/H/hUdzby6qzD77X8A67itjj5DLg7zeEm5yiK8ewk=;
        b=hkPWrM7AH9bIvnAOipNSkx47pq8qD4Zg0axzYp4Xcxjxqsny0tec9R/Pbts+May4ri
         3FLeEYq5s4C9O5n9RvtH7u0kj4ub1Ztkc4saPmeWgNnyglExVA/uSVU0qbZROKmsuPeV
         GAhnRb7F2deCwgadeYOnqP1eOigiOBjKVCaoh4ze44/UvRn7CFF7prm930mIQ4zz8UQG
         n0HMx1CZnVNVW/8aZuq+JVXGU5JNPT0V7JmEfXZXXqcBLBv1y28IfAHOfmN7UEPeVm3q
         k1E/X/+Vf26BCLuV4kqx1BQdcqPBo/XIWFi97Dj4EZ5A5b9O/sEE3CasQS+yHjcUb9YV
         mnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6z/H/hUdzby6qzD77X8A67itjj5DLg7zeEm5yiK8ewk=;
        b=DgB1nyPhaCQMlH3U5wufdWCJgLx9vOA1tXydJtuWbBjz5ZzvJ6B3/yPCU/wflBAGe7
         ozoekyuOiX14HBwDWgt1UAGNUioSTnDhJmnE19LBwh+ISKjKpOhMI56K0oTC4XXGjlUZ
         oZceLdOb96SlJaejZh0Q9VZcRJUtRbXX64fS88CPPpdhSgDc4dGc5LVhtBwSnUm7iKHm
         RaKCFVKEK+swd9HB82DSN20qHjXCVPCJQPkx48g2asOjPFAEJPuBVvOAdzOUqZ/2BOwP
         JxNQn5NFjJvO0cRnnAo86/8kEiwyDJW5yEKeJj5Zag2W08dHshvN2ARKwh9HLjaZmHwA
         xTMg==
X-Gm-Message-State: ANoB5pkO0PyXLv/QLUIWIH0/xJB8HjxL2Q2xhdDEb5YZT1yT6zBE3tYs
        PCnvwbjacwZ/CfVQg/UkJH1ZXHBxfrMaqz0VcWs=
X-Google-Smtp-Source: AA0mqf6xhA9q92P0qAiExaK5i7ePFk9HK6iZ8Gr/oxwHajfndK9Y4yfFY/pHY+S+f7SdFk+IcYqG5li1s8taKYVcUyg=
X-Received: by 2002:a17:907:b60f:b0:787:8884:78df with SMTP id
 vl15-20020a170907b60f00b00787888478dfmr3725691ejc.246.1668724460243; Thu, 17
 Nov 2022 14:34:20 -0800 (PST)
MIME-Version: 1.0
Sender: gnimgimegang@gmail.com
Received: by 2002:a05:7208:5486:b0:5d:220d:12fe with HTTP; Thu, 17 Nov 2022
 14:34:19 -0800 (PST)
From:   =?UTF-8?B?0JvQuNC30LAg0KHQuNC00L7RgNC10L3QutC+?= 
        <a45476301@gmail.com>
Date:   Thu, 17 Nov 2022 22:34:19 +0000
X-Google-Sender-Auth: 23NQNb3aBncW6y3pznL3fUJGvvg
Message-ID: <CALvt0+=bqrrW6G8i_qM7KbS2de-gnFS0upL2M169JdsK3s-Ksw@mail.gmail.com>
Subject: This is very urgent.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Greetings!!
Did you receive my previous email?
Regards,
Yelyzaveta Sydorenko,
