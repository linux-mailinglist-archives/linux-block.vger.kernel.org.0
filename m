Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 628912CDF70
	for <lists+linux-block@lfdr.de>; Thu,  3 Dec 2020 21:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731159AbgLCULP (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 3 Dec 2020 15:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgLCULP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Dec 2020 15:11:15 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C26C061A51;
        Thu,  3 Dec 2020 12:10:34 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id 7so2344228qtp.1;
        Thu, 03 Dec 2020 12:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a8LN6ZMh1M/sLnx8l9ItuSsvA2D1+o6tHt6Iazu8FfA=;
        b=rUp0RIpFxoOqkerAos2b7fp4fx7spJxR2vrln5oymif4lHM6wneaeighEfc92OKNit
         mGm7m6Fkl8QHrDxm+oORk4JJAZfcJas4lNV+vkWoHQ0XHfPkjxi/dPTqVs4XXRwdbz3t
         XTb8ACbH1SMvEkR4FFgI02U4EdTKYpDEy0G8JPzqmM2iTDrQdwbnvzTfBZizezeFi/Ri
         XANJDXhl0AJmczxIQZ2Ysgu9FUIeKJbgPun+swnio5rRRjjV8sLWks/sjnQNTlvzUUO5
         BMx/POALgnGyQXPKj02oWA2NX9t3QL1NGHG2sL/JOSXrYGySjUXZG7qHTYJJnCGAEIhc
         RkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=a8LN6ZMh1M/sLnx8l9ItuSsvA2D1+o6tHt6Iazu8FfA=;
        b=f5YAkEVJd1DxQ/NIFXTLnUuiMmI9/vPyDlsL5U+mj0w3orbfiaNKjd3S+BAx83XPdG
         IHfcmAg5d+p3cEXwazzWI+GkaJ7UtcNyGgL2pNaC1Wwcc4TSh7ynzWcILemSacNMVl8t
         poKdrpBZSXdrDHu9HtnKgtD2VfrVYycjwI4wD2EVjYVTPDjDzQHOw3QWHZ6WQ9D6xCS3
         YGR6ich82xJ5/J1waEihR72Raxrqd/KIg0DzLxA5IXiSw4n/fXhYW+M5MlDheV42fbuF
         FgSBXN4uoNebhvKjgAqFjFzEMN3dfVNExRPRbD+ViWufviOYB87bLBxv9PDk+HV4El/Y
         gp/g==
X-Gm-Message-State: AOAM530VBEaBlPC21iWeB86xjMO5wwxEQKBT30x1oErD17NpJLlKQlDZ
        jp9+bVy2QHMHACOSnrH+s7aS/14e2S9y5Q==
X-Google-Smtp-Source: ABdhPJzqV5axT2LpRD7VrsKOBiSHz4rEGBYx02OU7G8vHf12Od6N8kKCv6sRz1NJS75gA4WM1kHwOw==
X-Received: by 2002:ac8:5741:: with SMTP id 1mr5012184qtx.294.1607026233859;
        Thu, 03 Dec 2020 12:10:33 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:6aeb])
        by smtp.gmail.com with ESMTPSA id z20sm2507477qtb.31.2020.12.03.12.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 12:10:33 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 3 Dec 2020 15:10:06 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-s390@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 5/5] block: remove the request_queue to argument request
 based tracepoints
Message-ID: <X8lGHsA/qnypPrTN@mtj.duckdns.org>
References: <20201203162139.2110977-1-hch@lst.de>
 <20201203162139.2110977-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203162139.2110977-6-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 03, 2020 at 05:21:39PM +0100, Christoph Hellwig wrote:
> The request_queue can trivially be derived from the request.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks!

-- 
tejun
