Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A7078586C
	for <lists+linux-block@lfdr.de>; Wed, 23 Aug 2023 14:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbjHWM7I (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 23 Aug 2023 08:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbjHWM7H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Aug 2023 08:59:07 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88349170C
        for <linux-block@vger.kernel.org>; Wed, 23 Aug 2023 05:58:20 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-64ad88fb05fso11898396d6.1
        for <linux-block@vger.kernel.org>; Wed, 23 Aug 2023 05:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692795499; x=1693400299;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9bFaxFdv8YWeiOQM2v7zrzz9w73rvxJbfGPhZgqjlBU=;
        b=fUEYZNq6lA9TuOwujL8kTdBfkKj6I1qff206rbzjLTMpOrWkwiNs61zFZUsCt0WFla
         RuNovGQqTvYJq3mV7efmtcCZaLa2vr9BzrTfjbA9s07r2f/0ALnhmFLOX/3Jt7a9Bm88
         +CLkImzro6uN7/xUFeIDpsSoPmBnfA69FRRdSFvy3G/WG3tkdbaPnhNWOxG+TKe6xzOP
         sA2zrhwY0IUoMcaXEB9JKRilf4/ORtgVwY6T04MPC55gxSEsOi/OBdz2ZxMW5zZhQSJA
         UF9B3SOo5w8RnMiUWoYJymPISHX7zT0zkIQVeSDTe+xmmHDae3crVIL6cvraaO78AQUR
         eGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692795499; x=1693400299;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9bFaxFdv8YWeiOQM2v7zrzz9w73rvxJbfGPhZgqjlBU=;
        b=FDEP7yDlzZyP849gDNdaQRX4a0Fj7VO/Vw1lH7YAkyJViQqo37VJ3Y306HdWed+PyD
         Oq7tSflEuGFdZzLElCyS39scRH6L3gSu1Yl0MpDABFzrmPpbp5L0m0/v623qWzXk1p0t
         Gf5X5dzl9Bj1cDtCyI28K22ChNYXEY7wHD7ZaBLchawtNsOFyHeMoA+FgFxBDsF7QiCN
         /f0qEwGB+MwofDDf3+lb/gs+FKR8pgK4Kof1866G5h5wRIHMx4BJLmdu5vQWTsrp72ac
         W0RulTofcGMgy06SvGahkAEO7BjJFfu9FXr/Ys4pIETcjNFmHRrjaT9J8eWAlOsWUXBT
         B28g==
X-Gm-Message-State: AOJu0YzKAjx27RdcIYpBWi7CytN33iTCVsX9hTainofqXtYUUPQnI+++
        DxC+jteXCXfh6uoBr8Hg30oxkgvPJBgHrKtA8/E=
X-Google-Smtp-Source: AGHT+IHTScIjXem1wGOEiqJw6lqWuyphTQedxMfvGM+lBR5yUv2ZqzQfpRRu0oP8OAQk7pzSwTv2w6aV5RQNWL4MPBs=
X-Received: by 2002:a05:6214:2466:b0:63f:7d29:1697 with SMTP id
 im6-20020a056214246600b0063f7d291697mr14766634qvb.2.1692795499152; Wed, 23
 Aug 2023 05:58:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:aa9c:0:b0:647:290f:b96 with HTTP; Wed, 23 Aug 2023
 05:58:18 -0700 (PDT)
Reply-To: cristiinacampbell@hotmail.com
From:   Diageo Company London <jw2433630@gmail.com>
Date:   Wed, 23 Aug 2023 13:58:18 +0100
Message-ID: <CANdTewEekMVk9PPQ23j4eL=FPCe549G1WMJoBJrGdbrKvf4K1g@mail.gmail.com>
Subject: Necesitamos un distribuidor de ventas.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

23/08/2023

Dr. John Smith
16 Gran Marlborough St,
Londres W1F 7HS, Reino Unido.
Compa=C3=B1=C3=ADa Diageo Londres
johnoffic@hotmail.com


Estimado amigo,

Mi nombre es Dr. John Smith; Gerente de Ventas Internacionales en
Diageo Company Londres, Reino Unido, Diageo Company est=C3=A1 buscando una
persona confiable en su pa=C3=ADs para ser su representante como
distribuidor de sus productos y marcas.

La Compa=C3=B1=C3=ADa le proporcionar=C3=A1 un 50% de anticipo del producto=
, si est=C3=A1n
convencidos de que usted es confiable y tiene la capacidad de
representar los intereses de la Compa=C3=B1=C3=ADa y distribuir los product=
os de
la marca de manera efectiva en su pa=C3=ADs y sus alrededores para obtener
ganancias.

Le dar=C3=A9 m=C3=A1s detalles despu=C3=A9s de escuchar su declaraci=C3=B3n=
 de inter=C3=A9s en
trabajar con nosotros y si est=C3=A1 interesado en ser distribuidor y
representante de Diageo Company en su pa=C3=ADs/regi=C3=B3n, por favor resp=
onda
a este correo electr=C3=B3nico indicado aqu=C3=AD [johnoffic@hotmail.com ]

Atentamente,
Dr. John Smith
