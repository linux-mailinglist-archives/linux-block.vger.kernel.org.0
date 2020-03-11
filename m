Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13EDF18211A
	for <lists+linux-block@lfdr.de>; Wed, 11 Mar 2020 19:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730715AbgCKSpZ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 11 Mar 2020 14:45:25 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45394 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730691AbgCKSpZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Mar 2020 14:45:25 -0400
Received: by mail-qt1-f194.google.com with SMTP id a4so2350295qto.12
        for <linux-block@vger.kernel.org>; Wed, 11 Mar 2020 11:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T1iORqz7Rz2GqLkfrNyBvPHOv4t4QzJBOsi8bbupqhk=;
        b=hBNDkN+6XNzDazPEdHBidkHEN9Hq6Aw7HWDnLqGjkh92yrGoRRCtmWfgCpogqJQoIG
         lk7OY91PdkGo1VZTNocOlcn3+rc9L9+1EAuJMMhie4/uW0eE2Y+rLoFh/rvWHe0vws8w
         2ixqUtoMe8sLL6/6RL0X9EugsD94lynnCXy14/He0G6QBui6jn8Bt2sgt5rY7Zyfral8
         VGYkMwWIW3ks1shHj8Q/IkTR4zlZXmnn4AKO5zbXxSxdJ0vPEmQ81buKKAVjXDzeC7sm
         7OIkZ4WApfv8BrL7XQmESH0fPJBqVwaC1ijvyv4QUVBdAaWWCPtoboHzXpQJNTBsCboo
         quXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T1iORqz7Rz2GqLkfrNyBvPHOv4t4QzJBOsi8bbupqhk=;
        b=KuV0AxQDKcZVWZNLpS2TXwdx25Nh48Xy0u0AqqU0SZdC5PYhoJja/Zz54GYChGcwI3
         Pi0xcprbojfvQfA6gnIs2yHT/OYxYFkB8HqmCB0rZlfo/6Uj7vVhAYb6OA3Md7EkzIbe
         LMHgc3Mja3eupgjwdlGm2nO2+zOi39EhlYcz2GbIY2/SNaNq/4CzWl69QxcwANmhfkne
         NfIe41vlnaR3uuAlETfSdx4gWG6sppWDuHSwDnoo8Ala+89UHp3uY2KIzLYdRVdbHnOD
         wv7TCxuxLqPw2HWhuEGF6oHQpFOFeZmypsPQ/vCmKSgYGDMB5jfwPFNod/zod7H0fg0y
         BoDQ==
X-Gm-Message-State: ANhLgQ1v0xqMEVyD8Uog2BC698Y2j/GAV18oeO219fCXQwJc8SgJPkUu
        zOtzTEb9Yo4I4h7nZabfv0hwTA==
X-Google-Smtp-Source: ADFU+vu5OsT+o+MGPfyeE+oPaf5QL86MVlUdTPJfR5q4z5/b6Nin0Mf2Dr2tJni8yo4Z36cZr93law==
X-Received: by 2002:ac8:718e:: with SMTP id w14mr3939550qto.266.1583952324002;
        Wed, 11 Mar 2020 11:45:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id g49sm6810441qtk.1.2020.03.11.11.45.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Mar 2020 11:45:23 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jC6M6-0001Db-Sd; Wed, 11 Mar 2020 15:45:22 -0300
Date:   Wed, 11 Mar 2020 15:45:22 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jack Wang <jinpu.wang@cloud.ionos.com>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com
Subject: Re: [PATCH v10 02/26] RDMA/rtrs: public interface header to
 establish RDMA connections
Message-ID: <20200311184522.GG31668@ziepe.ca>
References: <20200311161240.30190-1-jinpu.wang@cloud.ionos.com>
 <20200311161240.30190-3-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311161240.30190-3-jinpu.wang@cloud.ionos.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 11, 2020 at 05:12:16PM +0100, Jack Wang wrote:
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs.h b/drivers/infiniband/ulp/rtrs/rtrs.h
> new file mode 100644
> index 000000000000..395d1112f155
> +++ b/drivers/infiniband/ulp/rtrs/rtrs.h

> +
> +/**
> + * rtrs_clt_open() - Open a session to an RTRS server
> + * @ops: holds the link event callback and the private pointer.
> + * @sessname: name of the session
> + * @paths: Paths to be established defined by their src and dst addresses
> + * @path_cnt: Number of elements in the @paths array
> + * @port: port to be used by the RTRS session
> + * @pdu_sz: Size of extra payload which can be accessed after permit allocation.
> + * @max_inflight_msg: Max. number of parallel inflight messages for the session
> + * @max_segments: Max. number of segments per IO request
> + * @reconnect_delay_sec: time between reconnect tries
> + * @max_reconnect_attempts: Number of times to reconnect on error before giving
> + *			    up, 0 for * disabled, -1 for forever
> + *
> + * Starts session establishment with the rtrs_server. The function can block
> + * up to ~2000ms before it returns.
> + *
> + * Return a valid pointer on success otherwise PTR_ERR.
> + */

It is not so major, but the linux standard is for kdocs to be in the
.c files not the header - to make an index of kdocs for browsing I
think the sphinx stuff is supposed to be used.

Jason
