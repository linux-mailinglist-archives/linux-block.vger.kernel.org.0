Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21BFC12E9D4
	for <lists+linux-block@lfdr.de>; Thu,  2 Jan 2020 19:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgABSTB (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 2 Jan 2020 13:19:01 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41296 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727905AbgABSTB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jan 2020 13:19:01 -0500
Received: by mail-qk1-f193.google.com with SMTP id x129so31983766qke.8
        for <linux-block@vger.kernel.org>; Thu, 02 Jan 2020 10:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Csv9RkX+btH1fRvzYebWxmzJI2nh5n+bdHJt7GV96bk=;
        b=W19s5UfI8xZ/KO3HJhNiipzFAQm8HdoBFEioSovzaBQGcMrkij9Zry71gOHhhjEsTv
         EuCDhVZ4WV4J89gBeFPXT3UpATus3af+NNO2ZBSp8SW4bvqE1fIFbcmf37j9iOMM2l11
         nCTvXyz9+k/KPxMTX9P5uvXQyaLmGgiWftoyTFbPL3O8c0jLc0v0M6jsZ/nmBGNqVT2T
         5xpCkienhd7S2T9spuZf36ZEijYdIuv59dth99wcPdONRyywUMVeQGu4pCk1fkwRIJ2d
         xu+Wz47RGcibYzzNO86ju4eYU830dhb8KeyBx8V7MtuEi16tB84f8GWPXpxpIPceQANQ
         o0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Csv9RkX+btH1fRvzYebWxmzJI2nh5n+bdHJt7GV96bk=;
        b=XNZ/ITz0fMwzwUGdjMAWWYRuWcj2suJEW37KW7TjWfUQGtRwIvlIHAJTNOSDfYYklF
         yslbMbt5Lad3cj9tiCeZVGJ1WmvZhIKwFtwBXKJJVPEDtOal/k8ALjvploO1EoIjWc/E
         GbbdsA0CDKX+Hj+oyLAPBqLPcuUeYqUhT9LSUDT8TiF/+WNDu0kjsnx8CQgh39iC89v5
         fRRgD9XQzMw7XMtSJ830E3nBF2PhDlqRziEOzjFyJwDxfsF0KVOGvCcP3ppuEhklzI0D
         LvAl+lX/9HUjcxpFnRCZmdyRlV8YXMzQkBX7bYr6pSGASiuf54CjmLltE+B1C2NHY8eH
         T6Sw==
X-Gm-Message-State: APjAAAVWcwfoIHu30/pOfinyE/J41vIZTtJ30VgVkvh97km6SSQqiCsd
        EVbuwvnSCFqflij3wl4J5dPdeQ==
X-Google-Smtp-Source: APXvYqz4IehmERvZkSLn4dv0AlZiLqxjIhUPXsfbcmH1QR56baIC/yZYOdzyT1EtgjA6A3n0bzymnw==
X-Received: by 2002:a37:9f41:: with SMTP id i62mr65840276qke.272.1577989140443;
        Thu, 02 Jan 2020 10:19:00 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id q25sm15412176qkq.88.2020.01.02.10.18.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Jan 2020 10:18:59 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1in53j-0003H7-CA; Thu, 02 Jan 2020 14:18:59 -0400
Date:   Thu, 2 Jan 2020 14:18:59 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jack Wang <jinpuwang@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de
Subject: Re: [PATCH v5 00/25] RTRS (former IBTRS) rdma transport library and
 the corresponding RNBD (former IBNBD) rdma network block device
Message-ID: <20200102181859.GC9282@ziepe.ca>
References: <20191220155109.8959-1-jinpuwang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220155109.8959-1-jinpuwang@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 20, 2019 at 04:50:44PM +0100, Jack Wang wrote:
> Hi all,
> 
> here is V5 of the RTRS (former IBTRS) rdma transport library and the 
> corresponding RNBD (former IBNBD) rdma network block device.
> 
> Main changes are the following:
> 1. Fix the security problem pointed out by Jason
> 2. Implement code-style/readability/API/etc suggestions by Bart van Assche
> 3. Rename IBTRS and IBNBD to RTRS and RNBD accordingly
> 4. Fileio mode support in rnbd-srv has been removed.
> 
> The main functional change is a fix for the security problem pointed out by 
> Jason and discussed both on the mailing list and during the last LPC RDMA MC 2019.
> On the server side we now invalidate in RTRS each rdma buffer before we hand it
> over to RNBD server and in turn to the block layer. A new rkey is generated and
> registered for the buffer after it returns back from the block layer and RNBD
> server. The new rkey is sent back to the client along with the IO result.
> The procedure is the default behaviour of the driver. This invalidation and
> registration on each IO causes performance drop of up to 20%. A user of the
> driver may choose to load the modules with this mechanism switched
> off

So, how does this compare now to nvme over fabrics?

I recall there were questiosn why we needed yet another RDMA block
transport?

Jason
