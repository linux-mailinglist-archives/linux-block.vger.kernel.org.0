Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B902FE05D
	for <lists+linux-block@lfdr.de>; Thu, 21 Jan 2021 05:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbhAUEGJ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 20 Jan 2021 23:06:09 -0500
Received: from mail-pf1-f181.google.com ([209.85.210.181]:36086 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728355AbhAUECU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Jan 2021 23:02:20 -0500
Received: by mail-pf1-f181.google.com with SMTP id u67so733476pfb.3
        for <linux-block@vger.kernel.org>; Wed, 20 Jan 2021 20:02:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uTp2j6G89CmPIu06qz2rlqD+VYHfX7FYa+fdLR60qCk=;
        b=V+C+Nc7M6YYxMG76FChZ9rSK+uM26Wim/dZMidB1U2SqN6bNa2ZHryQfecJy2g7XR8
         bkeeq/iFxhZNYmC6jcI19CgKkO0gQ/b0cpvzCrSpn5akNqAlywdvjzKrZAyLlbZdqP27
         nltU28kJE/zWAxrzXaemv6VGVNdfEGhRreHFMkkpZmN9F9NnSztq2xTosu/7rNPKWlrN
         UdS0CWp2/1sDFMUy0ih5PzSJsiKJst20OYywc+vOpgsuu9Sh3K9+VwFnUg1vVV++RiYN
         /MiUueF9/rIHetF/8tgDBDPa+/g7wKiyS+UcJNroq/kL0Ur72CnC8ieZHENJlZUppOqD
         jk6g==
X-Gm-Message-State: AOAM530kWfyMMbiKBlwSTw6QYD3bWQB+tq7X9o1XdxRgTBy6ldAxSii/
        rJRU4O8j3WLoWWkbl/ZmTwi32Ux2GXo=
X-Google-Smtp-Source: ABdhPJwLFmzCL6R5l35z7qWS8RpqUfxPPKp3PORGhw2bu8qxe76nkYkJeWr7D6ssIcWt0tVd7uOKaA==
X-Received: by 2002:a62:8c8d:0:b029:1bb:b6de:c872 with SMTP id m135-20020a628c8d0000b02901bbb6dec872mr3058679pfd.68.1611201694756;
        Wed, 20 Jan 2021 20:01:34 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:b5ed:474a:81d5:2e31? ([2601:647:4000:d7:b5ed:474a:81d5:2e31])
        by smtp.gmail.com with ESMTPSA id f3sm3834947pfg.120.2021.01.20.20.01.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 20:01:33 -0800 (PST)
Subject: Re: [PATCH blktests] common/multipath-over-rdma: update
 is_rdma_device
To:     Yi Zhang <yi.zhang@redhat.com>, osandov@osandov.com
Cc:     linux-block@vger.kernel.org
References: <20210120231839.10267-1-yi.zhang@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <6e473106-713b-d1bd-bc76-3d36eb835e1f@acm.org>
Date:   Wed, 20 Jan 2021 20:01:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210120231839.10267-1-yi.zhang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/20/21 3:18 PM, Yi Zhang wrote:
> Below patch make the siw/rxe device virtual in the device tree, update
> is_rdma_device to match it.
> a9d2e9ae953f RDMA/siw,rxe: Make emulated devices virtual in the device tree
> 
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
> ---
>  common/multipath-over-rdma | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
> index 355b169..e4269f6 100644
> --- a/common/multipath-over-rdma
> +++ b/common/multipath-over-rdma
> @@ -79,17 +79,24 @@ is_number() {
>  # Check whether a device is an RDMA device. An example argument:
>  # /sys/devices/pci0000:00/0000:00:03.0/0000:04:00.0
>  is_rdma_device() {
> -	local d i inode1 inode2
> +	local d i f inode1 inode2
>  
> -	inode1=$(stat -c %i "$1")
> -	# echo "inode1 = $inode1"
> +	f=$1
> +	inode1=$(stat -c %i "$f")
>  	for i in /sys/class/infiniband/*; do
>  		d=/sys/class/infiniband/"$(readlink "$i")"
> -		d=$(dirname "$(dirname "$d")")
> -		inode2=$(stat -c %i "$d")
> -		# echo "inode2 = $inode2"
> -		if [ "$inode1" = "$inode2" ]; then
> -			return
> +		if [[ "$d" == *"virtual"* ]]; then
> +			if [[ -e "$d/parent" && "${f%%/*}" == "$(<"$d"/parent)" ]] || \
> +				   [[ "${f%%/*}_siw" == "$(basename "$d")" ]]; then
> +				return
> +			fi
> +		else
> +			d1=$(dirname "$(dirname "$d")")
> +			inode2=$(stat -c %i "$d1")
> +			# echo "inode2 = $inode2"
> +			if [ "$inode1" = "$inode2" ]; then
> +				return
> +			fi
>  		fi
>  	done
>  	false

Jason Gunthorpe, the RDMA maintainer, asked some time ago to use rdma
link instead of inspecting /sys/class/infiniband to query rdma_rxe / siw
instance properties. Please take a look at the blktests patch that I
just posted and on which I cc-ed you.

Thanks,

Bart.


