Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1581EFAF8B
	for <lists+linux-block@lfdr.de>; Wed, 13 Nov 2019 12:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfKMLUo (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 13 Nov 2019 06:20:44 -0500
Received: from mail-io1-f51.google.com ([209.85.166.51]:44118 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbfKMLUo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Nov 2019 06:20:44 -0500
Received: by mail-io1-f51.google.com with SMTP id j20so2067697ioo.11;
        Wed, 13 Nov 2019 03:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E4UUTk/t8uEes636KBwiMf4uCLpW7SUwTukCuJGV2gQ=;
        b=NIUP6HJ7cZn6VNtTHqEup48z6htdvYdviXFeI9rrFeZQUOA8atO2mZ87YJBOhpOJ1O
         Lt5nD8Tab2jacC6s/bVARkIzfu8E68Yk0h3H3Hpe7WfLyh0DnSGtGuto11j6TnwPU8/X
         ngLvnF1gbtZ1C1DSFoRcIpSqEEtAgtScXVtB5SSwuHVnRCaOpXMSIjBnRzpGAimp3PqC
         Z3IMCedoAHGVYhBrADI4yqdUPoXGFPV+bTXJAUHpqT29qi7YIxGNxqpwP+vqiNenNzv8
         KgtG/JyDoleXuoGEbg3e5sWF9+PADJm6WrVGZW1nDp5tZG9zL6SZYzHo5JjUX0z2146d
         jtmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E4UUTk/t8uEes636KBwiMf4uCLpW7SUwTukCuJGV2gQ=;
        b=ESiGRWzDhRZYBARpLLB3h9zSc7hvU1EUZN219gWJ7YKjUpjGEWDtjm37/OW4X1i5t5
         JlrzLbPm2djWtmuUoHg8OUbsYAuiFlsmLkHspvuUFHeT213iUhdkZ6yc1xjaPOWWrVG6
         IXxNYdtANEfuDYLxgTz46/nE8gqM7rhOkhWVDj2Zb7NpJ9moYX4iRVCCyGbsIQfpX1+s
         BplmjWiLLwilmcs0TBOhF2XfORTrwk3YAyE3h2GiiYPwIg3yaUcADob03t+Il/QomE8S
         CHfXQ8s23t6X5q/GsbAast2DxM09hRX1TYI3YqysvzdsRO8+EL383z/Yji24Ua1LSOGp
         KsxQ==
X-Gm-Message-State: APjAAAV25/7mO/+HBX8Ta8lHAIcnRD82qzVjqcxpzJcV3TuRv1/NCPqy
        auUQeaOwarhuyeT7HAjZY68zcKW5pqyq2XYvPWd72X+u
X-Google-Smtp-Source: APXvYqyzAwG7kNXP0VtaM+bOtHh6R0X5bYvj2ZKk/LsHWL2cUgxqWt5N8Raq/rtmN9BzipVCDmD8oCvvzpW5z4O6g4c=
X-Received: by 2002:a02:9f95:: with SMTP id a21mr2464235jam.16.1573644043378;
 Wed, 13 Nov 2019 03:20:43 -0800 (PST)
MIME-Version: 1.0
References: <20191113013529.GA64000@TonyMac-Alibaba>
In-Reply-To: <20191113013529.GA64000@TonyMac-Alibaba>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Wed, 13 Nov 2019 12:21:10 +0100
Message-ID: <CAOi1vP98n4coOhc79Q+t63sCGvLmpXCwEYf8yuME+ST2K1HDsw@mail.gmail.com>
Subject: Re: 'current_state' is uninitialized in rbd_object_map_update_finish()
To:     Tony Lu <tonylu@linux.alibaba.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 13, 2019 at 2:35 AM Tony Lu <tonylu@linux.alibaba.com> wrote:
>
> Hello,
>
> There is a warning during compiling driver rbd for uninitialized
> 'current state' in rbd_object_map_update_finish():
>
> drivers/block/rbd.c: In function 'rbd_object_map_callback':
> drivers/block/rbd.c:2122:21: warning: =E2=80=98current_state=E2=80=99 may=
 be used uninitialized in this function [-Wmaybe-uninitialized]
>       (current_state =3D=3D OBJECT_EXISTS && state =3D=3D OBJECT_EXISTS_C=
LEAN))
>
> drivers/block/rbd.c:2090:23: note: =E2=80=98current_state=E2=80=99 was de=
clared here
>   u8 state, new_state, current_state;
>                        ^~~~~~~~~~~~~

Hi Tony,

It looks like this warning was also reported by kbuild, on gcc 6.3 and
7.4.  It's bogus, I'll send a patch to silence it.

Thanks,

                Ilya
