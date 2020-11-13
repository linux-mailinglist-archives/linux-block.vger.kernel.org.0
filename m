Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597082B24EA
	for <lists+linux-block@lfdr.de>; Fri, 13 Nov 2020 20:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgKMTvn (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 13 Nov 2020 14:51:43 -0500
Received: from mail-pf1-f174.google.com ([209.85.210.174]:38057 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgKMTvm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Nov 2020 14:51:42 -0500
Received: by mail-pf1-f174.google.com with SMTP id 10so8515793pfp.5
        for <linux-block@vger.kernel.org>; Fri, 13 Nov 2020 11:51:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z9pGEkj70nEKEwfjp7zFjPNGys2FUAc3jAew6tdMSnc=;
        b=JtXfq9QT3w9FqtDkLfnXm9nt2vWzHHK8ZahQmcTjvRebNWIPlznQmOd91NOzgsbggs
         41Aho1X8corsH91I266c+n+XP4et55umEs5H1H0hMEFJkDleU0EjSHhc+4GCwBV6lloe
         LrcV0qXLHxwFIfXLPg3MQH++B0B9Tl+PeICcKUUrkYQv3bLfSM04HKCGMmdtKILHdyi3
         oVFg+eT/GTR+V7W0S7moXYezNhsTwJKgbYyZ+vUkcMehAUhKOGOOHdu1ybn2x7Jdap6s
         TF5QDCVoqFOurMaS0loCQExHmv40NQLcZW/YqAl6ntbGqZ1ROUDbuIMPrFOiXfqL+vTv
         aR1A==
X-Gm-Message-State: AOAM532iHQIzKvUaQkQCAJOtfBpiZa/xoEBxcz+tmCMBowFp0QPYHIu/
        g/V0j1xoG4FnmuI4EhID+KGP7mdzfJw=
X-Google-Smtp-Source: ABdhPJz74Wi+m3m+kNHdHODbHGWQ0qIYMhXiB+BYT1DLmI3XCH9ivvEhFiRVE6csXrDEPddqtlswmA==
X-Received: by 2002:a17:90a:9385:: with SMTP id q5mr4706343pjo.20.1605297100573;
        Fri, 13 Nov 2020 11:51:40 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:be97:ffd:339d:919c? ([2601:647:4802:9070:be97:ffd:339d:919c])
        by smtp.gmail.com with ESMTPSA id m20sm10032302pfk.31.2020.11.13.11.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 11:51:39 -0800 (PST)
Subject: Re: split hard read-only vs read-only policy
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Oleksii Kurochko <olkuroch@cisco.com>,
        linux-block@vger.kernel.org
References: <20201113084702.4164912-1-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4f8190a8-55a3-bc2d-540f-75e666810dd4@grimberg.me>
Date:   Fri, 13 Nov 2020 11:51:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201113084702.4164912-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> Hi Jens,
> 
> this series resurrects a patch from Martin to properly split the flag
> indicating a disk has been set read-only by the hardware vs the userspace
> policy set through the BLKROSET ioctl.
> 

Looks good,

Doesn't this miss restoring the clear disk ro in nvme?
