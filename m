Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785FA2333AC
	for <lists+linux-block@lfdr.de>; Thu, 30 Jul 2020 15:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbgG3N6w (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 30 Jul 2020 09:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729389AbgG3N6q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jul 2020 09:58:46 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E69C061574
        for <linux-block@vger.kernel.org>; Thu, 30 Jul 2020 06:58:45 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id j187so25576686qke.11
        for <linux-block@vger.kernel.org>; Thu, 30 Jul 2020 06:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=QcYaplpioI9MLsAnqd4iIIXoRVUu0Gh7RceGnF833lA=;
        b=N4Z4RakBM2wV4gC7nQk0xwWWVeN3klc8op0Mk2CW0asWsybhcYjcqG9tXF5CAp34+C
         /48qr3maDPv/t630d0nk8A9IC9nLLSt3V9v/4EwGV7gmnDsCOjHc4+wE6u+uH7D42skO
         JViIBTEm+Kn39mD4B4EE60RBY8x1IhEU/ALZ4XHQpuLrT58O4vSu9i000u87K9I7xafn
         6Nm7wuoCSz7ugstbB8mXdHoesEC21V5gMIJfqBtpjIQfTucJ8Q0mY+wh8227ElItbQ1+
         UYObLJKFLeQw0iFto8QqK9nwOrdMAPSDoJE7eCmJu0RaBTjqB/0Mvi2KeHL8Cat3pgA/
         Q1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=QcYaplpioI9MLsAnqd4iIIXoRVUu0Gh7RceGnF833lA=;
        b=q7G/c0Hx8+EfPYDnZzZwMznOvN83PIj+t3kDfcq2O2yd1/S2zpPCRmrl/Fu49Q3dMM
         qN0Sc1utVBmsYZmWrG84ZMuizRyUqp2XEVX8B3XPAFKO3OtM6huBWP7INiBgUmIzHgcr
         jRT03BgcKN2m4Y6lP7I0WvrNJkcjgo2nl4cdu24I1EK1JxZ2UPHqi+IE4rlxBd3iKFHD
         Ku1y58ahC9SUDk0YmkLmlfeaOKhTsKayGiAa7jlRPO/9uDkekDNMOEB5cwbgD4ajzfTv
         jqbu9ra9bJjZGy2GPwfR5v0t3oa6TwYDeogE1r7gFElibNk7kydCYK8uvmYC+VrO+rMe
         Klxw==
X-Gm-Message-State: AOAM5339c9cNVuLKg9qVrMG2HrEvsNT8SXKb2A5wc1Qk+JdT9THwQRVN
        Y5D/AB/OmM6d6L7BdbN/BmcdyDvIYxjm69QaVG8=
X-Google-Smtp-Source: ABdhPJxXRtIkxPR5QyGlU6RL+jTImtmyLwSd5A22K8DCRm4H/4H0zglJszZ1qXhvAGqYCVC8G0WMAskSvM4A8JHJWDw=
X-Received: by 2002:a37:e315:: with SMTP id y21mr4173746qki.129.1596117525129;
 Thu, 30 Jul 2020 06:58:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:24ba:0:0:0:0:0 with HTTP; Thu, 30 Jul 2020 06:58:44
 -0700 (PDT)
Reply-To: godardchambers1@yandex.com
From:   "Luis F. Godard" <veronicadeerow@gmail.com>
Date:   Thu, 30 Jul 2020 15:58:44 +0200
Message-ID: <CAOXWAkNbNaLQRf3=+tJ-wVuQxCuLfwS+PkyxihhBK01tbCStbA@mail.gmail.com>
Subject: =?UTF-8?B?SmUgdG8gbmFsw6loYXbDoSB6cHLDoXZhLA==?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

SmUgdG8gbmFsw6loYXbDoSB6cHLDoXZhLA0KDQpKYWsgb2JlY27Emz8gRG91ZsOhbSwgxb5lIHNl
IHRhdG8genByw6F2YSBzIHbDoW1pIGRvYsWZZSBzZXRrw6F2w6EuDQpOZXphcG9tZcWIdGUgcHJv
c8OtbSB0dXRvIHpwcsOhdnUgbmEgcm96ZMOtbCBvZCBkxZnDrXbEm2rFocOtY2gsIHByb3Rvxb5l
IHbDocWhDQpkxJtkaWNrw70gZm9uZCB2ZSB2w73FoWkgOSwyIG1pbGlvbnUgVVNEIG55bsOtIG9k
aGFsdWplIHZhxaFpIG9rYW3Fvml0b3UNCnBveml0aXZuw60gb2Rwb3bEm8SPLiBWeXrDvXbDoW0g
dsOhcyB2xaFhaywgYWJ5c3RlIGxhc2thdsSbIHDFmWVkYWxpIHN2w6kgY2Vsw6kNCmptw6lubzog
WmVtxJs6IEFkcmVzYTogUG92b2zDoW7DrTogUm9kaW5uw70gc3RhdjogUG9obGF2w606IFbEm2s6
IFNvdWtyb23DqQ0KxI3DrXNsbzoga29uZcSNbsSbLCBQbGF0bsOhIGtvcGllIGlkZW50aXR5Og0K
DQpTIMO6Y3RvdSBWw6HFoS4NCkJhcnJpc3RlciBMdWlzIEZlcm7DoW5kZXogR29kYXJkIChFc3Ep
DQo=
