Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E721718FA87
	for <lists+linux-block@lfdr.de>; Mon, 23 Mar 2020 17:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbgCWQzf (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 23 Mar 2020 12:55:35 -0400
Received: from mail-pj1-f44.google.com ([209.85.216.44]:52659 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727578AbgCWQzf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Mar 2020 12:55:35 -0400
Received: by mail-pj1-f44.google.com with SMTP id ng8so97692pjb.2
        for <linux-block@vger.kernel.org>; Mon, 23 Mar 2020 09:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mFFLdkROuGzrX7CaN7iaKQtgyU9352EW9LOMMGLduh0=;
        b=xvQuDWUK4rppNtIXMkhgKlBEq7tXEVsdIK0ASlHSgXnCp63TynMj/BSxfgxNatZGE4
         hqYSR8fD0EMOESlN7IaxTzPFTksKxokG9SR+skwxywHSZSuczsAAnV9ob47XTgd++pDm
         /JyN115oAoDDmdme+LwUAy8/etuWG2uvIhXxt0qK5D2VurNIC1XZnoQK0+5wSwb3gOP8
         BIyoMiadjG/BKoMmdzCTbOQdSx7xXyZDkopdjvsZTf6tGlMmaG3meWzY3ERya7eDqkZ2
         6hpCIcQ+yWWyT/Zh6uGtaxTy5Sgqvt6gbv+s4gHCHIwqwfKkt5O5oucDfb3CwmEvrMJP
         DPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mFFLdkROuGzrX7CaN7iaKQtgyU9352EW9LOMMGLduh0=;
        b=fNRdxccN/g1fRdVq5Cf0d8Q7uLBrJwIxdolBGkUew0oiPvwTgY8REsUhnjOIiUnRUR
         TIsQKijBP5ZkLMsOLWofDVCYRCI/yvk6hpim2qaa31oz+UJaH1zEWN2uoQDJSKfBZ/aU
         uTDUV7P+JQEz8I0hSKC+YgXnNY3fZgUBxNBqDsLYqT97TJq4pgCKEXkg5Edrgf7snQjT
         9tUk7wP7rgE3YpfnrAOtMilWo22VqnFPklgoNNe0EpF/7c4TljnIvp5tPGErWI3nw4Hc
         c0TB2IBeoECWIJRhq9qxq7n6HqMShClNhDrKDoWzEfyL1ZxiQ3apbPl6dYI8ICk1uxUP
         c/AQ==
X-Gm-Message-State: ANhLgQ3JGrpVRUmtc3HxqBs1VbaQMfvGKN0uVZr5aHUT3K+bRi6mOG8r
        eApdznE3AQf/0f6ebdbpKgsP/XgpNpByAQ==
X-Google-Smtp-Source: ADFU+vuYepzjMGiCUsHvUENLWjzFpios4va2+xolhoUb5eHRh6FDeKvuNbWj1Ly2VgD2e/ww5OX2lQ==
X-Received: by 2002:a17:902:a603:: with SMTP id u3mr17911749plq.105.1584982532060;
        Mon, 23 Mar 2020 09:55:32 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id nu13sm112828pjb.22.2020.03.23.09.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 09:55:31 -0700 (PDT)
Subject: Re: cleanup the partitioning code
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-ext4@vger.kernel.org,
        reiserfs-devel@vger.kernel.org
References: <20200312151939.645254-1-hch@lst.de>
 <20200323165234.GA29925@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7b7eb188-441a-b503-d526-f5bc029891fc@kernel.dk>
Date:   Mon, 23 Mar 2020 10:55:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200323165234.GA29925@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/23/20 10:52 AM, Christoph Hellwig wrote:
> ping?
> 
> On Thu, Mar 12, 2020 at 04:19:18PM +0100, Christoph Hellwig wrote:
>> Hi Jens,
>>
>> this series cleans up the partitioning code.
> ---end quoted text---

I did take a look, looks fine to me. Doesn't apply to the 5.7/block
branch though, I'll take a look in a bit, probably an easy reject.

-- 
Jens Axboe

