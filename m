Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625F01BE452
	for <lists+linux-block@lfdr.de>; Wed, 29 Apr 2020 18:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgD2Qt3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 29 Apr 2020 12:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726743AbgD2Qt1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Apr 2020 12:49:27 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80FBC035495
        for <linux-block@vger.kernel.org>; Wed, 29 Apr 2020 09:49:26 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id y3so2281883lfy.1
        for <linux-block@vger.kernel.org>; Wed, 29 Apr 2020 09:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D9Uuz2eH1rEC3Rsd9pWrnSIaGFJoBuGHkEpyj9FO1RU=;
        b=fNkYlfC7XyU0na36V1nAsEErxJD6SCdd001tONSj5QzCTF5pfnhtkJHTnLvT4RbjHZ
         Esmpn/Ja4kfMTNbK4V/ULBUaFnl8J/DehN+PSbsUTUNm9u5a0/1rtLVU7yIw59uOmHc1
         Oz8J1e1DSH0V3mg6CW+Ys3Xe1HiKJDyaEj9z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D9Uuz2eH1rEC3Rsd9pWrnSIaGFJoBuGHkEpyj9FO1RU=;
        b=mZxMX7PhKlaVZyncVQygSdlqLx+TU1Hucx16DCwz56NayTX09DAQPkY71a5xTAiwn8
         rBh4VzI/G1ynZdcZzRFT12dywpycurLuREhukmKgHIZrNf7IENr9PcFxO+UGFtgNTBco
         a0zbMF4OUSRn0Hdr6wGAdHc4qL2MfHOg/Hw2eOrQg2GQ5DB9uMmdWfwojzg4Z9/JGzQK
         xCg55WyVEKoxa1lKyj6UGERI4AtJdImQx7bQnHMeM/ZtL1LxH4FV59wwKIuOyt4u8Lus
         7x6iGH64x3NK/seQ058QBv5KBIYmLvw0tR8k5pC7QHnO85l3N57Uh7CUxg5wnQ4x6n66
         iVJg==
X-Gm-Message-State: AGi0PubHnpQUBpbZJuLYSCM0DL0XJIlp6j4F2wTmV+8Yht24w3LJU311
        6RZsGUixNqIEvPnC2SjWAyFzEcSxH7A=
X-Google-Smtp-Source: APiQypL4HkHp6z76NcPO6ZQA7OQ6fgJbqD0MNv95BgJItbtVZIKRWEmeBRFJ38atNiPJy5L09Bj0kA==
X-Received: by 2002:ac2:47f0:: with SMTP id b16mr23595289lfp.81.1588178964552;
        Wed, 29 Apr 2020 09:49:24 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id g11sm2623689ljg.24.2020.04.29.09.49.22
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 09:49:22 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id f8so2242019lfe.12
        for <linux-block@vger.kernel.org>; Wed, 29 Apr 2020 09:49:22 -0700 (PDT)
X-Received: by 2002:ac2:4466:: with SMTP id y6mr23676248lfl.125.1588178962247;
 Wed, 29 Apr 2020 09:49:22 -0700 (PDT)
MIME-Version: 1.0
References: <158810566883.1168184.8679527126430822408.stgit@warthog.procyon.org.uk>
 <20200429060556.zeci7z7jwazly4ga@work>
In-Reply-To: <20200429060556.zeci7z7jwazly4ga@work>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Apr 2020 09:49:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiHoa0onB0KTthLXeHNNBupcPOdf38OEoFFy3ok3nOeJA@mail.gmail.com>
Message-ID: <CAHk-=wiHoa0onB0KTthLXeHNNBupcPOdf38OEoFFy3ok3nOeJA@mail.gmail.com>
Subject: Re: [PATCH] Fix use after free in get_tree_bdev()
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 28, 2020 at 11:06 PM Lukas Czerner <lczerner@redhat.com> wrote:
>
> This fixes the problem I was seeing. Thanks David.
>
> Reviewed-by: Lukas Czerner <lczerner@redhat.com>

Well, it got applied as obvious before this, so the commit log won't
show your testing.

Commit dd7bc8158b41 ("Fix use after free in get_tree_bdev()") in case
anybody cares. Didn't make -rc3, but will be in -rc4.

          Linus
