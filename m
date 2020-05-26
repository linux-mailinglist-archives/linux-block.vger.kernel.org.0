Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D28D19EC8D
	for <lists+linux-block@lfdr.de>; Sun,  5 Apr 2020 18:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgDEQ0x (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 5 Apr 2020 12:26:53 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:34080 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbgDEQ0x (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 5 Apr 2020 12:26:53 -0400
Received: by mail-ua1-f67.google.com with SMTP id d23so4591596uak.1
        for <linux-block@vger.kernel.org>; Sun, 05 Apr 2020 09:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z6T7ksURYXKLZGeHSyOCL3A1tNfq7XKqIZYcBs2Q8Mk=;
        b=XGTA92UoUx+18PteLh/M5XPPWiyGCoyO0TpycRQaJ3yy9na9WoTpAYQue98Z8XHztd
         ET7qSbFaFeY/zA4KtjO5TB6cx2P/T9AyqQJqpHPESPxTj4MlpRKi3vjyvLj9v26XSoFY
         uGj4taDxve29elSJ4bx++oVHe6bWOUdOYWaWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z6T7ksURYXKLZGeHSyOCL3A1tNfq7XKqIZYcBs2Q8Mk=;
        b=C+3VpEPmHXbrrQZjuCmKkdm4z0rXNOI1E8VjIlUH6SYy1PbCZE8/Kju6X6mxWwXSJf
         S7Wx+KcY+n7//CcEckRm2K9Ati2x8arb3/gntw1rUUCYkI7q8LyyUW6g4ZQGsn+2WW7t
         W4GAqAAj9ePqXThRI18oekHgVr67t0iqZ4A0lYcZk0GQGU3TT2JjXFY7WJBg8KGZEJqH
         Xb6/w3/c+lWcFFvMEgYPfSN9hQgn20IbWupNEPvMDlGJktQ24O3dcrt53maA6p8Lx7wC
         qBkGwJz9EUEOGLyU6W7eEj84q0qD629yssa5EEh2CQlklIl3ohKfH/A9VTtt41qKihUZ
         MZwQ==
X-Gm-Message-State: AGi0PuadziZtZXR/XMIA9Z7lED+BbLM8Wp2R7+pBLnVQIABfsvE2rq5I
        K3wGcCtafXKCT+RYwsDvNRrixIUMKko=
X-Google-Smtp-Source: APiQypKV8YfZdOHyQs6HmBQi3a4jH3EQWeFryd/BYZUJP5qTqjN7A1TAna7wxvQWuW/2AoeTarewng==
X-Received: by 2002:ab0:278d:: with SMTP id t13mr12461861uap.118.1586104012174;
        Sun, 05 Apr 2020 09:26:52 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id r189sm3964690vke.19.2020.04.05.09.26.51
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2020 09:26:51 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id x82so8128494vsc.12
        for <linux-block@vger.kernel.org>; Sun, 05 Apr 2020 09:26:51 -0700 (PDT)
X-Received: by 2002:a67:2b07:: with SMTP id r7mr13151546vsr.169.1586104010954;
 Sun, 05 Apr 2020 09:26:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200402155130.8264-1-dianders@chromium.org> <20200402085050.v2.2.I28278ef8ea27afc0ec7e597752a6d4e58c16176f@changeid>
 <20200403013356.GA6987@ming.t460p> <CAD=FV=Ub6zhVvTj79SWPUv19RDvD0gt5EjJV-FZSbYxUy_T1OA@mail.gmail.com>
 <CAD=FV=Vsk0SjkA+DbUwJxvO6NFcr0CO9=H1FD7okJ2PxMt5pYA@mail.gmail.com> <20200405091446.GA3421@localhost.localdomain>
In-Reply-To: <20200405091446.GA3421@localhost.localdomain>
From:   Doug Anderson <dianders@chromium.org>
Date:   Sun, 5 Apr 2020 09:26:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WQZA7PGEbv_fKikGOEijP+qEEZgYXWifgjDzV6BVOUMQ@mail.gmail.com>
Message-ID: <CAD=FV=WQZA7PGEbv_fKikGOEijP+qEEZgYXWifgjDzV6BVOUMQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] blk-mq: Rerun dispatching in the case of budget contention
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Salman Qazi <sqazi@google.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-scsi@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Ajay Joshi <ajay.joshi@wdc.com>, Arnd Bergmann <arnd@arndb.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hou Tao <houtao1@huawei.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On Sun, Apr 5, 2020 at 2:15 AM Ming Lei <ming.lei@redhat.com> wrote:
>
> @@ -103,6 +104,9 @@ static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
>                 rq = e->type->ops.dispatch_request(hctx);
>                 if (!rq) {
>                         blk_mq_put_dispatch_budget(hctx);
> +
> +                       if (e->type->ops.has_work && e->type->ops.has_work(hctx))
> +                               blk_mq_delay_run_hw_queue(hctx, BLK_MQ_BUDGET_DELAY);

To really close the race, don't we need to run all the queues
associated with the hctx?  I haven't traced it through, but I've been
assuming that the multiple "hctx"s associated with the same queue will
have the same budget associated with them and thus they can block each
other out.

-Doug
