Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DC2743FE1
	for <lists+linux-block@lfdr.de>; Fri, 30 Jun 2023 18:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbjF3Qd0 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 30 Jun 2023 12:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbjF3Qcy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Jun 2023 12:32:54 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE11249DA
        for <linux-block@vger.kernel.org>; Fri, 30 Jun 2023 09:32:30 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-991f956fb5aso229433766b.0
        for <linux-block@vger.kernel.org>; Fri, 30 Jun 2023 09:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1688142749; x=1690734749;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AxbaCNoE+JV34sGUBx+kirR+Dv98omM+zfGYwzJCg60=;
        b=p2dYEggTz0ByfbzWwhxKhrpbz5n2bdQV4HbK56+QsfvMLJwfV9xXG7t6iJHIZe3ReX
         vnWrIKjM8uBHVhCYs6f4cKkNj/44tm3jZC/YmJBDkqLpPZwLwHVlC6WwO6jehgw3BCZc
         VvD5R6Nth64zkqCRzKfd5vyyhvd6RvuuVkFER4c6RiD0BRJwumYicJJK2ZSJKrn6WX7L
         k6Jku56ECD0wFtphsp5XmeLaUEt31/UXpJ76uAhPytmt+8TbLK1ofB4HsQOIbIZMax8F
         TdH3F2EbxHzpOr7+Eav5Xx/Jas/RFiQcPS6E0migwmfb2L1omkFDsk79c0h1lyHOUvSo
         jDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688142749; x=1690734749;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AxbaCNoE+JV34sGUBx+kirR+Dv98omM+zfGYwzJCg60=;
        b=MyJrY6atorgL8fitIBoTsTX7uM++5PfLgzT/Dp9LlkRI/ILTrg9WjQf5V4ZSkvVVmH
         VWQlJTQulMKanMC0hugdq8UWw9eJAQbbwBnhhTSTWY5Ggmd9DYSleLPSXjwygVVlcODV
         MGPdT/zB3OyFk8j75xPrgYCgpqmsw6x05n2zf9UsIW7QjvP5inpoQ9RVwD/4u4XlDbw5
         HsAW/LKGkE+w3Q5iLrlCFOUURqBQHVBL2UnOU351GG6baGXW6nLrLhLD53vY32Kdv3Hf
         DOkqJkVJuY9pwhsEDEvsfhGHv+MR44IBtxwbz1hVJRtKyA5zN2F/mbTl1aRHshgOmd7F
         O5xg==
X-Gm-Message-State: ABy/qLZms8pGFZt9C7eAOK6z0Lw14qTJbdijBkQ9WVKPf9sqGuAE3IJU
        LSNjv/Kdp0683VH3XYiSnTtx7Q==
X-Google-Smtp-Source: APBJJlHF99ajTBMDRGkPN06+FiVZrojvPesmLm9zw9EAjqUpMYdKKSIswDE4ORlz1FzAsT4zWZkLAA==
X-Received: by 2002:a17:906:4b49:b0:992:44ae:45dc with SMTP id j9-20020a1709064b4900b0099244ae45dcmr2078496ejv.44.1688142749344;
        Fri, 30 Jun 2023 09:32:29 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id k25-20020a17090666d900b009821ce1ea33sm8238095ejp.7.2023.06.30.09.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 09:32:28 -0700 (PDT)
References: <20230628190649.11233-1-nmi@metaspace.dk>
 <20230628190649.11233-2-nmi@metaspace.dk>
 <83E5C27A-9AEF-4900-9652-78ACFF47E6B0@wdc.com>
 <a7bb663d522cde468b868e8e77110217@opensource.wdc.com>
User-agent: mu4e 1.10.4; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     aravind.ramesh@opensource.wdc.com
Cc:     Hans Holmberg <Hans.Holmberg@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        hch@infradead.org,
        Matias =?utf-8?Q?Bj=C3=B8rling?= <Matias.Bjorling@wdc.com>,
        open list <linux-kernel@vger.kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>, gost.dev@samsung.com,
        Minwoo Im <minwoo.im.dev@gmail.com>, ming.lei@redhat.com
Subject: Re: [PATCH v4 1/4] ublk: change ublk IO command defines to enum
Date:   Fri, 30 Jun 2023 18:30:52 +0200
In-reply-to: <a7bb663d522cde468b868e8e77110217@opensource.wdc.com>
Message-ID: <877crkewro.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


aravind.ramesh@opensource.wdc.com writes:

>> From: Andreas Hindborg <a.hindborg@samsung.com
>> <mailto:a.hindborg@samsung.com>>
>> This change is in preparation for zoned storage support.
>> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com
>> <mailto:a.hindborg@samsung.com>>
>> ---
>> include/uapi/linux/ublk_cmd.h | 23 +++++++++++++++++------
>> 1 file changed, 17 insertions(+), 6 deletions(-)
>> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd=
.h
>> index 4b8558db90e1..471b3b983045 100644
>> --- a/include/uapi/linux/ublk_cmd.h
>> +++ b/include/uapi/linux/ublk_cmd.h
>> @@ -229,12 +229,23 @@ struct ublksrv_ctrl_dev_info {
>> __u64 reserved2;
>> };
>> -#define UBLK_IO_OP_READ 0
>> -#define UBLK_IO_OP_WRITE 1
>> -#define UBLK_IO_OP_FLUSH 2
>> -#define UBLK_IO_OP_DISCARD 3
>> -#define UBLK_IO_OP_WRITE_SAME 4
>> -#define UBLK_IO_OP_WRITE_ZEROES 5
>> +enum ublk_op {
>> + UBLK_IO_OP_READ =3D 0,
>> + UBLK_IO_OP_WRITE =3D 1,
>> + UBLK_IO_OP_FLUSH =3D 2,
>> + UBLK_IO_OP_DISCARD =3D 3,
>> + UBLK_IO_OP_WRITE_SAME =3D 4,
>> + UBLK_IO_OP_WRITE_ZEROES =3D 5,
>> + UBLK_IO_OP_ZONE_OPEN =3D 10,
>> + UBLK_IO_OP_ZONE_CLOSE =3D 11,
>> + UBLK_IO_OP_ZONE_FINISH =3D 12,
>> + UBLK_IO_OP_ZONE_APPEND =3D 13,
>
> Curious to know if there is a reason to miss enum 14 here ?
> And if UBLK_IO_OP_ZONE_APPEND is defined along with other operations
> better to define that in patch 3 itself.

They are defined after REQ_OP_ZONE_*, and they have a hole at 14 =F0=9F=A4=
=B7

BR Andreas

>
>> + UBLK_IO_OP_ZONE_RESET =3D 15,
>> + __UBLK_IO_OP_DRV_IN_START =3D 32,
>> + __UBLK_IO_OP_DRV_IN_END =3D 96,
>> + __UBLK_IO_OP_DRV_OUT_START =3D __UBLK_IO_OP_DRV_IN_END,
>> + __UBLK_IO_OP_DRV_OUT_END =3D 160,
>> +};
>> #define UBLK_IO_F_FAILFAST_DEV (1U << 8)
>> #define UBLK_IO_F_FAILFAST_TRANSPORT (1U << 9)
>
> Regards,
> Aravind

