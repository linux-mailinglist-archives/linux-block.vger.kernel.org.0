Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F60664FC17
	for <lists+linux-block@lfdr.de>; Sat, 17 Dec 2022 20:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiLQTTr (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 17 Dec 2022 14:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiLQTTh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 17 Dec 2022 14:19:37 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD1811453
        for <linux-block@vger.kernel.org>; Sat, 17 Dec 2022 11:19:20 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id f16so5371624ljc.8
        for <linux-block@vger.kernel.org>; Sat, 17 Dec 2022 11:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UleXfybfkB/Pp7XCNYIxvDWfUpO/oLpvjkUbrsMk7bk=;
        b=co845zATjNde3H5Vab75OHgk3idEhiLG/pEEUCj10gcAoDAyvmeJAIeMxCfnQGfMIj
         Rk1UG8EI2HIZdCTH+rCQOQzKujnOf5QJIXBhYHkxNHlJG9CcNjN7WQ4xlB1kNwhkN8ot
         bySEJQY71GV9PRSPnGXr4TULJLKUoGrW2CK+pJVL2WATO4mZvX894mFw9qL8QQD0X6ro
         Fqjbs/TnCSBvt4U1yQCDzAQGECliLgB7E2uqWVMBuiCYj3tftR2qqqE9vh1EcHoSKkxX
         d4OekhX5/HkfsxiZ2AetCzlgHp4iJisyy4ShWo/miO0A0HB4Dp47RMog44iDMpmvdM9M
         48zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UleXfybfkB/Pp7XCNYIxvDWfUpO/oLpvjkUbrsMk7bk=;
        b=68XiDlAW6CAyoRRPuCaQRnOu1NkqTAjpcUSR416pSODRYAVagmFYS3NagXrp2lHywr
         YcPuvmajjduqDVFKEPJ0DJveTM3QdbMfrsg32yrmhcobuNrUng42h/1N3zSInwP7AVms
         /+DAcFKA5sNtf1wyiN0SK9lRAJHH8pA4XHkzgJToSJ1DXE33gTpe3oANVQmTUMJJuNmt
         yJ4U7R8oRUf/mNEYTzzrjtFEYD1/9L8bC5hwfz0ruXeUC/ukedccMC8FWAx4c9NW7IME
         dLrNFI0Phr7J6wLMmoXh3m3iE0R7OzKR86EBkLYfnhzSZLu62FGKnRFEp0aPUwotuFjP
         htag==
X-Gm-Message-State: ANoB5pmQnedcwfeegONEkps5htucvt/l7aosqQmS0lkZLHzlsGmzxQKL
        q5fQF9l1tSyPGUHFGkjTYN9d6cqNUDvECAKhDzo=
X-Google-Smtp-Source: AA0mqf6xSItA2XQtcM7sDNE5bL4/miBLIHwhO/163TuimuwMTWTOthVLV4AHM/dzhjpR8p76ANGRnqUhBonlbOpvWGs=
X-Received: by 2002:a05:651c:221e:b0:277:6231:5a7 with SMTP id
 y30-20020a05651c221e00b00277623105a7mr23904920ljq.300.1671304758949; Sat, 17
 Dec 2022 11:19:18 -0800 (PST)
MIME-Version: 1.0
Sender: ourosafiyan@gmail.com
Received: by 2002:a9a:5dcd:0:b0:231:8098:e780 with HTTP; Sat, 17 Dec 2022
 11:19:18 -0800 (PST)
From:   John Kumor <jer.91244914@gmail.com>
Date:   Sat, 17 Dec 2022 19:19:18 +0000
X-Google-Sender-Auth: _WrBjDnmT_vROY9jxuAUQdm1_qI
Message-ID: <CAMh9-WMydoRBszphiW2RoYnkAc5+MuD0HGzHW=V2nY6555dN3Q@mail.gmail.com>
Subject: It's very urgent.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Greetings!!
Did you receive my previous email?
Regards,
John Kumor,
