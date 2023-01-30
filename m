Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED35681CCE
	for <lists+linux-block@lfdr.de>; Mon, 30 Jan 2023 22:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjA3Vdf (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 30 Jan 2023 16:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjA3Vde (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Jan 2023 16:33:34 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA145B9B
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2023 13:33:32 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id d10so5717080ilc.12
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2023 13:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6IuS+AlPvW98Qt+RMCpyKlCvmTcjIyk1rKVSn77FnZk=;
        b=yutfnYWYTGL9rvqX9NK8NKW0cYY1hX6qXFvfmsUjgbZzZlfTmeiQ+WZ1gCOYaVgPyi
         Pz/6HGBp3mi6cissYy/vIVKG5aVQsq/WyK6fieAf5449c9Urv+p074X4Ki6OVXo7jUyp
         aczEWVRjWJ1Jr9wtK6YtDx4v5S99KitRsYKMEldZWFZlIunlQhrJg0nMsHkIzgL19OW9
         6elz4Lc07w6dTF8bGvvfTe9wvV5bokfctyQLf/ZK5Ve8ZnPVP5WVjlp1Hde8tpUd+A/O
         kIA/p4fvRiLydBA6uj5pnMYN6Udlh/N9Wq5FImMKIDtWt1uxA3m4v9b7Xggll/Krpes+
         rzpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6IuS+AlPvW98Qt+RMCpyKlCvmTcjIyk1rKVSn77FnZk=;
        b=peECwENtL9FQqAxKWuMFoBFNRR7ORLxdGWulMYtuRpGiceEA0FOervpu4dHJqq0y2r
         frUadcM0mJYxd21h+7p2JKXpJ9h3hxkQWyiBaLFNES/geU0fF1QqfS9h4EMIItOZ8PWo
         lANv6HxZSeTH9e4rbCzFvg93dUJfuosjI5PHAIikBBIBRNbnGo/FVFSAPqoIJHGZXs3m
         b+j9Tg9hpUfgOw/zRs+jGl7ndFZLPliG17YBztQ+96UUNXAR5PBW0tjQbVJWjF+KPVQh
         vG2NlrIxQE8vSg3mcmcNnoal8aENp1P82woF6Lzcg8JKRCnHENJ6HDPvgk7GfBd90zTW
         7pmw==
X-Gm-Message-State: AFqh2kpBYAn1JL1RSnyMUa6l4g+GNB6QdY52jObdifq/iPHAUrcFnTBo
        E4BpiFtzy9+mOzA6VUXZQHxdkA==
X-Google-Smtp-Source: AMrXdXtNX89kIh+cJlv4D5se7EwlFyXWSnsI7waS+BCn54d+KKimODStx80DZ9GZTS40+VrkqquNvw==
X-Received: by 2002:a92:6e11:0:b0:304:c683:3c8a with SMTP id j17-20020a926e11000000b00304c6833c8amr7247424ilc.3.1675114411605;
        Mon, 30 Jan 2023 13:33:31 -0800 (PST)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 10-20020a056e0211aa00b00310f9a0f8a7sm990514ilj.76.2023.01.30.13.33.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 13:33:31 -0800 (PST)
Message-ID: <fd0003a0-a133-3daf-891c-ba7deafad768@kernel.dk>
Date:   Mon, 30 Jan 2023 14:33:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [GIT PULL] iov_iter: Improve page extraction (pin or just list)
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jeff Layton <jlayton@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <3351099.1675077249@warthog.procyon.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <3351099.1675077249@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/30/23 4:14 AM, David Howells wrote:
> Hi Jens,
> 
> Could you consider pulling this patchset into the block tree?  I think that
> Al's fears wrt to pinned pages being removed from page tables causing deadlock
> have been answered.  Granted, there is still the issue of how to handle
> vmsplice and a bunch of other places to fix, not least skbuff handling.
> 
> I also have patches to fix cifs in a separate branch that I would also like to
> push in this merge window - and that requires the first two patches from this
> series also, so would it be possible for you to merge at least those two
> rather than manually applying them?

I've pulled this into a separate branch, but based on the block branch,
for-6.3/iov-extract. It's added to for-next as well.

-- 
Jens Axboe


