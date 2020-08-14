Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420E4244C99
	for <lists+linux-block@lfdr.de>; Fri, 14 Aug 2020 18:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgHNQYc (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 14 Aug 2020 12:24:32 -0400
Received: from ale.deltatee.com ([204.191.154.188]:56926 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgHNQYc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Aug 2020 12:24:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kh0Xgc5bxfK/3zw8VCgNUFwM8M2Hq7iTnrXUmhoIB+Q=; b=kAh4/KEZlLjUhq+qvu0tbjpY5C
        PTxJoNVnXfZJ5rj1B/Md2In92ZOTgxPvEnSQHm2gH4R3pu//HBw+paarUSjRiHHW8EXwI3b2WCkJT
        VRiQNLPIxTrT6cmufNBgH7e8X6Er5Fc1uhaoHllLh/1PTyxsVl9H1sF5T10QtfVjsie7nYVcXR/Kt
        k06GruMhQp/abtJdnyCutYjHNjDKVrkwNsgX/EDzfmm/H4iycYlBeqxIZoqC18tq9U+q7SdxUalAi
        K7BwRzBQ2vZ5AcI2b1zDXRwZC+RQwTQsnmdwxBY3Um+I3uCmSXtOmpkMGRWQblZqlVjxqSv7N7CXC
        K3Lxiy1Q==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1k6cVH-0002J2-Id; Fri, 14 Aug 2020 10:24:28 -0600
To:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Christoph Hellwig <hch@lst.de>
References: <20200814061815.536540-1-sagi@grimberg.me>
 <20200814061815.536540-4-sagi@grimberg.me>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <3418d9be-7f2d-7d01-9a82-25cd79ac8bce@deltatee.com>
Date:   Fri, 14 Aug 2020 10:24:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200814061815.536540-4-sagi@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: hch@lst.de, Chaitanya.Kulkarni@wdc.com, bvanassche@acm.org, kbusch@kernel.org, osandov@osandov.com, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, sagi@grimberg.me
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,NICE_REPLY_A autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH v4 3/7] nvme: make tests transport type agnostic
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020-08-14 12:18 a.m., Sagi Grimberg wrote:
>  _nvme_disconnect_ctrl() {
> @@ -112,20 +121,33 @@ _nvme_disconnect_subsys() {
>  _nvme_connect_subsys() {
>  	local trtype="$1"
>  	local subsysnqn="$2"
> +	local traddr="${3:-$def_traddr}"
> +	local trsvcid="${4:-$def_trsvcid}"
>  
>  	cmd="nvme connect -t ${trtype} -n ${subsysnqn}"
> +	if [[ "${trtype}" != "loop" ]]; then
> +		cmd=$cmd" -a ${traddr} -s ${trsvcid}"
> +	fi
>  	eval $cmd
>  }

I think this pattern would be done better with a bash array instead of
an eval, which will get the quoting correct:

ARGS=(-t "${trtype}" -n "${subsysnqn}")
if [[ "${trtype}" != "loop" ]]; then
    ARGS+=(-a "${traddr}" -s "${trsvcid}")
fi
nvme connect "${ARGS[@]}"

