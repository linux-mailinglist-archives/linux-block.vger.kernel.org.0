Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1573359B535
	for <lists+linux-block@lfdr.de>; Sun, 21 Aug 2022 17:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiHUPvf (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 21 Aug 2022 11:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbiHUPve (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 Aug 2022 11:51:34 -0400
Received: from mail-yw1-x1142.google.com (mail-yw1-x1142.google.com [IPv6:2607:f8b0:4864:20::1142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A511FCF9
        for <linux-block@vger.kernel.org>; Sun, 21 Aug 2022 08:51:33 -0700 (PDT)
Received: by mail-yw1-x1142.google.com with SMTP id 00721157ae682-33387bf0c4aso233795157b3.11
        for <linux-block@vger.kernel.org>; Sun, 21 Aug 2022 08:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc;
        bh=lYgoSzYrNdAJHRDpvyMHA0AN8YmF5hdaYVpe90B0Tz8=;
        b=G129SMtU59wTnXy7MwiVG+nTpWQiUzpSux/o6wewBlRFz0zPQ1/Z8IRQRyRWquc9qs
         syqUwjIjxASz/a0t8a0omw75LNc4kxXe10lIXgT8Ml0ToLlkYXRLGGpNbTirKk7viSMl
         NGGiQ2qV9CH+ASxTFSCD9sT6MtFK0oVcE5E24RTvemldBIXUS4VTqSj61T0mINZq8ghB
         iLyWHD2k4BT5vc6ret9By7e6tYtuSFbne/CvYsTZ1FBsJ9YUfOj2+pklrbi9joWx/bJL
         bK8LqucgegxItDHiTPRHyUuawJahyIdVXUDg/TNOYvNbTL8XLtjyeJUOEQCgL4aN8ayK
         FtIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc;
        bh=lYgoSzYrNdAJHRDpvyMHA0AN8YmF5hdaYVpe90B0Tz8=;
        b=uoE/gkycV6jNO6gkVDc5Yg6jMkOFy0iuCedB1IT2oI0u4gupsFnmgRPoUlzIKJ6XvI
         w2geVQ/MNVewObDGVeirM+GW5aminkBmvRK1C8qHXKkMj+hfMVMuCE6U8cegTrw+hWCm
         g/b2MfZJNE5DhEYioEPz4zV54vAdmX5tbt9gEFWNTfePewgPMwE+dbCVlMGaNRCWI/bD
         6uoDbGHCoSSW0llXBcZd26ifK+AowR88SaFYf1bqt8r9gws9xpmutbaUdtae5/iMNaWE
         nv1NPKktY7HrOdtU26TQ7srE0+LZBiMscdZh1Q7dqObW1dFaJM8bCYxghZ7WHj/BtIiN
         iU/A==
X-Gm-Message-State: ACgBeo1rLMEEtuB/QHlaV2gzgF0igfmGRb6+jlYdOfs0X7in8WBGnlPU
        0gHqVlShBaIqIZczVBcz0WXo3EaYZcec9y83dio=
X-Google-Smtp-Source: AA6agR5bTJ4M4PETne0iMMuN0ZjK7/wR++cUluLx7hI75BThYXXyq6W8cieq3t2p8+FucOCs3476tWRZXUL3iAgYqU0=
X-Received: by 2002:a81:817:0:b0:333:c5c9:dfb4 with SMTP id
 23-20020a810817000000b00333c5c9dfb4mr16304549ywi.476.1661097092813; Sun, 21
 Aug 2022 08:51:32 -0700 (PDT)
MIME-Version: 1.0
Sender: shadainarang444@gmail.com
Received: by 2002:a05:7010:628e:b0:2ee:fd59:7df0 with HTTP; Sun, 21 Aug 2022
 08:51:32 -0700 (PDT)
From:   Pavillion Tchi <tchipavillion7@gmail.com>
Date:   Sun, 21 Aug 2022 15:51:32 +0000
X-Google-Sender-Auth: 8xZbKLvR_GWLtosofcHxMj5rGb4
Message-ID: <CAME1XYdcyb4q+6azGVj2GaLw_1xW80TupzRjD8ALnSDmOSCJxg@mail.gmail.com>
Subject: Bonjour
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--=20
Bonjour
Avez-vous re=C3=A7u mon pr=C3=A9c=C3=A9dent e-mail ?
