Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5547C32FC71
	for <lists+linux-block@lfdr.de>; Sat,  6 Mar 2021 19:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhCFSOp (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 6 Mar 2021 13:14:45 -0500
Received: from mail-pj1-f53.google.com ([209.85.216.53]:53873 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbhCFSOO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 6 Mar 2021 13:14:14 -0500
Received: by mail-pj1-f53.google.com with SMTP id kx1so940189pjb.3
        for <linux-block@vger.kernel.org>; Sat, 06 Mar 2021 10:14:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U/ZoK/tUq/JgmAu0oNs1A9BNLreQXeCnX1mXZkvwutk=;
        b=eRvlums9GSfxqBjN6/o6M37XhtjYdse5gLWJffOLqnbIiWxklGeFprL70+gzY5HsnI
         b/N0zdg6B+MjzqwGdZIff6mGJ8/kA98Yh1NXUHGo0Za1ro7UYcyQjsC5grZaU9z4oAAn
         7deSlryKI/PI6Gu2YUUBd1gSDW8vAAGRzXjHNekpTsp5doFE3tGNZQbcn02XLO6/8FZK
         eJUu5K5kHhLAAmTNgznKu1PrDZDghJJapX+NBS6tFkumcaYmbBcygzVn1DWPW5Rdo7Ob
         bfnS8e+/zd/+Wu0iNfTLdNlCnOUkvXBLT1OoYGgeLst9N5NMY0yb3zotzde+bqve5cMa
         miXQ==
X-Gm-Message-State: AOAM531Um5F/2qu+Y0/CMDwO4/AhzVbP/Osoaujv/Jj5S5ooaJaodWCG
        PlcIIkCIQbFqW3mOPShu371v2MD+d4g=
X-Google-Smtp-Source: ABdhPJyN5YP9Q+T+u8ZVmmDCm4ZG3SqqZtM2V7F4Q9Eh+TK/F6F7Onig9OpKZC4pAg5gcIa5td8MEA==
X-Received: by 2002:a17:90a:c201:: with SMTP id e1mr16363003pjt.30.1615054453908;
        Sat, 06 Mar 2021 10:14:13 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:9183:7829:b654:e538? ([2601:647:4000:d7:9183:7829:b654:e538])
        by smtp.gmail.com with ESMTPSA id q128sm5844977pfb.51.2021.03.06.10.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Mar 2021 10:14:13 -0800 (PST)
Subject: Re: [PATCH blktests] tests/srp/rc, tests/nvmeof-mp/rc: add fio check
 to group_requires
To:     Yi Zhang <yi.zhang@redhat.com>, osandov@fb.com
Cc:     linux-block@vger.kernel.org
References: <20210306071943.31194-1-yi.zhang@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <7b0ec432-07e4-7f08-dd66-06e0bfd3ae56@acm.org>
Date:   Sat, 6 Mar 2021 10:14:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210306071943.31194-1-yi.zhang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/5/21 11:19 PM, Yi Zhang wrote:
> Most of the srp and nvmeof-mp tests need fio, we need add fio
> check before running the tests
> 
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
> ---
>  tests/nvmeof-mp/rc | 2 +-
>  tests/srp/rc       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/nvmeof-mp/rc b/tests/nvmeof-mp/rc
> index ab7770f..4348b16 100755
> --- a/tests/nvmeof-mp/rc
> +++ b/tests/nvmeof-mp/rc
> @@ -42,7 +42,7 @@ and multipathing has been enabled in the nvme_core kernel module"
>  	)
>  	_have_modules "${required_modules[@]}" || return
>  
> -	for p in mkfs.ext4 mkfs.xfs multipath multipathd pidof; do
> +	for p in mkfs.ext4 mkfs.xfs multipath multipathd pidof fio; do
>  		_have_program "$p" || return
>  	done
>  
> diff --git a/tests/srp/rc b/tests/srp/rc
> index 700cd71..2daf199 100755
> --- a/tests/srp/rc
> +++ b/tests/srp/rc
> @@ -59,7 +59,7 @@ group_requires() {
>  	)
>  	_have_modules "${required_modules[@]}" || return
>  
> -	for p in mkfs.ext4 mkfs.xfs multipath multipathd pidof sg_reset; do
> +	for p in mkfs.ext4 mkfs.xfs multipath multipathd pidof sg_reset fio; do
>  		_have_program "$p" || return
>  	done

This patch looks good to me but unfortunately it conflicts with my patch
with title "[PATCH blktests v2] rdma: Use rdma link instead of
/sys/class/infiniband/*/parent" ...

Bart.
