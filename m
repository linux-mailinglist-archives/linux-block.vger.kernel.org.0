Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318C01FF250
	for <lists+linux-block@lfdr.de>; Thu, 18 Jun 2020 14:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgFRMt7 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 18 Jun 2020 08:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729914AbgFRMt6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 08:49:58 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2049C0613EF
        for <linux-block@vger.kernel.org>; Thu, 18 Jun 2020 05:49:57 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g10so5074263wmh.4
        for <linux-block@vger.kernel.org>; Thu, 18 Jun 2020 05:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2etjjb3Ig5XsGGEiKGN5JpNnFUz+x9R74hJMp+6KTAE=;
        b=Dq0okwnm8dIAP3kvoa45FnYbLZDxzvv8uoBKmRBi3WMPUPQIN78xVXty0qrja4zjPk
         EkOCjrVdGpZC3fyFgN4PiU7Z/JrNCe2w4BPn+7D78sGoz+KoDFgVPEaOKPEm8CFlP4at
         ETRL68tu/ftXB8IYZAvreyq2MYw+RProIV020=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2etjjb3Ig5XsGGEiKGN5JpNnFUz+x9R74hJMp+6KTAE=;
        b=YcCbQuQZ/sdL3gUuw8vinzU9t+wcCboABk4mg1VAKiU94WMzufl+xZIFQJvbphA3vs
         7xVJTRl6Koqvk/bi/Ri9HVXys2woiJQ0jsNV+QBQ0zhy3B+uAiWoz8uz7zjM99pB6VVT
         ynMjN7/JYDkJ/iPtIowdOKmRat3D+X1FS5ZI6IxuCERlhaSsDFmokl3rVINzUn4nM18P
         hIE2mxljMbmHk4hPFBNYRiNSeipvObH9Oul/GKCa2tZgxBh3ny0C3wYmsNPPHeNkmRH2
         Uw4OejiLlAPdgPX9jt3wTLtzDIPz4Ycpvn5kMtXs8a7hIIo7Ne44X+j1OtPTIa9VS9FI
         MgCA==
X-Gm-Message-State: AOAM531egh4aOXWL22hoOWa0zW7P4zRtem5YHnjNJngwK1YYiMev5pTR
        5scld1dX913tKdfhKWJBD8JHbg==
X-Google-Smtp-Source: ABdhPJylqVUy/P+K1gxZzXFfcVj7BdacNz4q5MIX08y2VIvq3tIsytvwPasTJsxBLJenfxoW3Q7jKg==
X-Received: by 2002:a1c:2044:: with SMTP id g65mr4329441wmg.16.1592484596106;
        Thu, 18 Jun 2020 05:49:56 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
        by smtp.gmail.com with ESMTPSA id b19sm11396014wmj.0.2020.06.18.05.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 05:49:55 -0700 (PDT)
Date:   Thu, 18 Jun 2020 13:49:55 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        "Linux F2FS DEV, Mailing List" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Arnd Bergmann <arnd@arndb.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Chao Yu <chao@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Chao Yu <yuchao0@huawei.com>, lkft-triage@lists.linaro.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Cgroups <cgroups@vger.kernel.org>
Subject: Re: mm: mkfs.ext4 invoked oom-killer on i386 - pagecache_get_page
Message-ID: <20200618124955.GB694719@chrisdown.name>
References: <CA+G9fYsdsgRmwLtSKJSzB1eWcUQ1z-_aaU+BNcQpker34XT6_w@mail.gmail.com>
 <20200617135758.GA548179@chrisdown.name>
 <20200617141155.GQ9499@dhcp22.suse.cz>
 <CA+G9fYu+FB1PE0AMmE-9MrHpayE9kChwTyc3zfM6V83uQ0zcQA@mail.gmail.com>
 <20200617160624.GS9499@dhcp22.suse.cz>
 <CA+G9fYtCXrVGVtRTwxiqgfFNDDf_H4aNH=VpWLhsV4n_mCTLGg@mail.gmail.com>
 <20200617210935.GA578452@chrisdown.name>
 <CALOAHbBp7Ytd-Hta9NH-_HJtVTAsR5Pw2RYrVScp7PPezCEv2w@mail.gmail.com>
 <20200618123743.GA694719@chrisdown.name>
 <20200618124129.GC15447@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200618124129.GC15447@dhcp22.suse.cz>
User-Agent: Mutt/1.14.3 (2020-06-14)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Michal Hocko writes:
>I would really prefer to do that work on top of the fixes we (used to)
>have in mmotm (with the fixup).

Oh, for sure. We should reintroduce the patches with the fix, and then look at 
longer-term solutions once that's in :-)
