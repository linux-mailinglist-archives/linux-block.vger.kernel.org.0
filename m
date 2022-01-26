Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4969B49CAE7
	for <lists+linux-block@lfdr.de>; Wed, 26 Jan 2022 14:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240027AbiAZNe5 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 26 Jan 2022 08:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiAZNe4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jan 2022 08:34:56 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25736C06161C
        for <linux-block@vger.kernel.org>; Wed, 26 Jan 2022 05:34:56 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id i1so13892736ils.5
        for <linux-block@vger.kernel.org>; Wed, 26 Jan 2022 05:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=/ycwdxXl7xzlVcgZpMTQusl4xKyijfRRHTUAN+QxTEE=;
        b=FKQPqYyQV4gUD8tCmpE3qC9ZiTKhLgDxer8fEHHPqZTpYefsVvvGFNefA/FnssIM63
         EaLiJfNVUOfBHVOrxkmfzQL49q/d/5pN1ZUU+LKQBzI598d2wwNERrpeh1Ex6kPzyiFb
         JZTWeKXf8b70jcKMwDZy9/YO8nTDW0APYt+yJvhJiwzryilyz/ZZVHAUhzZdnK1sWg4k
         ywmCT668+bdItqD8CNFdJOjUeMrxDk5wGGgh4+hv+1F7whIXtq4hGqU/JcaP+ZrYoU3c
         8lsuSBN0dz2w2QuiV3kN+YZgs90jZh2Pb41G51L41stEtx9VN3x/tJGdLtkp0T497OU4
         xY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=/ycwdxXl7xzlVcgZpMTQusl4xKyijfRRHTUAN+QxTEE=;
        b=K3Pby+ml25qAD6pf/K70f83HPVSuvhLlPk14feMiC5tH5M4ZAHuLG2HQ+3DCL/7Oop
         swBbPir/xW9k35ApsZBmVHc3YbzPxuEGlNyxCOPeKNykJycJxNDsb6vNlfZsVa09SG8W
         c5GOQP5uBGLj2e4o4L2I8vvANLEwp6JsVSe5TizoZKomn/+JjwULOlyxowSxsT6LO5Tg
         DyVb8HWch62II/R7iYqLznVjPbK/MaZYUXVjSOkRCXgZfdd62AYtDV0GPSFrCpTib50R
         5TjOPgGRE9wVtAoG77Zqa2ajtja2ZZ8FzsExrhr1/NYazvuTdDbtk56Zgfsm/sJ4gWAm
         Wn6A==
X-Gm-Message-State: AOAM5300jBviPeQALS95gUX8yNSsQ2Do+CXxkrv7j9LvneT4KWc6XfnU
        3h+Ijc++/2wXhK6961Z/JR5HJNnHL0k0ww==
X-Google-Smtp-Source: ABdhPJxzuTGcfsYFU99TT4WD+eEaJROO/7MGhikZS0SWzpSAI4623/dh2z8rsy9wTzniruCxAOGyLQ==
X-Received: by 2002:a92:d2d1:: with SMTP id w17mr14293198ilg.170.1643204095401;
        Wed, 26 Jan 2022 05:34:55 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id q16sm9375312ion.27.2022.01.26.05.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 05:34:54 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        yi.zhang@huawei.com
In-Reply-To: <20220126012132.3111551-1-yukuai3@huawei.com>
References: <20220126012132.3111551-1-yukuai3@huawei.com>
Subject: Re: [PATCH v2] blk-mq: fix missing blk_account_io_done() in error path
Message-Id: <164320409207.123597.5205274330613779469.b4-ty@kernel.dk>
Date:   Wed, 26 Jan 2022 06:34:52 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 26 Jan 2022 09:21:32 +0800, Yu Kuai wrote:
> If blk_mq_request_issue_directly() failed from
> blk_insert_cloned_request(), the request will be accounted start.
> Currently, blk_insert_cloned_request() is only called by dm, and such
> request won't be accounted done by dm.
> 
> In normal path, io will be accounted start from blk_mq_bio_to_request(),
> when the request is allocated, and such io will be accounted done from
> __blk_mq_end_request_acct() whether it succeeded or failed. Thus add
> blk_account_io_done() to fix the problem.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: fix missing blk_account_io_done() in error path
      commit: 592ee1197f78b30bd60c87db9b6c8c045c8d8314

Best regards,
-- 
Jens Axboe


