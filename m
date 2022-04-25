Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E570250EBD6
	for <lists+linux-block@lfdr.de>; Tue, 26 Apr 2022 00:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237872AbiDYWZK (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 25 Apr 2022 18:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343627AbiDYVul (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Apr 2022 17:50:41 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92423AA54
        for <linux-block@vger.kernel.org>; Mon, 25 Apr 2022 14:47:35 -0700 (PDT)
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 816363F1D3
        for <linux-block@vger.kernel.org>; Mon, 25 Apr 2022 21:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1650923253;
        bh=UO4wzxZajFtH3qcfy3dLF1bQAk44v43NDT+rmdRn5Yo=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=J5+97Ol7GprYEW2ZEzNG4XzYVNsOUW0hZWdsQzVB/duFtm7QztNyWaCuwFifRdVLS
         UK1L5wsfM9Ng4KwhlUOM6ddLDISodBfm93unZoI892dJsJUI9OK76qgKASLecXZrIl
         5xct1CynTk3pCa0/saQfmfmTeEuPUvvFJ39omJCB6zUfdh317D7D8oJL8sg2+gTRu5
         zvxU6CqFHPfTPxzVPL7Yr8qVvVYIjp27l5LhfKkcRFx92VoQAZoiGANueJM+j7uut6
         Z01+xXCiWe/4/Eu4Z42UtYTMKKty4G3LW01MvFO8wM3jPXKC2pKF4sYWBi/9RfCYM+
         4vhJAozziJTUg==
Received: by mail-pf1-f197.google.com with SMTP id i19-20020aa79093000000b0050d44b83506so2050728pfa.22
        for <linux-block@vger.kernel.org>; Mon, 25 Apr 2022 14:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UO4wzxZajFtH3qcfy3dLF1bQAk44v43NDT+rmdRn5Yo=;
        b=DqQw3psiqaNthDXejCFoCnc5hbZ0857i0Ttl7gytzcy+vGfRywTGbkNJdujkcUwigJ
         w+4FbT6ZqcBa9+rfsEZWgz0ubAlnHhk6z6VDJ585W25+PWDwZoiBEUPMftQI9Nvsv29V
         IpNhaxvR8kkqOzh8qOLLlisVj/V5mm0CUOhjMugVIOsM2HptSHJ8FlE8QS7+eXUIxHpB
         SUyW2iwk0kSoYJ3irIzjitFjt/SeVQSSjmH8XMpRk8AKOC0oDDuTcyPwUL9rLjrja4h+
         ZxhhcZxaUdldAOX4K9LLR5N1YxfqXA2s/JuxJdJpXph+ck/nHKYS1728v3Qd9Pa9PRiT
         hnUQ==
X-Gm-Message-State: AOAM533CJSF/ihBk76PPVxdoPVzRjO4vW26cUFEbux3qKLk8msf3y7w8
        Mq8etZBniLKttQOb8X3MDe5jLqwd5ZgtlBsZ23M8XAQWwgD/5gDx+OM2Yd798N/vwnhTtsCBFEA
        /jnkO1iyycAhNQXc5HzLOpDy9eWN5MS8kaUByrQpDJruhpc45NqTYVCA+
X-Received: by 2002:a17:90b:886:b0:1d9:3a05:3f2a with SMTP id bj6-20020a17090b088600b001d93a053f2amr14051816pjb.53.1650923251836;
        Mon, 25 Apr 2022 14:47:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw2rdYzYOX06hsXRuD35oezdKlAmuDxmoRYv+cEWg5RH4h591X/jJQypqGczm4ZFvbqbJKbrTN/oPcN6sjDAD4=
X-Received: by 2002:a17:90b:886:b0:1d9:3a05:3f2a with SMTP id
 bj6-20020a17090b088600b001d93a053f2amr14051798pjb.53.1650923251590; Mon, 25
 Apr 2022 14:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220422054224.19527-1-matthew.ruffell@canonical.com> <CAEzrpqe=LD3DQcEeLXmmFuq7cX_dAQ6DOCuJYWBoZWKKTmoTzA@mail.gmail.com>
In-Reply-To: <CAEzrpqe=LD3DQcEeLXmmFuq7cX_dAQ6DOCuJYWBoZWKKTmoTzA@mail.gmail.com>
From:   Matthew Ruffell <matthew.ruffell@canonical.com>
Date:   Tue, 26 Apr 2022 09:47:20 +1200
Message-ID: <CAKAwkKt3yMOOW3NXcE91WkGr+8xj050CYP2pLoQVHt_2wXq=-w@mail.gmail.com>
Subject: Re: [PROBLEM] nbd requests become stuck when devices watched by
 inotify emit udev uevent changes
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        nbd <nbd@other.debian.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Josef,

The pastebin has expired the link, and I can't access your patch.
Seems to default to 1 day deletion.

Could you please create a new paste or send the patch inline in this
email thread?

I am more than happy to try the patch out.

Thank you for your analysis.
Matthew

On Sat, Apr 23, 2022 at 3:24 AM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On Fri, Apr 22, 2022 at 1:42 AM Matthew Ruffell
> <matthew.ruffell@canonical.com> wrote:
> >
> > Dear maintainers of the nbd subsystem,
> >
> > A user has come across an issue which causes the nbd module to hang after a
> > disconnect where a write has been made to a qemu qcow image file, with qemu-nbd
> > being the server.
> >
>
> Ok there's two problems here, but I want to make sure I have the right
> fix for the hang first.  Can you apply this patch
>
> https://paste.centos.org/view/b1a2d01a
>
> and make sure the hang goes away?  Once that part is fixed I'll fix
> the IO errors, this is just us racing with systemd while we teardown
> the device and then we're triggering a partition read while the device
> is going down and it's complaining loudly.  Before we would
> set_capacity to 0 whenever we disconnected, but that causes problems
> with file systems that may still have the device open.  However now we
> only do this if the server does the CLEAR_SOCK ioctl, which clearly
> can race with systemd poking the device, so I need to make it
> set_capacity(0) when the last opener closes the device to prevent this
> style of race.
>
> Let me know if that patch fixes the hang, and then I'll work up
> something for the capacity problem.  Thanks,
>
> Josef
