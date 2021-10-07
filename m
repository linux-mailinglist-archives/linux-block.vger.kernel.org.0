Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3F04253FF
	for <lists+linux-block@lfdr.de>; Thu,  7 Oct 2021 15:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241388AbhJGN1j (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 7 Oct 2021 09:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241323AbhJGN1j (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Oct 2021 09:27:39 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885B7C061746
        for <linux-block@vger.kernel.org>; Thu,  7 Oct 2021 06:25:45 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id j2so6389250ilo.10
        for <linux-block@vger.kernel.org>; Thu, 07 Oct 2021 06:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=e8iggSHPchh2/syKEAwU5dTtVJBXfGJ7qwPY92Ln6nY=;
        b=KSzaZHhfVJT+I/SyNiV2YhOMBC9O7C4QuqLHxsm8j+or/ha26PjQxI83X9JjMxhSuP
         St9S20WU/VOoRkvrzMlRdOvHMrJLixEfbNUo92/cpW/1yy9Th/AJSPUnQPHdoZM9+saj
         NuUiNuzfbxlWzP81F05SLxu3+uPWmD8EwUtBhNmZ9TihV1ggPWK+CpLWnOTekzWeL4tY
         Ua20VoRvkIHwkTs59v7ua9fvTbRDI79mCyNHfUDm6Ml5g99n0LiuBuwlICluMZigxVlH
         EKxpZtb9ObCsufDzBOqZ97IThmg0rD+rIgmsh6OZpFU1IuAqNl2M3xLVHeOlKPqbmhAq
         C48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=e8iggSHPchh2/syKEAwU5dTtVJBXfGJ7qwPY92Ln6nY=;
        b=vWymJHnfky5jTJUswPZlbjBz7OM2ibrElOQKlmWxT1TukLA8an4Rt4KRHiz2v5JBl2
         URTzi3OPrhKtQ8p+mhXyFucbfWAzqbpKDqOQJAcDTXoh+/8FDcGPTzKV2Vn1FliO2hJi
         kDv+OWJirG/aR3I+EObDOgeKZZU9JhUWmt3jGDuusUZ6xOZDLBA6Y+q/XmzoLLilM8Uw
         05aWrTnsphzzkt+CRMRZpEJt7TuPOgqwBOm32aQSXCfsIsEaYAdwLkj7hO9U9eyYiT08
         JdksuTBGQakOKPk0MqZPsjIPoeCgOwqaHxHB1cBh9N5ubpPR8QpUwzIRMChdOWfyJf+V
         kaLg==
X-Gm-Message-State: AOAM531OkTLjAA9+K+47+OXdVSDGlyDbuzj3DkU3QK798VUmRIjllBz4
        O4ZBh7Lx6D6XSxJKasZtLJ0wxIcmvZCG9ZpcnqM=
X-Google-Smtp-Source: ABdhPJx0CrVIuPJFQGbfZDNR0hSnT6IpUKcpxaMdSlRzbg1aej3clMfbvsgp4b8iFmVdZccWfGVVxqx/r/EvCSQFfyY=
X-Received: by 2002:a05:6e02:1baa:: with SMTP id n10mr3004341ili.215.1633613144845;
 Thu, 07 Oct 2021 06:25:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:b399:0:0:0:0:0 with HTTP; Thu, 7 Oct 2021 06:25:44 -0700 (PDT)
Reply-To: attsona389@gmail.com
From:   sona attah <tomas46john@gmail.com>
Date:   Thu, 7 Oct 2021 14:25:44 +0100
Message-ID: <CABa4VuBaDLxxjCxSGmzZ=oUfJnv9v-MppkmTJuEhNaEGnCTWQA@mail.gmail.com>
Subject: hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

0JTQvtGA0L7Qs9C+0Lkg0LTRgNGD0LMsDQoNCtCc0LXQvdGPINC30L7QstGD0YIg0LHQsNGA0YDQ
uNGB0YLQtdGAINCh0L7QvdCwINCQ0YLRgtCwLCDQu9C40YfQvdGL0Lkg0L/QvtCy0LXRgNC10L3Q
vdGL0Lkg0LzQvtC10LPQviDQv9C+0LrQvtC50L3QvtCz0L4NCtC60LvQuNC10L3RgtCwLCDRg9C8
0LXRgNGI0LXQs9C+INC+0YIg0YHQtdGA0LTQtdGH0L3QvtCz0L4g0L/RgNC40YHRgtGD0L/QsCDQ
siAyMDA5INCz0L7QtNGDLiDQntC9INC/0L7Qu9C+0LbQuNC7INC30LTQtdGB0YwNCjE1IDUwMCAw
MDAg0LTQvtC70LvQsNGA0L7QsiDQsiDQsdCw0L3Qui4NCtCe0L0g0YPQvNC10YAsINC90LUg0LjQ
vNC10Y8g0LfQsNGA0LXQs9C40YHRgtGA0LjRgNC+0LLQsNC90L3Ri9GFINCx0LvQuNC20LDQudGI
0LjRhSDRgNC+0LTRgdGC0LLQtdC90L3QuNC60L7Qsiwg0YLQsNC6INC60LDQug0K0LHRi9C7INC0
0LDQstC90L4g0LIg0YDQsNC30LLQvtC00LUg0Lgg0L3QtSDQuNC80LXQuyDQtNC10YLQtdC5Lg0K
0JHQsNC90Log0YHQstGP0LfQsNC70YHRjyDRgdC+INC80L3QvtC5INC4INGB0LrQsNC30LDQuywg
0YfRgtC+INC+0L3QuCDQutC+0L3RhNC40YHQutGD0Y7RgiDQtdCz0L4g0YHRh9C10YIg0Lgg0LTQ
tdC90YzQs9C4LA0K0LXRgdC70Lgg0Y8g0L3QtSDQv9GA0LXQtNGB0YLQsNCy0LvRjiDQutC+0LPQ
vi3Qu9C40LHQviDQuNC3INC10LPQviDRgNC+0LTRgdGC0LLQtdC90L3QuNC60L7Qsi4g0K8g0YHQ
stGP0LfQsNC70YHRjyDRgQ0K0LLQsNC80LgsINC/0L7RgtC+0LzRgyDRh9GC0L4g0LLRiyDQvtGC
0LvQuNGH0L3QviDRgdC/0YDQsNCy0LvRj9C10YLQtdGB0Ywg0YEg0Y3RgtC+0Lkg0YLRgNCw0L3Q
t9Cw0LrRhtC40LXQuSDQuA0K0L/QvtC00YXQvtC00LjRgtC1INC60LDQuiDQtdCz0L4g0LHQu9C4
0LbQsNC50YjQuNC1INGA0L7QtNGB0YLQstC10L3QvdC40LrQuCwg0LzRiyDQvNC+0LbQtdC8INGA
0LDQsdC+0YLQsNGC0Ywg0LLQvNC10YHRgtC1LA0K0YfRgtC+0LHRiyDQv9C+0LvRg9GH0LjRgtGM
INGN0YLQuCDQtNC10L3RjNCz0Lgg0Lgg0YDQsNC30LTQtdC70LjRgtGMINC40YUgNTAvNTAuINCf
0L7QttCw0LvRg9C50YHRgtCwLCDQstC10YDQvdC40YLQtdGB0YwNCtC60L4g0LzQvdC1INC4INGB
0L7QvtCx0YnQuNGC0LUg0YHQstC+0Y4g0LjQvdGE0L7RgNC80LDRhtC40Y4sINC60LDQuiDRg9C6
0LDQt9Cw0L3QviDQvdC40LbQtSwg0LTQu9GPINC/0L7Qu9GD0YfQtdC90LjRjw0K0LHQvtC70LXQ
tSDQv9C+0LTRgNC+0LHQvdC+0Lkg0LjQvdGE0L7RgNC80LDRhtC40LguDQoNCtCf0L7Qu9C90L7Q
tSDQuNC80Y86DQrQmtC+0L3RgtCw0LrRgtC90YvQuSDQsNC00YDQtdGBOg0K0J3QvtC80LXRgCDQ
vNC+0LHQuNC70YzQvdC+0LPQviDRgtC10LvQtdGE0L7QvdCwOg0KDQrQn9C+0LbQsNC70YPQudGB
0YLQsCwg0L7RgtCy0LXRgtGM0YLQtSDQvNC90LUg0L3QsCDRjdGC0L7RgiDQsNC00YDQtdGBINGN
0LvQtdC60YLRgNC+0L3QvdC+0Lkg0L/QvtGH0YLRiyDQtNC70Y8g0L/QvtC70YPRh9C10L3QuNGP
DQrQsdC+0LvQtdC1INC/0L7QtNGA0L7QsdC90L7QuSDQuNC90YTQvtGA0LzQsNGG0LjQuC4NCmF0
dHNvbmEzODlAZ21haWwuY29tDQoNCtCY0YHQutGA0LXQvdC90LUg0JLQsNGILA0K0JHQsNGA0YDQ
uNGB0YLQtdGAINCh0L7QvdCwINCQ0YLRgtCwDQo=
