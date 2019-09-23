Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96D8EBAFB8
	for <lists+linux-block@lfdr.de>; Mon, 23 Sep 2019 10:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406681AbfIWIfy (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 23 Sep 2019 04:35:54 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38839 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405465AbfIWIfy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Sep 2019 04:35:54 -0400
Received: by mail-wm1-f68.google.com with SMTP id 3so8240364wmi.3;
        Mon, 23 Sep 2019 01:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1B3XXUv7iZ4Dl2+6K8o3oe0tw2nlEw97b0eQ1uBbyUI=;
        b=jFZT2Eu3VBNhyieGvh6ycdJxGmRFlHILM7r4+/YEWOpinbJkVBUI/3ODDLwjcw6WNi
         IvTj1BDjBHdPerS1DMqTgJS8ZIsVNm/VcEkUh7JP8I1ZHBF4dHN7SkHSYApanU+tqcGj
         2BEPLnDjgSPriAKJ4OaCh5YfNoQjBTBw5FdCkL+nMw2F8ryKNGzYxFpM2EHLLpU+4bfS
         sd6GkqXkNbS6aZgVBnwbiyV23RMZJSlYcRuNqR36ZFS9odCsvlA8wUpY4KFJc8U/yuZD
         jRJsx9rz9BBMTJ18EyFz/kfBBWfhXnAnQtBXvUb9tYKx+bYWazzvEPkWnrHJY4Jswewe
         y8dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1B3XXUv7iZ4Dl2+6K8o3oe0tw2nlEw97b0eQ1uBbyUI=;
        b=IVc3yuVVSIt7bT4Ckj/aDk/k6l4y+fuNpBOX2l3CGR4lO2hCB2owJyD06lwKpf5opH
         rWFn80B/CrlDUdP/q4l+8vhpSuoRtEqImSu6IWKgW0fMUXj3CrH6Ijj/lqz485R5w8pW
         xnE1biuxvauU7zlWeH6KuXNOUcgNquv6wQguQt++/lAwgCyY3jsDlIKTirzsx5YMhN/1
         x0QFL67KyvE8NIoD6gw5Dlxxq6G5x/7WXyvGxLo27TGC6u0wTKyk6CETuNO+CeeOl15I
         EJVi+fLiwc9X98jv7L+/ErjvDt0nBTBCSmZR6jcsy5cJ8iMcpgVtl/NWFda92BWNVdvB
         mBrw==
X-Gm-Message-State: APjAAAWfhMs9mnx2HfIUbXw1dWET3IyWUIoTUK+x2QhYPG9DRdfYsU2E
        hakLiNPQR98gDX1Vc6a+d7w=
X-Google-Smtp-Source: APXvYqxYbW0B500odDVP3qV4RPcwp/MtiDHalNNevEpuiSyml7mPOiV6yVDQBirBdA+5mYlbaKFUJw==
X-Received: by 2002:a05:600c:219a:: with SMTP id e26mr13433766wme.86.1569227752038;
        Mon, 23 Sep 2019 01:35:52 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id u10sm8616394wmm.0.2019.09.23.01.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 01:35:51 -0700 (PDT)
Date:   Mon, 23 Sep 2019 10:35:49 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Pavel Begunkov (Silence)" <asml.silence@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Optimise io_uring completion waiting
Message-ID: <20190923083549.GA42487@gmail.com>
References: <cover.1569139018.git.asml.silence@gmail.com>
 <a4996ae7-ac0a-447b-49b2-7e96275aad29@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4996ae7-ac0a-447b-49b2-7e96275aad29@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


* Jens Axboe <axboe@kernel.dk> wrote:

> On 9/22/19 2:08 AM, Pavel Begunkov (Silence) wrote:
> > From: Pavel Begunkov <asml.silence@gmail.com>
> > 
> > There could be a lot of overhead within generic wait_event_*() used for
> > waiting for large number of completions. The patchset removes much of
> > it by using custom wait event (wait_threshold).
> > 
> > Synthetic test showed ~40% performance boost. (see patch 2)
> 
> I'm fine with the io_uring side of things, but to queue this up we
> really need Peter or Ingo to sign off on the core wakeup bits...
> 
> Peter?

I'm not sure an extension is needed for such a special interface, why not 
just put a ->threshold value next to the ctx->wait field and use either 
the regular wait_event() APIs with the proper condition, or 
wait_event_cmd() style APIs if you absolutely need something more complex 
to happen inside?

Should result in a much lower linecount and no scheduler changes. :-)

Thanks,

	Ingo
