Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0789567306
	for <lists+linux-block@lfdr.de>; Tue,  5 Jul 2022 17:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbiGEPq4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 5 Jul 2022 11:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbiGEPqK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Jul 2022 11:46:10 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A494C1AF09
        for <linux-block@vger.kernel.org>; Tue,  5 Jul 2022 08:46:00 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id d3so11448077ioi.9
        for <linux-block@vger.kernel.org>; Tue, 05 Jul 2022 08:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=GR2p63BS/ChSrJTErcsL6FDgshrMMqE2JBQFZoqpd64=;
        b=dBF4ZI/DerIIkzX4p7l/i4Q+Oi7tbdtX+SoZkZ91QGyvtKxaBYNc1SB+Zle+bq3IDd
         O6Jvq2aY8SKwgzAFgHJJhrOxXd9UlFNYPL8/GMEWSpL1yd34MyhsF0iVkbPYp1zfTE7C
         0anvll9AmPtqRinn3PPvEAg2nWVYZgKlZ/B9Gw7/7U/Ychg0VQjLmzs+e4mqWlbhLI9Y
         YdTJolxUb7HPvlzjnHjziUBLScqS6t10N7Yl3/3LBJKnv51Y9kJctAgL28Xd5GZZoet7
         WNAeDcQ8Ev/L3Nx3gKUDvSPdYJJyapG/k972mj80QhggcmoSzEwKZ+nRBRF4ew7GSxtU
         FDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=GR2p63BS/ChSrJTErcsL6FDgshrMMqE2JBQFZoqpd64=;
        b=VM8GAUzLOnQlr/lqJoyavaOLg3TkVN9a7Cok4911/fj75nq+MlqHZvbMFgghgjSk9u
         iSdIfa1VmW7Df0eIg8N5fxTf+1qyhirTZt3aygQTQ2W2mho1jeqA2kOHwhkUNkmtlto4
         LcIAkK7+gx1hoYZMGanLKi31ZvdXFpS53+P9oj8eRP8etvH8R4vao/NEKT7GZaH4bKyn
         8hEv/leU6x6OEkAhrM5APyFxDsgwccQasR8417pD5X9hcWgMaNaEuVParrZWBgdgcvpx
         1xDcdGrQBGZHMnD9lCrgxqR0HoSQAY/caWP/5frhO4uAbbqbI6EloJO7SI3Bgy4c74jF
         NsNQ==
X-Gm-Message-State: AJIora/uqNT9QqxOvv03zRZ18H3cl+t/fAbX3XeXxULt3mc7tAdPrSnq
        Q5RCXt6SftFFDq2ybAedCF3yEjE+wPPxOAYIX0s=
X-Google-Smtp-Source: AGRyM1v3nhWl4LF5UpyrlW9FfZfhi+XYUwlf3+zna4P6M7jReCNi1EaxvuP4J7Z5YFgIqzubxT0m8STg4UkHRhBvj4o=
X-Received: by 2002:a05:6638:3793:b0:33f:6b:f166 with SMTP id
 w19-20020a056638379300b0033f006bf166mr23894jal.257.1657035960064; Tue, 05 Jul
 2022 08:46:00 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sgtkaylamanthey612@gmail.com
Sender: touresidi442@gmail.com
Received: by 2002:a05:6602:1645:0:0:0:0 with HTTP; Tue, 5 Jul 2022 08:45:59
 -0700 (PDT)
From:   Kayla Manthey <sgtkaylamanthey612@gmail.com>
Date:   Tue, 5 Jul 2022 15:45:59 +0000
X-Google-Sender-Auth: i4I1WVA3LKGXxSDug8PwWQu9BDw
Message-ID: <CAMkF86V_5LsUUx=1qAN=FoS+u2=dePA7H9th-bCfHw7+Gs1-tA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Dobr=C3=BD den, neobdr=C5=BEel jsem od v=C3=A1s odpov=C4=9B=C4=8F na m=C3=
=A9 p=C5=99edchoz=C3=AD e-maily,
pros=C3=ADm zkontrolujte a odpov=C4=9Bzte mi.
