Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C4358BC48
	for <lists+linux-block@lfdr.de>; Sun,  7 Aug 2022 20:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbiHGSOj (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 7 Aug 2022 14:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235543AbiHGSOQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 7 Aug 2022 14:14:16 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA1B9FFE
        for <linux-block@vger.kernel.org>; Sun,  7 Aug 2022 11:14:12 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id z3so5160892qtv.5
        for <linux-block@vger.kernel.org>; Sun, 07 Aug 2022 11:14:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=uszpsfQkA+n/mZQMeMzaHtYhGxV7ZrgTx0FwG51IMxk=;
        b=Nr+IvIEUv3j9mcE2Wccj5lIILgfbb/+2Uyohbv++sbcge/FNfjX3to2HZldFk5gFF1
         7pqfgBa1XvibVPYdtFNm4zU7pLVs//DUH/fqavUZ/iua4rO3ZV2mpGn94mBut+WZ+UCa
         tQPeMSKl39/u+RVMZu9rmdMdymJDQcvXW0ZxZ0iqogtsqJ3cTyexHMOseFwdiGZ07NxL
         Z6bXWS5Kw+6n/s6hevWlQVBJjql/IaV3AjVQX4NV4+kCTo3sZi+A6dTi9fDVP6CJ/kkj
         riFymk3BkX9G0V43eShpmd/Xygf0EkF3r+KyG3m/XoO6bpfdHe2lkV8NzqkitKSvzDPb
         qcTQ==
X-Gm-Message-State: ACgBeo0R2vUrC9Kg6+XC8ceCPUtx/QmcWF2Qe1P3laPbr+oOsjiNAU5Q
        wBwYTFtfPH+birxuy0CBct0M
X-Google-Smtp-Source: AA6agR6/KgTQI6IHVHe5/he7j5Khvjn4y41cYM25rOSJkcCqUqeqS34j9+6cwADmtwyEyP30dJ4JCw==
X-Received: by 2002:ac8:5cc7:0:b0:342:f760:5bc0 with SMTP id s7-20020ac85cc7000000b00342f7605bc0mr2317560qta.658.1659896051683;
        Sun, 07 Aug 2022 11:14:11 -0700 (PDT)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id b19-20020ac844d3000000b00342f8143599sm1077098qto.13.2022.08.07.11.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 11:14:11 -0700 (PDT)
Date:   Sun, 7 Aug 2022 14:14:09 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Milan Broz <gmazyland@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Nathan Huckleberry <nhuck@google.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Sami Tolvanen <samitolvanen@google.com>,
        Alasdair G Kergon <agk@redhat.com>
Subject: Re: [git pull] Additional device mapper changes for 6.0
Message-ID: <YvAA8fI37owuSe7y@redhat.com>
References: <YugiaQ1TO+vT1FQ5@redhat.com>
 <Yu1rOopN++GWylUi@redhat.com>
 <CAHk-=wj5w+Nga81wGmO6aYtcLrn6c_R_-gQrtnKwjzOZczko=A@mail.gmail.com>
 <Yu6zXVPLmwjqGg4V@redhat.com>
 <CAHk-=wj+ywtyBEp7pmEKxgwRE+iJBct6iih=ssGk2EWqaYL_yg@mail.gmail.com>
 <99e17678-8801-ac41-de20-a5f6f60da524@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99e17678-8801-ac41-de20-a5f6f60da524@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Aug 07 2022 at  3:37P -0400,
Milan Broz <gmazyland@gmail.com> wrote:

> Hi,
> 
> Just a few notes on why we use target versions in libcryptsetup,
> as I am perhaps one user of this field there.
> 
> TL;DR: it is *only* for hinting to users what is possibly wrong
> after activation fails because there is *no* proper error reporting
> from the device-mapper.

DM's core and target versions aren't intended to be in service of
error reporting. You abusing them like that is a fundamental problem.

[[Unfortunate tangent but you've left me no choice:

Your general tone and misinformation-using-broad-strokes makes me both
sad and angry. I will restrain myself in this reply but your position
drips with general FUD and loathing. This is way more "Milan being
Milan" than I've ever experienced. Could be you've been storing it and
it all just gushed out, no idea. But it's a lot to try to take with
grace.

As you know I'm a very direct person. I speak my mind too. But I've
learned to try to avoid alarmist rhetoric that amounts to throwing
people(s) under the bus (better late than never). But if you're going
to resort that you better be _very_ certain it's justified. Yet as
cathartic as it might seem, even then it isn't the correct answer. If
you want to remain being respected please treat others with respect.

Only you know why you are flailing about with such an attitude, please
come to terms with that. I wish you well and certainly don't want DM
to be some constant or reoccurring source of such negativity (for you
or anyone).]]

> On 06/08/2022 20:36, Linus Torvalds wrote:
> > On Sat, Aug 6, 2022 at 11:30 AM Mike Snitzer <snitzer@kernel.org> wrote:
> ...
> > > Yes, I know you mentioned this before and I said I'd look to switch to
> > > feature bitmasks. Yet here we are. Sorry about that, but I will take
> > > a serious look at fixing this over the next development cycle(s).
> 
> Please don't just replace it with bitmaps.
> 
> It will not bring any better interface while adding more magic with
> handling compatibility, as we need to use both... see below.

(I saw your "below", it lacked a coherent explanation for why "we need
to use both" as a rule moving forward)

When done properly it will _not_ require both. The version number would
be incremented one final time and would serve to allow existing
userspace to run unmodified. But from that point on the bitmap flags
should be used and all userspace converted to use them.

> > Well, right now we're in the situation where there are certain kernels
> > that say that they implement "version 1.9" of the thing, but they
> > don't actually implement the "version 1.8.1" extensions.
> 
> I cannot speak for the others, but for veritysetup (libcryptsetup),
> the worst that can happen is that the user will get a wrong error message
> (or just a generic message "something failed, bye").

You know how to send email to report specific problems and/or submit
patches. But I really don't recall anything in this category being
reported by you, certainly not recently... maybe you've just
internalized or I somehow missed it?

> (All the crypto options are tricky, I would like to keep at least basic
> usability and better errors like "seems tasklets are not supported,
> retrying without tasklets flags.")

dm-verity's optional "try_verify_in_tasklet" is using tasklets as an
implementation detail, if they cannot be used (e.g. for FEC) then why
would fallback to normal verification using a workqueue be reported?

Or are you referring to something you saw when using dm-crypt's
no_{read,write}_workqueue options?

Or are you saying that both the new dm-verity try_verify_in_tasklet
option and the dm-crypt no_{read,write}_workqueue options should
fallback to removing those flags and try without them?

That is a level of AI I have no interest in adding or supporting.
The user asked for something, if it isn't possible then it should
fail.

But please be more specific.

> In principle, we use activation flags/options as Linus describes - try
> to set it, then deal with the failure.
>
> And *this* is the real problem that needs to be solved - there is no proper
> userspace interface that says what went wrong.
> 
> The userspace sees only -EINVAL from ioctl() and a generic message.

"Please extend the DM ioctls to somehow add ti->error to the userspace
response" is a fine feature request. Should help no matter what.

(Can look to have a phased approach to the error reporting payload,
start with errno and error message, add more "structured" payload over
time. Are you referring to JSON or some other format? Whatever systemd
uses?).

> Perhaps in the syslog is more info, but usually only at debug level
> (that is often not visible), and parsing syslog is not the option for us either.

All errors should be emitted with pr_err() using DMERR(). I've made a
conscious effort to convert DMWARN() to DMERR() when appropriate. But
I'll audit all the DM core code and then work through the various
targets.

If there are incorrect log levels being used it is a bug, please
report and/or fix.

> What is even more problematic is that the error string in DM target is
> often set (e.g. ti->error = "Integrity profile tag size mismatch.";) but later
> discarded, and it never reaches neither log nor userspace calling the failing
> ioctl().

Again, if you see a bug: please report and/or fix it.

> If the device-mapper can fix this, we can easily thrash the magic that
> consults the target version and determines what went wrong.

There is no way to properly use version numbers to derive what
actually went wrong. Could you narrow down and isolate the possible
failure based on version in specific cases? Sure.. but it is insanely
fragile (especially with stable@ and distro kernels).

> Then you can forget the version and feature bitmaps and send
> us a proper (ideally structured) error message in ioctl() reply.

OK, I can just avoid switching to feature bitmaps entirely, stop
bumping version numbers, and focus on better error reporting. Then all
of userspace can rely on errors reported to fail and inform user
actions.

But I'm pretty confident lvm2 will have something to say on
this... I'll take all input into consideration.

Mike
