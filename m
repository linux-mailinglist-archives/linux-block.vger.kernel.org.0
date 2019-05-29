Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E92312DED2
	for <lists+linux-block@lfdr.de>; Wed, 29 May 2019 15:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfE2Nsk (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 29 May 2019 09:48:40 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46003 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbfE2Nsk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 May 2019 09:48:40 -0400
Received: by mail-qt1-f193.google.com with SMTP id t1so2572170qtc.12
        for <linux-block@vger.kernel.org>; Wed, 29 May 2019 06:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kAl0wzx3emq5wKGOIuk8klmmZ+hHoJ5g1tlBkCfT5tg=;
        b=R4r88s0eXEjfS9YMRowWrNd+cRCiduJQO1pvRiepcZuGWy/3m1B73VBAJP76M8dDVB
         +v9gwTpAzUVAqXDbZclLpm02dIpdmExYPVXnq1hUftt/EIiJhRgFVNtrC1XaRzA8EnG/
         IEmOQT3c2kzYINeyJ63Hk6ScLWmlJrbuLbWSvS5Q8XQ1SnHc0cMRtTt3izItgrZS4IXY
         7phNGHC2gk6us8ZnGmeQgyCNY2HhrqwXScKEUu95Y1cE7j5v7pYDBSdZ9SvppTEDPJe6
         tB7cctT7bMqLI/7A15dqStcWlHbJKvBBco0e6b0q+rpcK/vofMClsCyrZv7vhwKnods/
         A7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kAl0wzx3emq5wKGOIuk8klmmZ+hHoJ5g1tlBkCfT5tg=;
        b=I0yHv7cKDNET4ZeLezJrG/bU3GxQwCFTCWk3IRyoPBLanzSogqBA6h5D8zvwMNXKsV
         0cfxcBpN/zQx+L5xDwBTB/wv4MPRMnrykCyYO7WPObA01ZHiqbfh3FUawkRoolSatk0w
         JSYH5utqPkAFttfcFptwzw9/W1vlJQuTnsId3PTot4ac+CBWcIoNNZIsCsVu29a5Qw/Y
         LsuOdDex7Ueaj/MlqCyKEuFPx9JEGiXIt58h9ND6NcNcKig//RfaQrwVor6Zjw9lbiSo
         9cJ8c4ZujxbOvTxYXoeROw1wJKwTD5MCVk4+i6LN06k6wZOXPNXom4uUsGF0dQN65HTa
         +Ndw==
X-Gm-Message-State: APjAAAXg4hn3RUIfpvr8DbmkO/65CVsRGYcqIeUHVXiPpctf2qxM4BFS
        pwMMr8MTQFB4p9sYI2knfGYUZ14AecsOsw==
X-Google-Smtp-Source: APXvYqyB5eTIW4f7w0P+quiFs0g3fOGgLPjkmAr1nafYPMij/uj1upXVI9fk2rxr9TJcYXzskqXWew==
X-Received: by 2002:a0c:8042:: with SMTP id 60mr30581196qva.238.1559137718918;
        Wed, 29 May 2019 06:48:38 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::d8f])
        by smtp.gmail.com with ESMTPSA id c5sm1276114qtj.27.2019.05.29.06.48.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 06:48:37 -0700 (PDT)
Date:   Wed, 29 May 2019 09:48:36 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     xiubli@redhat.com
Cc:     josef@toxicpanda.com, axboe@kernel.dk, nbd@other.debian.org,
        mchristi@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, atumball@redhat.com
Subject: Re: [RFC PATCH] nbd: set the default nbds_max to 0
Message-ID: <20190529134834.t6qjq2nkut37zpsf@MacBook-Pro-91.local>
References: <20190529080836.13031-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529080836.13031-1-xiubli@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 29, 2019 at 04:08:36PM +0800, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
> 
> There is one problem that when trying to check the nbd device
> NBD_CMD_STATUS and at the same time insert the nbd.ko module,
> we can randomly get some of the 16 /dev/nbd{0~15} are connected,
> but they are not. This is because that the udev service in user
> space will try to open /dev/nbd{0~15} devices to do some sanity
> check when they are added in "__init nbd_init()" and then close
> it asynchronousely.
> 
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
> 
> Not sure whether this patch make sense here, coz this issue can be
> avoided by setting the "nbds_max=0" when inserting the nbd.ko modules.
> 

Yeah I'd rather not make this the default, as of right now most people still
probably use the old method of configuration and it may surprise them to
suddenly have to do nbds_max=16 to make their stuff work.  Thanks,

Josef
