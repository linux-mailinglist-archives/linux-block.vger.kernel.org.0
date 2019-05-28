Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0826B2D085
	for <lists+linux-block@lfdr.de>; Tue, 28 May 2019 22:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfE1UiD (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 28 May 2019 16:38:03 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38798 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbfE1UiD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 May 2019 16:38:03 -0400
Received: by mail-oi1-f195.google.com with SMTP id u199so182895oie.5
        for <linux-block@vger.kernel.org>; Tue, 28 May 2019 13:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n63V50hJZRQjx0P2uNmb8IMUSND+kw6DMXvON/eCyx4=;
        b=HgmGJXqlcmdsucWZ5xVcahU5joUSyO7VzbVzDTggcw2Ud/TlQkw5exXEiNgIq8Wl3/
         4kN4EHhDdQqMgMT8XbGgbdbnIHq/Vnf8poUX9UdXib4jjTZoX5q1nsTiCq2plehuYi51
         cdgUzgAGJnAoAKGVOBjgvJ8ROi05UA91E2pHHFv8eFGPlERmTK1T/luez1dKZ5tn1c/P
         0IYY5bMJerOhbjFG2iI+LjJYiWEl2djDa5zb8nTYVBJxtyQABjCzNOlynx7FTo/7R7Bz
         QTMN0CEynGFL68qFPk9uC19pLvZ+oLPO7lvYApLkzy0FJcLMvsdKsLGyMhXyuNKEbyCt
         n6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n63V50hJZRQjx0P2uNmb8IMUSND+kw6DMXvON/eCyx4=;
        b=Gs1CAs8BlvlY6w1r8Ry881quMMA/bfp3BUHPkXabsMrwWFbrgbbBIOZVuYeOdUjkpS
         20m/yo4n7RsE+UEa2V4cR+HkNEewC+12iTHhX5Q4PZkxM2W33wegtsWKlbqIh/jH5N7i
         6jiuCTNx7+smWjiE3YolsWksGFwSXYwGn+7Ml2Q7D0pWylMUHh6WmBC+ZZFfDLskxh5Q
         ftJ6ZZ7W3a9JIIQJIqkifDkl1o6WT231IYlry1lz5SxDWd7SwrW9AjO8bVdu7Pw7CeK5
         lTH7V7JyvgUrvBBMhe1BvZFzUOz6szNYHp4xfO1olRHNICxHiKJ5P5tVu39A9RcsPd7w
         Qrfw==
X-Gm-Message-State: APjAAAVCVjzDxnYaor5QixvRyu4Un3db4BucJtz9wMEIA2IfpKLm1+A3
        Z5NaxW3C7NXWjfIEMNmYnBlzwfBije0qix1irJF9HA==
X-Google-Smtp-Source: APXvYqzhacQSKZU30zxCXXRtqKrYjcSNogeLWirzZjg+v7dymplX/CKqxAk5vVlnLSA5obvtuO/lA2Hjt+CyAa1QzGM=
X-Received: by 2002:aca:c48c:: with SMTP id u134mr3956264oif.39.1559075882712;
 Tue, 28 May 2019 13:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk>
 <155905935953.7587.11815678364029606128.stgit@warthog.procyon.org.uk>
In-Reply-To: <155905935953.7587.11815678364029606128.stgit@warthog.procyon.org.uk>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 28 May 2019 22:37:36 +0200
Message-ID: <CAG48ez0iRCyRdMBRPPkFJP-wuiLN=VcpfHLM9cV_Cvc3z2d=+Q@mail.gmail.com>
Subject: Re: [PATCH 6/7] block: Add block layer notifications
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 28, 2019 at 6:05 PM David Howells <dhowells@redhat.com> wrote:
> Add a block layer notification mechanism whereby notifications about
> block-layer events such as I/O errors, can be reported to a monitoring
> process asynchronously.
[...]
> +#ifdef CONFIG_BLK_NOTIFICATIONS
> +static const enum block_notification_type blk_notifications[] = {
> +       [BLK_STS_TIMEOUT]       = NOTIFY_BLOCK_ERROR_TIMEOUT,
> +       [BLK_STS_NOSPC]         = NOTIFY_BLOCK_ERROR_NO_SPACE,
> +       [BLK_STS_TRANSPORT]     = NOTIFY_BLOCK_ERROR_RECOVERABLE_TRANSPORT,
> +       [BLK_STS_TARGET]        = NOTIFY_BLOCK_ERROR_CRITICAL_TARGET,
> +       [BLK_STS_NEXUS]         = NOTIFY_BLOCK_ERROR_CRITICAL_NEXUS,
> +       [BLK_STS_MEDIUM]        = NOTIFY_BLOCK_ERROR_CRITICAL_MEDIUM,
> +       [BLK_STS_PROTECTION]    = NOTIFY_BLOCK_ERROR_PROTECTION,
> +       [BLK_STS_RESOURCE]      = NOTIFY_BLOCK_ERROR_KERNEL_RESOURCE,
> +       [BLK_STS_DEV_RESOURCE]  = NOTIFY_BLOCK_ERROR_DEVICE_RESOURCE,
> +       [BLK_STS_IOERR]         = NOTIFY_BLOCK_ERROR_IO,
> +};
> +#endif
> +
>  blk_status_t errno_to_blk_status(int errno)
>  {
>         int i;
> @@ -179,6 +194,19 @@ static void print_req_error(struct request *req, blk_status_t status)
>                                 req->rq_disk ?  req->rq_disk->disk_name : "?",
>                                 (unsigned long long)blk_rq_pos(req),
>                                 req->cmd_flags);
> +
> +#ifdef CONFIG_BLK_NOTIFICATIONS
> +       if (blk_notifications[idx]) {

If you have this branch here, that indicates that blk_notifications
might be sparse - but at the same time, blk_notifications is not
defined in a way that explicitly ensures that it has as many elements
as blk_errors. It might make sense to add an explicit length to the
definition of blk_notifications - something like "static const enum
block_notification_type blk_notifications[ARRAY_SIZE(blk_errors)]"
maybe?

> +               struct block_notification n = {
> +                       .watch.type     = WATCH_TYPE_BLOCK_NOTIFY,
> +                       .watch.subtype  = blk_notifications[idx],
> +                       .watch.info     = sizeof(n),
> +                       .dev            = req->rq_disk ? disk_devt(req->rq_disk) : 0,
> +                       .sector         = blk_rq_pos(req),
> +               };
> +               post_block_notification(&n);
> +       }
> +#endif
>  }
