Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562806AE17F
	for <lists+linux-block@lfdr.de>; Tue,  7 Mar 2023 14:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjCGN5D (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 7 Mar 2023 08:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjCGN5C (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Mar 2023 08:57:02 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538123D934
        for <linux-block@vger.kernel.org>; Tue,  7 Mar 2023 05:57:02 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id h8so14089910plf.10
        for <linux-block@vger.kernel.org>; Tue, 07 Mar 2023 05:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678197422;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=baWonEXSb/K4v/yFSvVpNeU0JFI/BWw4Lj8lad4SY58=;
        b=VLvAd9C8muneuM5tsOIBTDIAlOesf8L2S97e+v+urong2RkhzQSXZGmWJOVMwXJnqs
         47p0Yz1jM/Lfptob5lVHMX7B5HoXan8JZgB7Eq7QTvjN/W2U5BBu3/dFUYBSA0dV0klL
         ip51YfrdQt4iwzfUqm20vmMzivULQieSBuL66HpDhh7VZ9zPXjT0apHdIC4A+aTF7McH
         LmUN32n7rOMc2bDP1atY7HRbJ1QCnTiw9179zGqpiI9JOJb0gAyR/ywNHzbGYL2Iv9Xw
         SupJWLXRwJain7Yuj5IN5RVinFeCLPSPLa2aQv9+zc6Al+fjxsdqipH3BKlUaMlfQFg7
         qwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678197422;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=baWonEXSb/K4v/yFSvVpNeU0JFI/BWw4Lj8lad4SY58=;
        b=sU1J71q4Vf1zJV9xsccvnJPQyUOjde5SHj7jfH4zTwsBvF1AU18y18EBemf9ZCVXk+
         Dkm3EhBoHggkKQgMj7o4Hte7/fM8mcCkZNjeQDbkH2lziQQLKD1T2UnTm/BIfsh3VP7m
         cTbtk3ALJqaUT9/AR7X4ItJBIzgkxY3F9b5deUziKOSkzb5sqY+FBvuXlm44LYMhXZi2
         sFX9IwnESeHTdQLSXBqyvn/Mg42k65gv6PaRjki5BPeN+9z7wmBDikJfJFlpo2DILQqM
         eh+4o5/oX4xCjuJwkPP42PqbthKJpimS7CrwjNq647uhES/XlJI6JpQBRcl8hKkfS61Y
         Nl4g==
X-Gm-Message-State: AO0yUKU8ubOuw20DPHUbGBcoKVnELSLGSiFpvi5ajHTcXGK4eQ2Z9BM7
        s0Dh62HpmcBHPAnm12Yg7KX66RNyvOoCp3F2BmU=
X-Google-Smtp-Source: AK7set/QnFpV/WpL4py2XN9raeNGpgheQSwGQbR5MvUgV3JEO4cNnDfdKd9abKT9SvtaumO32Wd7Rf4dDcOlGuEidXo=
X-Received: by 2002:a17:902:efd4:b0:19a:efe3:b922 with SMTP id
 ja20-20020a170902efd400b0019aefe3b922mr5812981plb.9.1678197421891; Tue, 07
 Mar 2023 05:57:01 -0800 (PST)
MIME-Version: 1.0
Sender: mattermoney04@gmail.com
Received: by 2002:a05:7022:6081:b0:5f:b33a:6d80 with HTTP; Tue, 7 Mar 2023
 05:57:01 -0800 (PST)
From:   Anthony Kwami <anthonykwa900@gmail.com>
Date:   Tue, 7 Mar 2023 05:57:01 -0800
X-Google-Sender-Auth: ZXr_mZoVO6sXBsejZKpXGN7Cz48
Message-ID: <CAPw7zaAow68ZnHPX_EXYRfdxVcuhVVJm7poXYRQ645-VYCdSBg@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello

I have something very important to discuss with you. This is an
essential detail that will help you.


With regards,
Anthony
