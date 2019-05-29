Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34C5E2DED8
	for <lists+linux-block@lfdr.de>; Wed, 29 May 2019 15:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfE2NuX (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 29 May 2019 09:50:23 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43143 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfE2NuX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 May 2019 09:50:23 -0400
Received: by mail-qt1-f195.google.com with SMTP id z24so2581196qtj.10
        for <linux-block@vger.kernel.org>; Wed, 29 May 2019 06:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YZ+pg8aR5qtYQVgChplcfMUX8pIrRvMgQQ9ehzYO2NY=;
        b=Gv0ccnGUxwVA4CTo/MYZhnLEFa+NMtfNA1dXp7D65wkDSPkL7/+ggsF0C/UDeGkJGC
         gVMx9cP8UCjFB82NPeXC1HyYatRf7zEYiMfEd90UB8H6ubBRiYwnOVjyjfxrmFB64EJS
         459UY3oBceABLZ7+b1T19Ucuh58Xu2owPXLhWWP6WrdovjznYkXFl/EKJKNXoPu/OYeV
         6PjCnVolGMPeGhOdaTq/q1Yyfy+stN9uS68Ti3umLmlPH/SeYdHT+3J09kv+fqDOcipY
         REDPY83if8k2P3r22QjZc0VBnbYLOIdhe5OWvzlpzcqPMuBR/WYmypooktiqqy3WDP9o
         7wFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YZ+pg8aR5qtYQVgChplcfMUX8pIrRvMgQQ9ehzYO2NY=;
        b=Pu79e4KcTbhqN2J/EikkvZ/LkjVFe6ZzmcB3qYWOxlyE1+n38fsCiDK3bhk0ad6uNG
         rfgr8dg4xxQ/+dj7xwUa9BHw6ypkdlbqFKYUgnr5JKvKhsb76NVRFvQ8Kwr81bCbqM7H
         PmxH+62F8w6rB5nECrf2jsBP/d2wcPcteBLVjhXIfMzcSAGwldWHVhTXtS9WnuYijeMH
         EhyqgTY4qBxPgX5YPOLS2dkJR1BRAbO6v92GvCJnpQHg23uAg7+58liJ62AiFR6lJiDx
         kL4elWZyrg96AeLHAV1Ir/hc13TxsyNIXCj0sGh+QCP9k3xcEQU8a1sjUvkDaHOoP4oB
         NdAw==
X-Gm-Message-State: APjAAAU+2AcWtvXQCmQ/2JlIIMWiRc8YnBMekFTEr/bNfuQxp9XPbzdu
        jsuGswOeJ4lOj5cLI/KbU6symA==
X-Google-Smtp-Source: APXvYqwEtNwAR1RkkEX4AEuf9rsrRVXIcPejqHjeKH7c+7L9tPPaz3vt4LvVFSsUtK81/8sbDa/Pfw==
X-Received: by 2002:a0c:d13a:: with SMTP id a55mr58174644qvh.111.1559137821888;
        Wed, 29 May 2019 06:50:21 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::d8f])
        by smtp.gmail.com with ESMTPSA id n26sm739941qtn.36.2019.05.29.06.50.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 06:50:20 -0700 (PDT)
Date:   Wed, 29 May 2019 09:50:19 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     xiubli@redhat.com
Cc:     josef@toxicpanda.com, axboe@kernel.dk, nbd@other.debian.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        atumball@redhat.com
Subject: Re: [PATCH] nbd: fix crash when the blksize is zero
Message-ID: <20190529135018.6vbhxkuyppctqtco@MacBook-Pro-91.local>
References: <20190527054438.13548-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527054438.13548-1-xiubli@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 27, 2019 at 01:44:38PM +0800, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
> 
> This will allow the blksize to be set zero and then use 1024 as
> default.
> 
> Signed-off-by: Xiubo Li <xiubli@redhat.com>

Hmm sorry I missed this somehow

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
