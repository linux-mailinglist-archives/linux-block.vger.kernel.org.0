Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7D04D02D9
	for <lists+linux-block@lfdr.de>; Mon,  7 Mar 2022 16:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242447AbiCGP3H (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 7 Mar 2022 10:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241186AbiCGP3H (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Mar 2022 10:29:07 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BF954683
        for <linux-block@vger.kernel.org>; Mon,  7 Mar 2022 07:28:12 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id bi12so19644082ejb.3
        for <linux-block@vger.kernel.org>; Mon, 07 Mar 2022 07:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=Dsmq+MlGTQlhsi0/PSWxzY5GTv7L97fyNDmqPka/irU=;
        b=VQu74XQEaRldE3nhHcGIDsAM9SidUnV6SiqWTJKIjkCHeg0y20QBlT3gshzR5/sm2t
         xKOzqTP38MphQlkvwOF1iimZFB+IBYn9KOtxS3ADkOTyAHtcqEgHmgkvzfFYzxKRCMH4
         4bVWeHHfCdYaOSNVLlwhDtFqjelOy4dXWrsWX1iAXFfx5ARPZJv3R2Jpi38xUgKaT/my
         2CNydUHgyZfAIx7bjKiaJN+W3YpHyOzelri54qbm2x51zOIwzYBGKxLoIS1VNRfAB1Wj
         Czjz0EUo7XnwcicB6dXEy2yBuuSTOefHsEZD1LehQjkPA6wdsHiHpzOSq1pmLG0v+StN
         cslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=Dsmq+MlGTQlhsi0/PSWxzY5GTv7L97fyNDmqPka/irU=;
        b=5y3ffZ3FzqrdoP1Ub6Owi3ZE+wttwE/JvbXZRwHzrWoG3iQEdO57GGFcyjcL3n7+15
         UXNmyYsnLrjupW24V1iPM5MIaGa9T+v+SO4iYE7FLy9GZP4HNWPeqyGxMTZvUiToM/F/
         Ufll0BtnZyeGrhDSVHBDa2yBirJzYG1KiI5Dc8qE8eWOCgT9WBw9bP0r4miKGgh5W/H2
         w4319I4awV0OkfrkGkGE9A+quBSyyumbfINr6bluadIVh6ORRR3eE4Nn6NPsm4qdAd2C
         nXVJYPrpwSSnUAauwwTfv9WijsRFHo7RIaTqQKsNvAzCdHWALF3bjqLb+0D6rbQR4F8q
         gmPA==
X-Gm-Message-State: AOAM533SLSnsuxQRlxgwFGE7feGTDAjH/IH5Ye+n18m5wktgFWvWmWwO
        k+oBBmQBpycbWqgnGivP+sEypQ==
X-Google-Smtp-Source: ABdhPJwDUxFUbYYUgG91jFyky1Y4AWrV08+Usjavmt4n0oxvdvEds/LA4HECR4MHtZVV/zdkG5Q1ig==
X-Received: by 2002:a17:907:9495:b0:6da:9602:3ec6 with SMTP id dm21-20020a170907949500b006da96023ec6mr9580400ejc.589.1646666891149;
        Mon, 07 Mar 2022 07:28:11 -0800 (PST)
Received: from smtpclient.apple (5.186.121.195.cgn.fibianet.dk. [5.186.121.195])
        by smtp.gmail.com with ESMTPSA id e22-20020a170906505600b006da7d71f25csm4865412ejk.41.2022.03.07.07.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 07:28:10 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [LSF/MM/BPF BoF] BoF for Zoned Storage
Date:   Mon, 7 Mar 2022 16:28:09 +0100
Message-Id: <28809696-54D0-474E-9243-7FE27DDB732B@javigon.com>
References: <20220307151556.GB3260574@dhcp-10-100-145-180.wdc.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        lsf-pc@lists.linux-foundation.org,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <matias.bjorling@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Keith Busch <keith.busch@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
In-Reply-To: <20220307151556.GB3260574@dhcp-10-100-145-180.wdc.com>
To:     Keith Busch <kbusch@kernel.org>
X-Mailer: iPhone Mail (19D52)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> On 7 Mar 2022, at 16.16, Keith Busch <kbusch@kernel.org> wrote:
>=20
> =EF=BB=BFOn Mon, Mar 07, 2022 at 03:35:12PM +0100, Javier Gonz=C3=A1lez wr=
ote:
>> As I mentioned in the last reply to to Dave, the main concern for me
>> at the moment is supporting arbitrary zone sizes in the kernel. If we
>> can agree on a path towards that, we can definitely commit to focus on
>> ZoneFS and implement support for it on the different places we
>> maintain in user-space.=20
>=20
> FWIW, the block layer doesn't require pow2 chunk_sectors anymore, so it
> looks like that requirement for zone sizes can be relaxed, too.

Exactly. This is the core of the proposal.=20

