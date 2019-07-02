Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4235D97B
	for <lists+linux-block@lfdr.de>; Wed,  3 Jul 2019 02:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfGCAoX (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 2 Jul 2019 20:44:23 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37322 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfGCAoW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Jul 2019 20:44:22 -0400
Received: by mail-oi1-f193.google.com with SMTP id t76so586022oih.4
        for <linux-block@vger.kernel.org>; Tue, 02 Jul 2019 17:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hRbl+rnLLpZPkdEeKLbRFSypC1wcYyqi4gerbmvQkgw=;
        b=WsQmOHsqmPEZKC0ZYgnArIvsGk9xTU+TScq2RYLQTKzfYoq1Xx6n4sVX7aZfCctB+4
         +FcjKx/eRQkwNc/PaE4dnkRY8Fy1oZut0LYKZqu/cvwm8hETGGVB/w4H7qKSAm1HJ7Da
         fC5ke6pAOtjONJ977HmiHd5YAsFDQxR12+1m0dP0z0TUO5AyCuU/Jcq/v1f5Z4APYGOG
         3t3Y4pLQNr2D4F8Zd2ckZwaQI7XkbIgqr/4mh3dnGIANlxWilFUD20dki9UEJdHQicre
         e2oc67VxhhRZN+YPV6JnlgmsXxiDujeWLf9X2li2UhgFN0qJL9Cgyzf2k39RZiUcv7by
         f+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hRbl+rnLLpZPkdEeKLbRFSypC1wcYyqi4gerbmvQkgw=;
        b=heFPdQTQDTL53titJ/pxFo97PJPhwB2orWY8XT4fGbvpRSx6q83pPVmaFus2J/XXSz
         fwUrGC5vaBy11QMRj6GsrlNU8WHXViajmd7sWw2HnQC5YI7uNbbAYqHJjyV9ZR9gzJeN
         ISfFd9J6+Fq/Ax9aGRoFEVsqzuOEYf4cehMaZzR3sJC1TVZFPBKrWBW0eB/Tbf+rNWju
         e0YbtqvygIelBeRRF9eSGvTzBQP+umXCWQeqhYFErD6D9CCOpX3CJf6EovgvJbc6mDyg
         MWctGSWYrnKly+aM2OIoFvPAGBighdmsyb4mBe3MhXwjINPd7f1p/Ojhyk4suL4zoZzx
         isow==
X-Gm-Message-State: APjAAAWAZ++sUlorokPBobRvYSfVHNDZ8GIoZlnwhagdAErfsBjmHxYW
        gUGJE8RIDyBKDFW1D4QHaT7F8W0+nfs=
X-Google-Smtp-Source: APXvYqyaAm9ABkT/bgHjPaWzI2mUEUJWM0dNnN+tgACQQ7IiGW6RptVoERdsqjUJDKkTsWrlzhzwnQ==
X-Received: by 2002:a63:224a:: with SMTP id t10mr33126032pgm.289.1562110953237;
        Tue, 02 Jul 2019 16:42:33 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id d2sm227430pgo.0.2019.07.02.16.42.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jul 2019 16:42:32 -0700 (PDT)
Date:   Wed, 3 Jul 2019 08:42:29 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Omar Sandoval <osandov@fb.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH 2/2] blk-mq: Simplify blk_mq_make_request()
Message-ID: <20190702234229.GA15705@minwoo-desktop>
References: <20190701154730.203795-1-bvanassche@acm.org>
 <20190701154730.203795-3-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190701154730.203795-3-bvanassche@acm.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19-07-01 08:47:30, Bart Van Assche wrote:
> Move the blk_mq_bio_to_request() call in front of the if-statement.

This looks good to me based on the first patch.

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>
