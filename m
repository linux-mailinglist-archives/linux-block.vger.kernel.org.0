Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81BAE407AB3
	for <lists+linux-block@lfdr.de>; Sun, 12 Sep 2021 00:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbhIKWkU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 11 Sep 2021 18:40:20 -0400
Received: from smtprelay05.ispgateway.de ([80.67.18.28]:24691 "EHLO
        smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbhIKWkT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 11 Sep 2021 18:40:19 -0400
Received: from [87.92.210.171] (helo=lumip-notebook.fritz.box)
        by smtprelay05.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <lumip@lumip.de>)
        id 1mP77v-0002eN-O0; Sat, 11 Sep 2021 19:49:19 +0200
From:   Lukas Prediger <lumip@lumip.de>
To:     phil@philpotter.co.uk
Cc:     axboe@kernel.dk, hch@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH v3] drivers/cdrom: improved ioctl for media change detection
Date:   Sat, 11 Sep 2021 20:48:17 +0300
Message-Id: <20210911174816.55538-1-lumip@lumip.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAA=Fs0mEprM0hErRY-kw7bOVqEw3o6X=--OixQ=_fNXdV_-QGQ@mail.gmail.com>
References: <CAA=Fs0mEprM0hErRY-kw7bOVqEw3o6X=--OixQ=_fNXdV_-QGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Df-Sender: bHVrYXMucHJlZGlnZXJAbHVtaXAuZGU=
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Randy, Hi Phil,

>>
>> Hi Lukas,
>>
>> Just a minor nit:
>>
>> On 9/10/21 2:16 PM, Lukas Prediger wrote:
>> > +#define MEDIA_CHANGED_FLAG   0x1     /* Last detected media change was more \
>> > +                                      * recent than last_media_change set by\
>> > +                                      * caller.                             \
>> > +                                      */
>>
>> Drop the "continuation" backslashes.
>> They are not needed.
>>
>> thanks.
>> --
>> ~Randy
>>

Hm, my IDE was complaining about these but I just tested building without and
that worked fine. No idea what that was about then..

>
> Dear Lukas,
>
> Happy to take these out for you and save you resubmitting.
> I'm very happy with patch anyway. Once I hear back from
> you I'll send onto Jens with my approval after one final test :-)
>

That would be very nice of you!

>
> Thanks again for the code.
>

My pleasure, and thanks for the helpful feedback!

>
> Regards,
> Phil

Best regards,
Lukas
