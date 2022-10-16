Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4AE60038D
	for <lists+linux-block@lfdr.de>; Sun, 16 Oct 2022 23:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiJPVzV (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 16 Oct 2022 17:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiJPVzT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Oct 2022 17:55:19 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08EB20F62
        for <linux-block@vger.kernel.org>; Sun, 16 Oct 2022 14:55:17 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id e62so11372835yba.6
        for <linux-block@vger.kernel.org>; Sun, 16 Oct 2022 14:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wszyfBfu6o0pJeTfxZ3sPP5HSff3se7414oIjk2paL4=;
        b=fnz4xpG1gb0J2jl2LtjwGXAlzZNDeyhuYq2cjSEtlRizK8k6IjtyysN9X+epEep9ki
         E1rr7DffYfc/il+ZnvGUM4+cMLaA1ay/7hiXIy+c34ACPhyWLteifzkIEyKYiT75D2l5
         OUMCrdM2aM0c5bTMTn90zunuSPDUAPDgTMR1kVef3jq5m9q3GDLC3CEsJWBWW+65rHxj
         7WXDfzqnyNERVsIolbTz48ZzXuVxuKenyyMrm5DEocBAXIIuoCrx3TWSrKt1kKIWagFA
         roWeOycEt1yTVzkEhKlvn/jY/9wbDmDBvOhk7ociTGv43jHb5/Uy6Hzm/Vw+GwNGYAL7
         5I4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wszyfBfu6o0pJeTfxZ3sPP5HSff3se7414oIjk2paL4=;
        b=uetF4JMhOqs4F8tWo4XwZiTk+Wd1uHvOLVzKED1eBnhtTD42dNl/lpBRwN8I+ijqMS
         aab75+TQVxBqewpYAxZ844V64Q4w1X6D+8fgb5lYmj0truIa5oBhVuVo1dNtrMh2PAlJ
         /yHf+Be9u6Wh2lsOXW+D0ejFlbvTNgQ4FdJNuOVSmL4RX4DLhnUjXoHkIwNve6ub9A1p
         KFEOIK1hCMStyioO8hNvrmZaNQQvz8i4/+4LuteNT/GDJYpqeH/U/ncqdhNpLkakg1GB
         UlRnzUzZ5fyj5obwZNaHQJfNAJhaxCP64lymsLn6g4DqNXvS8sVHa4vu28+27aOhk08F
         jXRg==
X-Gm-Message-State: ACrzQf0pPDtaC/F8XU6lQR3V4+d+9KU2hJQUDjgf7tLrYaUTTTnuAor+
        OmMm4lCPnFv31hp4Rv9EXtF4/UXXj9AkNfBXNYk=
X-Google-Smtp-Source: AMsMyM7SDS1ATRus/0DXpPT9jmtiHq5vYyneGCOi/QTRd9LYxZhDS646Lx5QGIDWAi0ATu6NdYoyVvd69raONqBSVZg=
X-Received: by 2002:a25:4fc1:0:b0:6bc:c570:f99e with SMTP id
 d184-20020a254fc1000000b006bcc570f99emr6934224ybb.58.1665957316408; Sun, 16
 Oct 2022 14:55:16 -0700 (PDT)
MIME-Version: 1.0
References: <20221016034127.330942-1-dmitry.fomichev@wdc.com> <20221016034127.330942-2-dmitry.fomichev@wdc.com>
In-Reply-To: <20221016034127.330942-2-dmitry.fomichev@wdc.com>
From:   Stefan Hajnoczi <stefanha@gmail.com>
Date:   Sun, 16 Oct 2022 17:55:04 -0400
Message-ID: <CAJSP0QX3BL=59zi70YsbFgZ1GxghQFvJqbBwaUHNR8RnVKnp4w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] virtio-blk: use a helper to handle request queuing errors
To:     Dmitry Fomichev <dmitry.fomichev@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Li <faithilikerun@gmail.com>,
        virtio-dev@lists.oasis-open.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, 15 Oct 2022 at 23:41, Dmitry Fomichev <dmitry.fomichev@wdc.com> wrote:
>
> Define a new helper function, virtblk_fail_to_queue(), to
> clean up the error handling code in virtio_queue_rq().
>
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> ---
>  drivers/block/virtio_blk.c | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
