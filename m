Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D84451ACED
	for <lists+linux-block@lfdr.de>; Wed,  4 May 2022 20:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376787AbiEDShw (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 4 May 2022 14:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376997AbiEDShS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 May 2022 14:37:18 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7091D60C9
        for <linux-block@vger.kernel.org>; Wed,  4 May 2022 11:24:56 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id a21so2666863edb.1
        for <linux-block@vger.kernel.org>; Wed, 04 May 2022 11:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=azQ8sWCnz/WIz9gx757KP54kS0UJB42kEHdJ90hMQlI=;
        b=TGN9imabgriFl447VR+LtalCql2Ru1FM30YxNTrRXmNp2/aqSQe997eejilXBWN//u
         GLL7PEuW6j459zsXmON4fgRMpLVmy4AeFXc6ipyOPPq4NZahAq6TXZNADjmVrlQQdnt5
         DczkC/efB8FuKeTl9T9HqInWj7/2oPQ1dOleE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=azQ8sWCnz/WIz9gx757KP54kS0UJB42kEHdJ90hMQlI=;
        b=ISziM/r3akwFzX6yNc58hohnf9C8s5QVSkPXIY5mBypDUehNDPIfYedGuL0ADcgF+u
         bFpuUluKyeKJA2kPSjZtPpmcHRLtzoqNMZS8XPHIgjqLMrJmXOXrvzaGszfWRqOMnmaX
         mL/4HHlzrhr5N1ACxPFJnaLh5RsTmdhIuILC7RbfyCa5177FsRGSFh76ijtdB5xDbf0l
         gxHi7S5hgez0Ax1RmSbbUsJT/YWKIYjSw0CLQ98muu7vre+JQmFOzpqJ32Rtn1+fvkSo
         bnA5axI9oPIkqJJ6z1zUvybyAXHHAfoRNbSvnQOd0upQ4pdI/BCpyaozCANo4MFlh1EM
         W5oA==
X-Gm-Message-State: AOAM530Np0r2kYKxmPjrPONP5DtNt28b7GFJLY8xuyiZyNN2a6RhSVx1
        XcsxPpY7jdj4u8dEO79MX8NFwPqaAMpZFx8mY1c=
X-Google-Smtp-Source: ABdhPJx373QVKdG9ZPy/cvGy5gxqyTIKpxrvgXE8iFPH4uwInKgOooFd7bWXGSErZYT+3QEcRuo/mg==
X-Received: by 2002:a05:6402:1156:b0:427:f560:779e with SMTP id g22-20020a056402115600b00427f560779emr7256977edw.205.1651688694811;
        Wed, 04 May 2022 11:24:54 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id qp24-20020a170907a21800b006f3ef214dfbsm5973843ejc.97.2022.05.04.11.24.54
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 11:24:54 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id bv19so4488358ejb.6
        for <linux-block@vger.kernel.org>; Wed, 04 May 2022 11:24:54 -0700 (PDT)
X-Received: by 2002:a05:6512:b12:b0:44a:ba81:f874 with SMTP id
 w18-20020a0565120b1200b0044aba81f874mr15410699lfu.449.1651688238925; Wed, 04
 May 2022 11:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <1651652269-15342-1-git-send-email-byungchul.park@lge.com>
In-Reply-To: <1651652269-15342-1-git-send-email-byungchul.park@lge.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 4 May 2022 11:17:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=whnPePcffsNQM+YSHMGttLXvpf8LbBQ8P7HEdqFXaV7Lg@mail.gmail.com>
Message-ID: <CAHk-=whnPePcffsNQM+YSHMGttLXvpf8LbBQ8P7HEdqFXaV7Lg@mail.gmail.com>
Subject: Re: [PATCH RFC v6 00/21] DEPT(Dependency Tracker)
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sasha Levin <sashal@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>, duyuyang@gmail.com,
        johannes.berg@intel.com, Tejun Heo <tj@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Amir Goldstein <amir73il@gmail.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-team@lge.com, Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, sj@kernel.org,
        Jerome Glisse <jglisse@redhat.com>,
        Dennis Zhou <dennis@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, ngupta@vflare.org,
        linux-block <linux-block@vger.kernel.org>,
        paolo.valente@linaro.org, Josef Bacik <josef@toxicpanda.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        jack@suse.com, Jeff Layton <jlayton@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com, 42.hyeyoo@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 4, 2022 at 1:19 AM Byungchul Park <byungchul.park@lge.com> wrote:
>
> Hi Linus and folks,
>
> I've been developing a tool for detecting deadlock possibilities by
> tracking wait/event rather than lock(?) acquisition order to try to
> cover all synchonization machanisms.

So what is the actual status of reports these days?

Last time I looked at some reports, it gave a lot of false positives
due to mis-understanding prepare_to_sleep().

For this all to make sense, it would need to not have false positives
(or at least a very small number of them together with a way to sanely
get rid of them), and also have a track record of finding things that
lockdep doesn't.

Maybe such reports have been sent out with the current situation, and
I haven't seen them.

                 Linus
