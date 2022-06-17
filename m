Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2293254F642
	for <lists+linux-block@lfdr.de>; Fri, 17 Jun 2022 13:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235259AbiFQLF3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 17 Jun 2022 07:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235549AbiFQLFX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jun 2022 07:05:23 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27436C0FC
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 04:05:20 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id h23so4366818ljl.3
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 04:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=Jh3M8LDovYWs/mBJiVJoI/DS8xun0EDDqspVSX/swmY=;
        b=ROHIKr0gNV0WC7apLWhcODm7zYSh3/6QUaqKgcbqbXOFI/uMh4hBQ6upcXGxwiJ/ea
         hPqiLPa2R9eebMHPFiGqh717Dccn4ka2s0/KvMCi/TOwQO3a/c3sY5KkVJ2eYk4YrHGB
         042fDvxCKFqQTFh8tJLxUistHAqWAj3uWRZfbehzk0ha/KNmgulrGBoEBI1W4xOE/df/
         7+/OdWN+jIy3DDYtc7mfY7HfgP2rdLdgE8cXdNjGGwBXQ9Rl7wjy2agUMEbsuzP8u/gu
         rysIOmQ/OIRWs3aV+f3ZvobniLdzuqcAB1J0lawu7yzgxXysY3Rnqgubj2t/PUtc71Iz
         JTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=Jh3M8LDovYWs/mBJiVJoI/DS8xun0EDDqspVSX/swmY=;
        b=q9vz5B6ZEyPSQuTucv2huaDFlWABBaOqgSLwpJRJr8T6QsFk2yDmJwSEYmZKxjey8N
         DYI+WoYyds6VKjXz1vQeUOnMw2SSQybfx66Dh74Njz+pBnD2h1GBkdkecQrgwL5ftNWq
         okX4TyzaYB93e2Uv+E1P0Of20iqyO35JwTfy4KoOBRUPkU8A2MvyQFdQKmsz3j1bn1Wt
         RMKyfB01xFOR8qbU6VPsfygB28pFXvgdhaVjJHEyygclezb7zbtoEiqYuwof3RVrvTS7
         QNf0ZeWU85/6zMgbWhOJsAo+1HsM2OkyjieCwWOIC0vT1IBVn03zunUlTlwNgLe60XhU
         uEPg==
X-Gm-Message-State: AJIora8YDbLsD/wzkkGF5vLr2l9KsOQusqnXDZYXKMAVTO0EwiT5Y9lH
        ltxw/Cck66EW7InO9KgataZrXmmY8yT8tra6hZQ=
X-Google-Smtp-Source: AGRyM1ueVXADqwQwX8wE6PBVnerb12awQRHEPMxhUZjdWtzw6oZXVUlciqHvp862TZcd+uRdXPJg8PFxtv7H1ZnQkLw=
X-Received: by 2002:a05:651c:1549:b0:258:4386:f6a2 with SMTP id
 y9-20020a05651c154900b002584386f6a2mr4641118ljp.527.1655463919194; Fri, 17
 Jun 2022 04:05:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:680f:0:0:0:0:0 with HTTP; Fri, 17 Jun 2022 04:05:18
 -0700 (PDT)
Reply-To: sj7209917@gmail.com
From:   Joseph smith <maelyskpeta@gmail.com>
Date:   Fri, 17 Jun 2022 04:05:18 -0700
Message-ID: <CACKGxpzUX=q9UbG9foKmEBftVUzUrBi0ih16YJngNh+fZyW+dA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi   are you available to  speak now
Thanks
