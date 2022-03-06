Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67C54CED09
	for <lists+linux-block@lfdr.de>; Sun,  6 Mar 2022 19:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbiCFSHI (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 6 Mar 2022 13:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbiCFSHI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 6 Mar 2022 13:07:08 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D371574B1
        for <linux-block@vger.kernel.org>; Sun,  6 Mar 2022 10:06:15 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 6so7208463pgg.0
        for <linux-block@vger.kernel.org>; Sun, 06 Mar 2022 10:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3IDySe6/HojQ3jDxfjpKc6zpBwkz5pfcZNFnpj0OwBo=;
        b=ECZvhaTcTYSYuxNQf0dXjupv9p+mdfcNTTw6ViBX4xP0zeXJMhvpwIQK9qTWRQKsVD
         SQtDRh+omkTij3RdK9ud99NHyowBI2gvl+kctfY8m9J7D3ThNlQNDH+yPjn/dzgq2HXm
         2JTWmnVhMWChL+QJMuKarlAx+hNcxWxldBAieo0PZnSkx1O1pSIizg87Z3lyOVDTTuug
         KnXayEwHBgey7lOMeKpKoB9emHN2YgUdy7f3A033WZdOK6lEDPzdtuAFqwcQtULwuojV
         63zGCRF1wVcH1aP3PvwIGNKv5PX7kI8fxhX2v/p71xw3jOuV10Biivx8AejciDrjQqf4
         MiGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3IDySe6/HojQ3jDxfjpKc6zpBwkz5pfcZNFnpj0OwBo=;
        b=AQZ9x/gG8KrgVwO72IVFJWX000KwqscUhhSaiekXtVE16Nqlfv/F/TVkxvjdRhrVP0
         C0vp6JPp65wGrRyQV8wmIRorjIrLV0bFAxXNv4js27N2enEtsEebkKu0r5VMBL0XvGNq
         23Tiz3ReLeb55tDNHvHtu9F1yEq3KI2ve8/laRkLsArGxjIsPNx47oPYooMOK3pkrLFc
         goJrRM5c1P1KAZoHkclSVRRDBIAjdkGHIcwKOirY9S5dWW4zRdWxTtBrm4Ss/tShE5LS
         e6VYuJ54IYfc6pQc9DnTGiKgMMP//RdXcRUqNJUTOotCIRPxAf0cREjjCqXkB5dh7+Mn
         gOSA==
X-Gm-Message-State: AOAM530e94/+OVRs1ew3aYwZ3PpH4xBPZiVz/BWoVgr1uZODaKwnA5ER
        5Uu8zSLjwgDgc5A/vs62R5d3vw==
X-Google-Smtp-Source: ABdhPJzZKQnoFchQw6tzr1OIIZ1uDCy2Ywxdu5LxhrSM3BjvQrLV0Y79FSWzFuuduKBiryJFzTjlfw==
X-Received: by 2002:a63:d74f:0:b0:374:5bda:909d with SMTP id w15-20020a63d74f000000b003745bda909dmr6973383pgi.215.1646589974835;
        Sun, 06 Mar 2022 10:06:14 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b16-20020a056a00115000b004f6ff260c9esm931995pfm.207.2022.03.06.10.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Mar 2022 10:06:14 -0800 (PST)
Message-ID: <f08db783-a665-2df6-5d8e-597aacd1e687@kernel.dk>
Date:   Sun, 6 Mar 2022 11:06:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 2/2] block: remove the per-bio/request write hint
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dave Chinner <david@fromorbit.com>, sagi@grimberg.me,
        kbusch@kernel.org, song@kernel.org, linux-block@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
References: <20220304175556.407719-1-hch@lst.de>
 <20220304175556.407719-2-hch@lst.de>
 <20220304221255.GL3927073@dread.disaster.area>
 <20220305051929.GA24696@lst.de>
 <20220305214056.GO3927073@dread.disaster.area>
 <2241127c-c600-529a-ae41-30cbcc6b281d@kernel.dk>
 <20220306180115.GA8777@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220306180115.GA8777@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/6/22 11:01 AM, Christoph Hellwig wrote:
> On Sun, Mar 06, 2022 at 10:11:46AM -0700, Jens Axboe wrote:
>> Yes, I think we should kill it. If we retain the inode hint, the f2fs
>> doesn't need a any changes. And it should be safe to make the per-file
>> fcntl hints return EINVAL, which they would on older kernels anyway.
>> Untested, but something like the below.
> 
> I've sent this off to the testing farm this morning, but EINVAL might
> be even better:
> 
> http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/more-hint-removal

I do think EINVAL is better, as it just tells the app it's not available
like we would've done before. With just doing zeroes, that might break
applications that set-and-verify. Of course there's also the risk of
that since we retain inode hints (so they work), but fail file hints.
That's a lesser risk though, and we only know of the inode hints being
used.

-- 
Jens Axboe

