Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0615210F592
	for <lists+linux-block@lfdr.de>; Tue,  3 Dec 2019 04:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfLCD0k (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 2 Dec 2019 22:26:40 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38036 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfLCD0k (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Dec 2019 22:26:40 -0500
Received: by mail-oi1-f194.google.com with SMTP id b8so1958689oiy.5
        for <linux-block@vger.kernel.org>; Mon, 02 Dec 2019 19:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockbridge-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LwpIDBucvKjpCN15l8CmiENKWiJ3fV7rlV+B6EGUY/Q=;
        b=uMRhepsMu54o9CknQNkBGlVn/d9qy8xO+eU0zmh4MITzbVKaCBeSRy+aJ/PP3/JOMQ
         n5zQiSfEKe35TPViuH2uRohl67uxsx9P1Z63dXSkXzveAEGVF3xEqnFY3reQYbHZJYB+
         5aGzLn+qzcY4WFFKjE9rRNtySBtfsawB08cY/e8Ajku/lxSAcuBkTvXYl6oRD5DcsB/x
         foQMpBqwsmXvd50oD3SNv8pgWLRUHRJxkNYN8+Arr6U3m++sENJzesJ54aDM9MWMYH+5
         XOrtAKD6WJhlLK9pU5XPW0pFlsZpN5E1C8XLc6mJTd8MG47+iMbtPDYjA1EdNeyToH26
         Xk2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LwpIDBucvKjpCN15l8CmiENKWiJ3fV7rlV+B6EGUY/Q=;
        b=hOhbqdgRkAfVm8n3r7cNChdQzHqlTD5z7FzinvPQiv1JlpSNLK2jaywsWak3wl7CEn
         xTJNH//te7DiWIamN+SvAgbji4CgqGEFxWjzI5+yfCKzT3fLVKJfVNd9ckvx5WpgWjnv
         317Y1a2bi6q+HuLyyZJSGqkm9366HdIuvHRWa5aN9PBqVf02Lpw3tsgDP1Ut+FTofyEb
         t8FvtcpoDqWou2bbGOwvWyUgO2dOnc4k7XPBCFkllLnaq4DrWR9ITACXapUEYT3CpzQH
         2iQNsvLc6+5uuYfv12XpgndyQpp8pe5lsT9Vy7d9i8EXS2xACHIWuD/5Pl+uGj5HplVT
         8kPw==
X-Gm-Message-State: APjAAAXmZSd+uobncde3lcIA71trjhL5l/r8Zpcq2NWbLuxo52SYoGl+
        6pHr0jht08bnyaWtm49/r851Y6VI7Mk0mpoUsNnedw==
X-Google-Smtp-Source: APXvYqwz4mfuLXrSsp718O29itUq1yXjgDG5hOd8dyAdMUbt6utvr7bHWcM09Cww6W0Y6cXJadQ8xNl2lKC2MLvNsE0=
X-Received: by 2002:a05:6808:b2d:: with SMTP id t13mr2009175oij.83.1575343599018;
 Mon, 02 Dec 2019 19:26:39 -0800 (PST)
MIME-Version: 1.0
References: <CAAFE1bd9wuuobpe4VK7Ty175j7mWT+kRmHCNhVD+6R8MWEAqmw@mail.gmail.com>
 <20191128015748.GA3277@ming.t460p> <CA+VdTb_-CGaPjKUQteKVFSGqDz-5o-tuRRkJYqt8B9iOQypiwQ@mail.gmail.com>
 <20191128025822.GC3277@ming.t460p> <CAAFE1bfsXsKGyw7SU_z4NanT+wmtuJT=XejBYbHHMCDQwm73sw@mail.gmail.com>
 <20191128091210.GC15549@ming.t460p> <CAAFE1beMkvyRctGqpffd3o_QtDH0CrmQSb=fV4GzqMUXWzPyOw@mail.gmail.com>
 <20191203005849.GB25002@ming.t460p> <CAAFE1bcG8c1Q3iwh-LUjruBMAuFTJ4qWxNGsnhfKvGWHNLAeEQ@mail.gmail.com>
 <20191203031444.GB6245@ming.t460p>
In-Reply-To: <20191203031444.GB6245@ming.t460p>
From:   Stephen Rust <srust@blockbridge.com>
Date:   Mon, 2 Dec 2019 22:26:28 -0500
Message-ID: <CAAFE1besnb=HV4C_buORYpWbkXecmtybwX8d_Ka2NsKmiym53w@mail.gmail.com>
Subject: Re: Data corruption in kernel 5.1+ with iSER attached ramdisk
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Rob Townley <rob.townley@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        target-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> oops, it should have been (arg4 & 511) != 0.

Yep, there they are:

# /usr/share/bcc/tools/trace -K 'bio_add_page ((arg4 & 511) != 0) "%d
%d", arg3, arg4'
PID     TID     COMM            FUNC             -
7411    7411    kworker/31:1H   bio_add_page     512 76
        bio_add_page+0x1 [kernel]
        sbc_execute_rw+0x28 [kernel]
        __target_execute_cmd+0x2e [kernel]
        target_execute_cmd+0x1c1 [kernel]
        iscsit_execute_cmd+0x1e7 [kernel]
        iscsit_sequence_cmd+0xdc [kernel]
        isert_recv_done+0x780 [kernel]
        __ib_process_cq+0x78 [kernel]
        ib_cq_poll_work+0x29 [kernel]
        process_one_work+0x179 [kernel]
        worker_thread+0x4f [kernel]
        kthread+0x105 [kernel]
        ret_from_fork+0x1f [kernel]

7753    7753    kworker/26:1H   bio_add_page     4096 76
        bio_add_page+0x1 [kernel]
        sbc_execute_rw+0x28 [kernel]
        __target_execute_cmd+0x2e [kernel]
        target_execute_cmd+0x1c1 [kernel]
        iscsit_execute_cmd+0x1e7 [kernel]
        iscsit_sequence_cmd+0xdc [kernel]
        isert_recv_done+0x780 [kernel]
        __ib_process_cq+0x78 [kernel]
        ib_cq_poll_work+0x29 [kernel]
        process_one_work+0x179 [kernel]
        worker_thread+0x4f [kernel]
        kthread+0x105 [kernel]
        ret_from_fork+0x1f [kernel]
