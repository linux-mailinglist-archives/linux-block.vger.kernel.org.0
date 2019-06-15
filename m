Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0CF046EC3
	for <lists+linux-block@lfdr.de>; Sat, 15 Jun 2019 09:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbfFOHky (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 15 Jun 2019 03:40:54 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56104 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfFOHky (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Jun 2019 03:40:54 -0400
Received: by mail-wm1-f68.google.com with SMTP id a15so4453918wmj.5
        for <linux-block@vger.kernel.org>; Sat, 15 Jun 2019 00:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HE16ahbAWAMVnpAglb6juluSX3qYrFAbnx3CahCk6VQ=;
        b=nW9xKDUf27Z5vqCprp67406EaM9VuIbn/g7Bb0n6hJp2DtnP2VdyeW/CykjoiUIXnp
         IaEJHKml9i7LhW8fU0EFeXDouMSO1GaBCz+F/TZpeMMow+IJ0kSI4fU2YXhwTkv+ywzu
         l6RIrSR/hQUdrsavgtpv6Vkfiob3ZDu+FTIis7gdxRgu0eo4bPazm8rsMlJRU0YfHSkA
         qn2gcjZQ5aEihmYxgFewuvc1IVEe2bfjIVtNJjefVYiqH/ZirIkrOcDMLKcVlPdrOSCk
         zVAIftuueYAkkkvJXWiuvzXIdRWKfO9NIXBgXw1XAmW7H2dL4633QncpIMFYSgsakzXj
         24YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HE16ahbAWAMVnpAglb6juluSX3qYrFAbnx3CahCk6VQ=;
        b=FXWtfoXeNBVEArGt0ufoNfhhQoi0oh8srZz+lbJpHf89H4sGBxKja2xFvtKR0cjKck
         j1T2T2zpIJ506Lf1XukJtsYo6RUe0QaCIncxaEm/aDIya9fDlWwhs46Yg25c1mWAet8l
         /H4DiG38zUgOG2DxrEz913fMu2Apftu+FYKWgGQlNq4ltMQLz8QABXBB2WagjoeHJw4K
         3cr1V9qvJkB/YDVGexn8xf1ZE8rE+d8/p8DvA83arTsFD/khch5/n9X7XyX5sn3X+XUx
         dUPxLyxcBaAPbrXK/tA0mbsZ5UShbu+FowndD4+kkRYsXQ1f8RZ9WuwZl9APo47vwzMu
         tzhQ==
X-Gm-Message-State: APjAAAUNYFwGHVsGmM3+vOu5TN31Va61nqu4WynbsRDGuIM7YF8raaph
        61eAaHpw+XBj6LVWy9IIEJcbkG0mM2JzmVDH
X-Google-Smtp-Source: APXvYqyGiEnRu/Q0XKZ13ZQa8cfXFCVeF4aYToCxoekgDTAhRDKtoIpUvGLTOKf0OMMtddfCOc0tDA==
X-Received: by 2002:a1c:c14b:: with SMTP id r72mr10707604wmf.166.1560584452580;
        Sat, 15 Jun 2019 00:40:52 -0700 (PDT)
Received: from [192.168.88.149] ([62.170.2.124])
        by smtp.gmail.com with ESMTPSA id l17sm8877075wrq.37.2019.06.15.00.40.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Jun 2019 00:40:51 -0700 (PDT)
Subject: Re: [PATCHSET block/for-linus] Assorted blkcg fixes
To:     Tejun Heo <tj@kernel.org>, jbacik@fb.com
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com, dennis@kernel.org, jack@suse.cz
References: <20190613223041.606735-1-tj@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5d5835d3-d0e4-f4cc-19b1-841b4ad46a9a@kernel.dk>
Date:   Sat, 15 Jun 2019 01:40:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190613223041.606735-1-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/13/19 4:30 PM, Tejun Heo wrote:
> Hello,
> 
> This patchset contains the following blkcg fixes.
> 
>   0001-blk-iolatency-clear-use_delay-when-io.latency-is-set.patch
>   0002-blkcg-update-blkcg_print_stat-to-handle-larger-outpu.patch
>   0003-blkcg-perpcu_ref-init-exit-should-be-done-from-blkg_.patch
>   0004-blkcg-blkcg_activate_policy-should-initialize-ancest.patch
>   0005-blkcg-writeback-dead-memcgs-shouldn-t-contribute-to-.patch
> 
> Please refer to each patch's description for details.  Patchset is
> also available in the following git branch.
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git review-blkcg-fixes
> 
> Thanks.  diffstat follows.

Are you fine with these hitting 5.3?

-- 
Jens Axboe

