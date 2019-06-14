Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2004546042
	for <lists+linux-block@lfdr.de>; Fri, 14 Jun 2019 16:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbfFNOMm (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 14 Jun 2019 10:12:42 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35144 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbfFNOMl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jun 2019 10:12:41 -0400
Received: by mail-qt1-f193.google.com with SMTP id d23so2620279qto.2
        for <linux-block@vger.kernel.org>; Fri, 14 Jun 2019 07:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rAC+Hn22cr49ahogcik0pcBGLagZS3dETf2Wz5S13B0=;
        b=LFa2rt4qfms1O2bBvZEW+0W+yIcox6qSOOVAvbDzHmHWo7eTBXlpUAexcKk/hD3cG+
         rZ0+KCTtWiy5i11ac0ffORaj13AQegx+B3gE4nQ1qjDlsSxGZxe41ifQWeW/cRdygt3S
         z4xcC/+/F/ZBom7OzAh9BRsonM/Aaa18VswtLxMXOOaLL32rLfu84gAbFeINiulLvMLR
         Yq/ZKonKABWtRk2lRehY3/uysF7DQdtvGRU569vLLFCcMz9mMuy9x3Q3seIf0ssPYt7g
         O6W0+KYhEf2U1P2W64QDZzS7jPc3N1x7t1sOs4846SUMiyw55JhL5l5bqMy50hkQYXYM
         jJUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rAC+Hn22cr49ahogcik0pcBGLagZS3dETf2Wz5S13B0=;
        b=I34xn7+56UeRVp4C3A4X8eHTExJKLXeGuZAiLsA0wIyj5bzS7qizKLwNC4pNT/jHX3
         RImCEKxOixK8/z74+XTWkxalf6sLVxnbgYPQyZuFytYm9MgjX6NTEJGhMXHBTzuEvCQK
         ffhoYC5GLILg2srXwnO6pIRBdslVO1cT+aQk+0outQKPMhjjkUUJOoK/BIUkFQqTpS6q
         n9dAOzQRFV1J6qJyI7l3QOU9SRGJJzRK/57M2xwfYVbjIb1sMRhKypaRLWILf4LcUqb5
         Mdhoufq2OFTgqiZ6IRx91yyUWrF8czTmdHuyBU2QHY0YuwxJr2lOVgoQ2hJcEby+Vy8R
         u/lg==
X-Gm-Message-State: APjAAAWL0jHLrIODfHdq4WQsIlxnnEV8M8QWGPFR6Yt8TKcYkaiGp6gy
        fMH+zeSSXfcaRFblgnlaw2fdzQ==
X-Google-Smtp-Source: APXvYqyL0VPrGh6qcGTBP90vhD+R/W+sNmhvThLYHkzunbpAtLQ6J+jYlOSU6Vg8VPbSr9kS5SES5g==
X-Received: by 2002:a0c:d4b4:: with SMTP id u49mr8632899qvh.202.1560521561034;
        Fri, 14 Jun 2019 07:12:41 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::a658])
        by smtp.gmail.com with ESMTPSA id j9sm1394411qkg.30.2019.06.14.07.12.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 07:12:40 -0700 (PDT)
Date:   Fri, 14 Jun 2019 10:12:39 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     dsterba@suse.com, clm@fb.com, josef@toxicpanda.com,
        axboe@kernel.dk, jack@suse.cz, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 8/8] Btrfs: extent_write_locked_range() should attach
 inode->i_wb
Message-ID: <20190614141238.qhb45oehk6gbftja@MacBook-Pro-91.local>
References: <20190614003350.1178444-1-tj@kernel.org>
 <20190614003350.1178444-9-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614003350.1178444-9-tj@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 13, 2019 at 05:33:50PM -0700, Tejun Heo wrote:
> From: Chris Mason <clm@fb.com>
> 
> extent_write_locked_range() is used when we're falling back to buffered
> IO from inside of compression.  It allocates its own wbc and should
> associate it with the inode's i_wb to make sure the IO goes down from
> the correct cgroup.
> 
> Signed-off-by: Chris Mason <clm@fb.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
