Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E7F505F20
	for <lists+linux-block@lfdr.de>; Mon, 18 Apr 2022 23:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347909AbiDRVHE (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 18 Apr 2022 17:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347893AbiDRVHE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Apr 2022 17:07:04 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5786E2A700
        for <linux-block@vger.kernel.org>; Mon, 18 Apr 2022 14:04:23 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id x18so12064740wrc.0
        for <linux-block@vger.kernel.org>; Mon, 18 Apr 2022 14:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2xC56SbahR+A86XAZ1Xr5CheL4zTUR2Yl2PX5kgsh60=;
        b=jVefXpeaUqA2UhMsfdWRxwA6dVOS/OubaUhUbzQiNiw6Sh3TSAJzNrupAImg7ews6u
         ouky8CJKsd6yjdaomtrNrSxPMKZP+c97cnIiq7aCvfyOB3Zo2igqk7ZzmDrKYxU+tRSO
         KQDZwYpTzB/quuQMmvwf+tJfSs56zyhk/X1TmvSqzjrNzoiyiPuOgilveEhPfr6UrDik
         LMDrw2bn4aNZwLp0nSoYHc3bU6cNSlhsY/a960ueZeONiv4HRR+50dS6yF1nnlKXtx+h
         4Ahw7F5i6QXCSQxeJ7S+OQuPdWULZcgWYcHIbC+AL6xSQF993ov+8VTg+Ti7DdcevQrz
         WlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2xC56SbahR+A86XAZ1Xr5CheL4zTUR2Yl2PX5kgsh60=;
        b=zict+xg2uCwS5U/nov0V6pWgcUAQBhUnfPR4Zhri4MSHAxBs9+JCNsuxQa85d4vJgE
         Ji/eB6E9rB/LFkfOrPunCuh6TtSMMoAu1uPMQe4FZE67Cs1+xfP3FywE9hPAsnwAy/lk
         o2ZBFsgCdCFChbAuP/J3FLRV0Fc+7GUK5uj7VKt825ut3bbNELyRYCEFmjp6zw0lwF0C
         wmzH0vrfGexb1AdNBv4VI3n/v36mN5Tybna2mFgUX9QXuag6ixyiFvtCImd+R3f9aSeW
         yuAnSPv8DuZ9nfDxWsv2IRCNcwhKi8nMnOCYLRmDo4woivxV5OcGk0+LuKF7Umi3DDZ+
         2jAA==
X-Gm-Message-State: AOAM532iqwTZ81IWC4JHXbJScpi00aCEJV3ngXI4LbnOrvJM23vowbE0
        Fq3XGfFjrGCrD/x9XjsAUqAjYKBY+1nIaw==
X-Google-Smtp-Source: ABdhPJyEZlaRcGyCo1uMJOZOgoyGccFvv75S9XwuahzLFfjLlKLpcoWdx5eV5TRokdsECQsOSl9nyA==
X-Received: by 2002:a5d:47aa:0:b0:20a:8b96:5b2c with SMTP id 10-20020a5d47aa000000b0020a8b965b2cmr8152221wrb.621.1650315861737;
        Mon, 18 Apr 2022 14:04:21 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id n5-20020adf8b05000000b00207a4fd0185sm11234964wra.7.2022.04.18.14.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 14:04:21 -0700 (PDT)
Date:   Mon, 18 Apr 2022 22:04:18 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Jens Axboe <axboe@kernel.dk>, Enze Li <lienze@kylinos.cn>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] cdrom: do not print info list when there is no cdrom
 device
Message-ID: <Yl3SUr9+qzoRlQt8@equinox>
References: <20220408084221.1681592-1-lienze@kylinos.cn>
 <25390602-cfa0-dba3-bfbc-a35ed6b44bcf@kernel.dk>
 <20220409122530.60353fcd@asus>
 <YlFA7USiCtqsFvVD@equinox>
 <f74b6933-5357-6b2c-3127-7a3465dadbdf@kylinos.cn>
 <226c4072-a3ca-a5a4-1b7f-f7104b43af03@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <226c4072-a3ca-a5a4-1b7f-f7104b43af03@kernel.dk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 11, 2022 at 10:51:28AM -0600, Jens Axboe wrote:
> >   20  -- Modify sysctl/proc interface. I plan on having one directory per                 
> >   21  drive, with entries for outputing general drive information, and sysctl             
> >   22  based tunable parameters such as whether the tray should auto-close for             
> >   23  that drive. Suggestions (or patches) for this welcome!
> > ================================================
> > I'd like to know if the relevant patches are still welcome?
> > 
> > IIUC, the TODO List says that we need to implement a modification of the
> > following form:
> > ----------------------------------------------------------------------------------------------------------
> > $ tree /proc/sys/dev/cdrom
> > /proc/sys/dev/cdrom
> > |--sr0--autoclose
> > |       |-autoeject
> > |       |-check_media
> > |       |-debug
> > |       |-info
> > |       |-lock
> > |
> > |--sr1--autoclose
> > |       |-autoeject
> > |       |-check_media
> > |       |-debug
> > |       |-info
> > |       |-lock
> > |
> > |--sr2 ...
> > .
> > .
> > .
> > ----------------------------------------------------------------------------------------------------------
> > I would appreciate it if you could give me some advice.
> 
> Let's not do that, this advice is perhaps 20 years old. /proc isn't to
> be used for anything like that these days.
> 
> -- 
> Jens Axboe
>

Hi Both,

I will send a patch alongside others during the next merge window to
remove this TODO section for now. It was part of the initial mainline
git commit (17 years and two days ago), so it (as Jens says) is almost
certainly even older than this.

Regards,
Phil
