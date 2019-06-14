Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E59E345F49
	for <lists+linux-block@lfdr.de>; Fri, 14 Jun 2019 15:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfFNNsa (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 14 Jun 2019 09:48:30 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37008 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728962AbfFNNs3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jun 2019 09:48:29 -0400
Received: by mail-qk1-f196.google.com with SMTP id d15so1689628qkl.4
        for <linux-block@vger.kernel.org>; Fri, 14 Jun 2019 06:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rnGRxFxOoVoCJlpWf5YwCxAGlT+Sc1FUpYO8QlgwSjM=;
        b=w85yzapM6oQuLGvkrulj+iPAX76vQ9VdYBXRlGt9Hf8SiFTFl+1a7viss9jINwRpsN
         J9A+qVYyXcJ/tZhZ1RHj2aYpCaxlLR392Juyc6Gs6KJhXgkQaA1uUOCVvAbN950OW5kZ
         5d06dcracY0f2RCO7wti/DHByanIMsFUvNA/XzJzZ5+809Sqozt5M+rggEn7q5tTFqrb
         uE6JF6wincuKAPQ5HPmSmcSA4N5Y/Zn5eZeAaLgbC6iiZZ+P0hqEbE9zaNirjH0Hv9v1
         P9CAJkt+sqvxlR0u9VjU5FNAuaN7P/kDv1YkpAyYd4cRVdBXcV3T+G3nFkGRy/elTMOr
         OMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rnGRxFxOoVoCJlpWf5YwCxAGlT+Sc1FUpYO8QlgwSjM=;
        b=KItlp1QuN26d7vRreRLvJDv5FD0Egv2aAmG4lYBAqN1iHTE6hCsdseBXzE89NRxYc/
         rl3tu5jcLS1vPqD8ZDHziTPba2Sm4rs0G+2TliBqEHon9JGefZyYItetg35r+IjP6wxP
         vJanq5odulmxLh44aV7BPC6k3Dylgyipj6fQy+8RiBuFHbGFcs10vLnUIaQouJwISEX2
         zHybhr/OZ/UIbbfYRHNaN30SGbn/TYMKgpdP89ZOHe7DqUfYwaRjFdZ628VaBfkyOalT
         CgL6p6+8dMv1ABbDbORnA6i9LXfimGKooyIyKaCWMsvDbeY2Rc/ktqk3lNMa4wLQfJSd
         su3Q==
X-Gm-Message-State: APjAAAX37HMZ8fjsHtnRzq9/R6YBG1WdYvbz+xY/aOupPjR9+arhuGpM
        wgHZ2JeCec8cTE4yckxJYnm7YA==
X-Google-Smtp-Source: APXvYqwsR8RvRpY6ld/gvqnd2sdXs0I92KrB7t3+rTb1qpbvIeD3KNowVm1Bjsyu4kJI09jR3h7lCQ==
X-Received: by 2002:a37:e30b:: with SMTP id y11mr57978829qki.100.1560520108439;
        Fri, 14 Jun 2019 06:48:28 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::a658])
        by smtp.gmail.com with ESMTPSA id w189sm1341749qkc.38.2019.06.14.06.48.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 06:48:27 -0700 (PDT)
Date:   Fri, 14 Jun 2019 09:48:26 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     dsterba@suse.com, clm@fb.com, josef@toxicpanda.com,
        axboe@kernel.dk, jack@suse.cz, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 5/8] Btrfs: delete the entire async bio submission
 framework
Message-ID: <20190614134825.ew3d2hfyczolylr6@MacBook-Pro-91.local>
References: <20190614003350.1178444-1-tj@kernel.org>
 <20190614003350.1178444-6-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614003350.1178444-6-tj@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 13, 2019 at 05:33:47PM -0700, Tejun Heo wrote:
> From: Chris Mason <clm@fb.com>
> 
> Now that we're not using btrfs_schedule_bio() anymore, delete all the
> code that supported it.
> 
> Signed-off-by: Chris Mason <clm@fb.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
