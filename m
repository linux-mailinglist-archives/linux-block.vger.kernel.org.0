Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E326CB305
	for <lists+linux-block@lfdr.de>; Tue, 28 Mar 2023 03:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjC1BPR (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 27 Mar 2023 21:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjC1BPQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2023 21:15:16 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E69719A0
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 18:15:13 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id w4so10141744plg.9
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 18:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679966113; x=1682558113;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zwq4wydL9I093v9hDO3zVwxnC9J0ZcC370MjIqWsDT8=;
        b=4aXydidiJ0gc7rsxJ/Twmo6oHXpvj6XODqgY7UDHkJeLJRsq6y40W37/ZcDksGwZAc
         A7BXYYZww/WmIS5JeLSNicb1HYtNX5E4BjRm8ACtByEhkjCJ9ARbgOcD4/af01hfRL/X
         73P7ZjcuNrHhhdcOJJlOKzxG+9YhoRF2UdL3R+Ol6CJprWIaOhDgSwvj9P9ViC2LIXzB
         vGuC6V//sYYzegzWxHCY0qpLo/W2jl78LaiE3g6VvgIwFElz9WM4eBphtyqshPwZjzT2
         RrI3SIIpLjqG0o0f3Ur2haKngtLQRPgHhAN8u1QzsxyTmcSsuagZ/WXUKES9HL2OZZg9
         YvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679966113; x=1682558113;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zwq4wydL9I093v9hDO3zVwxnC9J0ZcC370MjIqWsDT8=;
        b=U79yskJzGKuf6cTcGSTP6lAMGS1TIC+mTABwaqyo18ujDa6QQA9A8/d4Tb6+K9vb7u
         y9PdW8Bbj0LdIu4UAuNzHWSEv6acMGMAF+9c5YrT6FDsSPvrsIVjbkkaUlAZ5OUUx/nu
         w7wjmLOar69+G5KlX2fNP27h/HaDQvm0yaarAt/k546uY8Jsf5o8BL4TjbJ9kDw21/ul
         Y/BnCZ5KEsFtaWY9QmeGeHTwb8gTj4HINQ2OpeCL1Ww0zMRvBSTBj5ie9WhMSh+JlCuk
         JD4/cADbfmdKBbvbD8yEOAvOAz/jU+zTIoBIbje9vXHfE8qGVcSczLVOD+B681f9Q30H
         EOGQ==
X-Gm-Message-State: AAQBX9e2jNXHWoJwz5tcQTQ+abtfY8NloOmI11HJnHXk1x5PjFyf20lN
        7v/Zvtw516Uwbib2O6lldXmJXg==
X-Google-Smtp-Source: AKy350ZYJ4GZvfbOmXmRspn+6HYJw0ztOtB6wwoqRwXMmL0StVUaM++KMQ2fSjcxhpwdlKSJBi5Bqg==
X-Received: by 2002:a17:90a:d58b:b0:23b:4d09:c166 with SMTP id v11-20020a17090ad58b00b0023b4d09c166mr10919116pju.4.1679966112751;
        Mon, 27 Mar 2023 18:15:12 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id l21-20020a656815000000b004eecc3080f8sm18782941pgt.29.2023.03.27.18.15.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 18:15:12 -0700 (PDT)
Message-ID: <f1b3f0c2-f08a-a432-f0c5-6223a59e671a@kernel.dk>
Date:   Mon, 27 Mar 2023 19:15:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 5/7] btrfs, block: move REQ_CGROUP_PUNT to btrfs
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20230327004954.728797-1-hch@lst.de>
 <20230327004954.728797-6-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230327004954.728797-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=3.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/26/23 6:49?PM, Christoph Hellwig wrote:
> REQ_CGROUP_PUNT is a bit annoying as it is hard to follow and adds
> a branch to the bio submission hot path.  To fix this, export
> blkcg_punt_bio_submit and let btrfs call it directly.  Add a new
> REQ_FS_PRIVATE flag for btrfs to indicate to it's own low-level
> bio submission code that a punt to the cgroup submission helper
> is required.

Looks good, and nice to remove more cruft from the generic
submission path:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

