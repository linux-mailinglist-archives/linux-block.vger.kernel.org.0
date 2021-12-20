Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF4E47B3EC
	for <lists+linux-block@lfdr.de>; Mon, 20 Dec 2021 20:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbhLTTtf (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 20 Dec 2021 14:49:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46362 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232439AbhLTTtb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Dec 2021 14:49:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640029770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3VSP4OBZcEiBFIlN5V7GjmvAdtCAZV6sVo+w00kLvxM=;
        b=Xn8Ld1gUUfG3DKxmPdW3klMBrqSyLZB2B2R9/osNprq4KfWvag82HAf+aybmpQRQ4Og0nG
        t+H//5uO+m1PQL6dMeopcbSsf5EjSCuUlWfYwG/XhjJS1Xd45w1GnnvbJ3I3DhxPA6KRFj
        HGMTiqbDuXbMsrdrTYML7klkNTPGX3o=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-186-Pd0MiEugMaGzqTkk8LdP2Q-1; Mon, 20 Dec 2021 14:49:29 -0500
X-MC-Unique: Pd0MiEugMaGzqTkk8LdP2Q-1
Received: by mail-ed1-f71.google.com with SMTP id i5-20020a05640242c500b003f84839a8c3so3792837edc.6
        for <linux-block@vger.kernel.org>; Mon, 20 Dec 2021 11:49:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3VSP4OBZcEiBFIlN5V7GjmvAdtCAZV6sVo+w00kLvxM=;
        b=jIpttXJZ6vB9gpOtIYJqaCLTL4GtnPkVwfz2GSKHi4KmYhlAgprvuqPuJxwhYYeOt+
         JhOtXGJE/K/msfnc2gLy8a/u1oZfTKx/6DuGIWVzQtASgBN5yBttNPlhIXt3gFKu7zMw
         xfmKQpD10Zh4B7r6MG7vv9o2K/FwkYlTtEEC+doc8RZ1CYktgBsPfII4wrqjmfqwZfBl
         Ecyogw6IFmfNTcw+0Ya+Wxj2Z6zB9yiiMo4C9MkOcetM4aeUyymew02xHO7L8mtYPbv5
         9HcXhKI1C1zHH66/c/4xuccmtW4Wn+Kvbj2E3gfMLfpyVk+t/uNlN+AGqlSz2Z6naASh
         Ocsg==
X-Gm-Message-State: AOAM530H2LqvasDFCCed4D9vMe5On05EtiNAw25VAfWE3uw2cVnm7iK3
        3vN5Eg8b5CHI+LxuuUmsOTQUGjtz6FjV22xhOOmBf11Uw6rB1e+GINLm/F4A4aebmVMQfaYGFpY
        vhnAn4bnTl7N2pxfqsgrd2I9OvpxjLg7HsJ74hbw=
X-Received: by 2002:a50:bb2a:: with SMTP id y39mr17427885ede.348.1640029767968;
        Mon, 20 Dec 2021 11:49:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxhSVk25TmTevOiqf/ZAhUDa3cnqjvCV/LJQO37gUx/6JKAe7MTtqbY+kUf+K8UhvVPcor0Ilp2ZbmgaOqNvqg=
X-Received: by 2002:a50:bb2a:: with SMTP id y39mr17427876ede.348.1640029767788;
 Mon, 20 Dec 2021 11:49:27 -0800 (PST)
MIME-Version: 1.0
References: <20211220192827.38297-1-wander@redhat.com> <8340efc7-f922-fb8c-772c-de72cefe3470@kernel.dk>
In-Reply-To: <8340efc7-f922-fb8c-772c-de72cefe3470@kernel.dk>
From:   Wander Costa <wcosta@redhat.com>
Date:   Mon, 20 Dec 2021 16:49:16 -0300
Message-ID: <CAAq0SUn_Nru1NTyzgjB9ETsaM46bgDRf3DTa+Z9sG-c8yjuQdw@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] blktrace: switch trace spinlock to a raw spinlock
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 20, 2021 at 4:38 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 12/20/21 12:28 PM, Wander Lairson Costa wrote:
> > The running_trace_lock protects running_trace_list and is acquired
> > within the tracepoint which implies disabled preemption. The spinlock_t
> > typed lock can not be acquired with disabled preemption on PREEMPT_RT
> > because it becomes a sleeping lock.
> > The runtime of the tracepoint depends on the number of entries in
> > running_trace_list and has no limit. The blk-tracer is considered debug
> > code and higher latencies here are okay.
>
> You didn't put a changelog in here. Was this one actually compiled? Was
> it runtime tested?

It feels like the changelog reached the inboxes after patch (at least
mine was so). Would you like that I send a v6 in the hope things
arrive in order?

