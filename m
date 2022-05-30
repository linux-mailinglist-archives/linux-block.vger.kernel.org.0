Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CA95385A8
	for <lists+linux-block@lfdr.de>; Mon, 30 May 2022 17:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240612AbiE3P6w (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 30 May 2022 11:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240904AbiE3P6k (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 May 2022 11:58:40 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E269EAE
        for <linux-block@vger.kernel.org>; Mon, 30 May 2022 08:50:09 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id t25so17405411lfg.7
        for <linux-block@vger.kernel.org>; Mon, 30 May 2022 08:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=m/H8RjStCv6hVv65KzAZgkQzcHdDtuUqNpn5uu8u3WA=;
        b=m5RSpmpJBah+4lRzVn/fbIaVs0XcWhic1GjZ7CDpnw2aCAN1qiGOKCTJRPIZIu4lSv
         hIBKmlQYpOR1pmXj1aR6D2/vS1xqAj8RSiQp75KwfMhwcN8/A3bZzBbAfhi1FQYbEDGa
         oLjInceL22Kh3gZb6P1OJXLau2Ain5wvWwWPiLpEh/dAfeoIEREeXn37qqXb2ccdjV6j
         dFeVJhZ29ZR0w33y+4bN6MOAywwOWqWE7KiXIY2/n1ySWL0LXoYd0I44PwYQubFrEou3
         BHJyIemx7HIAN61XAB+z/MavDbomQxGdPtOQzQgDgGh6bIk4zkdTAKSEI2HjAjULa1QZ
         gVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=m/H8RjStCv6hVv65KzAZgkQzcHdDtuUqNpn5uu8u3WA=;
        b=Exk0RRVC+1NgUGHbwUscVZH8M0y6/a8+r0LPgcWdr1HJm8FB2nk+i/oVF4P2dfNIVZ
         BXcAvveCJW+eFO7vWSUGChwF4MkLvEUlp9XWI8lA6h1nr1wtAhUAWwLI9HRbxJGeh6mf
         JSQDiMJIfJlf1yLbDTMLrTRy74xQobnSQZxIb+3no4fQRLmnhwjYBkT1PvjTYLoRx5Fc
         Z8X0xlahU3rJHRQC8yvKPKstNdT6VSnZK2YCHNehMvxKh/wRYxW8gAz5UUi1g+lgwaHI
         BJW7kQgwqE7hBQnkHEvagkl4cx+YOrRBBKG3nazN5bktZzbT4Ban8Paa5WgrxW7hZj3G
         dmqA==
X-Gm-Message-State: AOAM530T8EhmXoHprW8CQ0Lt+iwe9M731Z2Fx7C68zG6Km6ia93g634Y
        blRu1XdDr0MRSWYohb10VsNL+wp/mulXCUrrG34=
X-Google-Smtp-Source: ABdhPJyts9y9Pdt89TN05BzK0tePeCTtCE6497hjB4ReqVQkr8TQIKW2IVuIf26YqgsFX3TvdpjeXCGK3sNtR/4W8RE=
X-Received: by 2002:a05:6512:239c:b0:478:efa9:9533 with SMTP id
 c28-20020a056512239c00b00478efa99533mr32959lfv.661.1653925807654; Mon, 30 May
 2022 08:50:07 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sgtkaylama@gmail.com
Sender: sgtkaylamanthey32@gmail.com
Received: by 2002:a05:6520:4281:b0:18f:1b94:87b8 with HTTP; Mon, 30 May 2022
 08:50:07 -0700 (PDT)
From:   sgtkaylama <sgtkaylama@gmail.com>
Date:   Mon, 30 May 2022 15:50:07 +0000
X-Google-Sender-Auth: mBlDzxmHewOdedfyNyfHOxhqW2E
Message-ID: <CALsSCysU1qzaq0ASDWxtVVykmB2XxjpMpNE0NhDn5doAZ4Xhmw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Greetings, did you get my two previous email that I sent to you?
please check and reply to me

Pozdrowienia, czy dosta=C5=82e=C5=9B moje dwa poprzednie e-maile, kt=C3=B3r=
e ci
wys=C5=82a=C5=82em? prosz=C4=99 sprawd=C5=BA i odpowiedz mi
