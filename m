Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8343EB6FD
	for <lists+linux-block@lfdr.de>; Fri, 13 Aug 2021 16:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240878AbhHMOsS (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 13 Aug 2021 10:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240865AbhHMOsS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Aug 2021 10:48:18 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721AAC061756
        for <linux-block@vger.kernel.org>; Fri, 13 Aug 2021 07:47:51 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id c6so8439495qtv.5
        for <linux-block@vger.kernel.org>; Fri, 13 Aug 2021 07:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GKeWoaPop4bRlZkqIVTlOnU0AzdsWpY1hkmifxUqH2I=;
        b=dvY57rZ2ay1Ind9SwLjZSU42PXOjI0r+tpUwsZz5s7TTpe3/qLJ7KNp8v4W1KK0AZi
         4FKOMkJ7bNGjIVV/Vz7NLp29JBlReyIE+C6gzNj5Mzpc0ExzBxN8IFb/HR2spXDIf3hY
         qpz9o03LIh8XzAzqdKyf/Ux+XBasbk8bhehGGxbBxYy7Zj/gU3AcF2s7ovRSluHOXp3g
         MnBntFLDjAda5CDD9fesiPnAOboqgI/xndYoGLmZOEPTrEpJA6omGagl5PxAyPG9cbGI
         0WMjosoj2AkW02huUK9C6jD913EK2Q2Jkl6uBPxsiuEJiP7FLip3ubcnoP6ncuaqqabv
         vFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GKeWoaPop4bRlZkqIVTlOnU0AzdsWpY1hkmifxUqH2I=;
        b=ZJZUlAuhwD/WTD0WJ+g4TNEVk+SWQ9I65XaVi1A9bSZPDyBCGLrDUkfpDbWx3IIeeJ
         mBztYkPsXaqX/M3+/pQc8rlOhv76LetrVCPNz1TE1ur3o/v+dauvEfDeQMXdw3E6/S3B
         q5HcxPeyd8SOhhwjqTrTntXs+nzhfwlCnLZke/GdUhlz2yqTT3E0gEzvlrL5Vjh9YBLE
         2kavjmC0dGuCm7u1k0DZN+aoK7p8y/jitWhmjDtPLTTDo5aMbFYcTBW8pcJp4wnBzWCA
         oJ7ohTVwiTyJHiIU6VJoWgRoujKWxkEwPngnrLDI5uIJLLGkPuer3B0BB3YUIZJolWh/
         LXGA==
X-Gm-Message-State: AOAM532GGjpEr1JGh6j/ApB0f57OrlO8o34JhdoylxU5Y28Ml1StG06/
        2hSuxHI3+DsjYrhvBgHwlxccXw==
X-Google-Smtp-Source: ABdhPJw/nmqHv7Crg0W/3S8MPU6GEvlrTs7iRDpEiNoXDp/eIFbce7LQJ7K/MC+eETxw0gOSjEQmgQ==
X-Received: by 2002:ac8:5bd6:: with SMTP id b22mr2339286qtb.193.1628866070464;
        Fri, 13 Aug 2021 07:47:50 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d68sm1094444qke.19.2021.08.13.07.47.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 07:47:49 -0700 (PDT)
Subject: Re: nbd locking fixups
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        Hou Tao <houtao1@huawei.com>
References: <20210811124428.2368491-1-hch@lst.de>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <be8b98c3-0b39-7be7-4d9a-b1f5c2f0a54f@toxicpanda.com>
Date:   Fri, 13 Aug 2021 10:47:46 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210811124428.2368491-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/11/21 8:44 AM, Christoph Hellwig wrote:
> Hi Josef and Jens,
> 
> this series fixed the lock order reversal that is showing up with
> nbd lately.  The first patch contains the asynchronous deletion
> from Hou which is needed as a baseline.
> 

Other than the whitespace thing everything looks good, you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
