Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6D925DE8F
	for <lists+linux-block@lfdr.de>; Fri,  4 Sep 2020 17:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgIDPw7 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 4 Sep 2020 11:52:59 -0400
Received: from ale.deltatee.com ([204.191.154.188]:48748 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgIDPw6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Sep 2020 11:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=P1djXWMn42vRNOqFDi+hzs5if5OiqHl05S8IjUoubNw=; b=BNQfSmSkjrFR5b9h3T/tVP2ADN
        RGBUOjLEzXEGTAMiUVE43IuRd3f+LCwIlvnBjwtrYJ/NBdb7Z0bIcDTWOVk6XPcFf7plZV1o3DZyX
        ThVvZDmf1d0NC1SXB+mj3UV1dlQtwEYo1R7ge2e2IKQqng4el5QXEvMBZPNG+9dN32vLrotiIxnVe
        Dpld3kW7NMmILNaQ6gkRxX4l7ffoDLuXhE5ZqGSjGtJejddsEUP3S5SVRGc/Q88SUpxG6p3TFzYj0
        YCFEGd+kKstYJAhbTPKFGCZnOGo+o+W4QQ4Q8iyqyexMnbGxGinwBGnStSqe7oKgX4AI+2LwBTwKE
        /nyzQRPw==;
Received: from [172.16.1.162]
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1kEE1E-0007o2-L7; Fri, 04 Sep 2020 09:52:53 -0600
To:     Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@osandov.com>
Cc:     linux-nvme@lists.infradead.org,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20200903235337.527880-1-sagi@grimberg.me>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <862f5256-46ee-c411-425a-8bca27aad35c@deltatee.com>
Date:   Fri, 4 Sep 2020 09:52:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200903235337.527880-1-sagi@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: hch@lst.de, kbusch@kernel.org, Chaitanya.Kulkarni@wdc.com, linux-nvme@lists.infradead.org, osandov@osandov.com, linux-block@vger.kernel.org, sagi@grimberg.me
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,NICE_REPLY_A autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH v7 0/7] blktests: Add support to run nvme tests with
 tcp/rdma transports
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020-09-03 5:53 p.m., Sagi Grimberg wrote:
> We have a collection of nvme tests, but all run with nvme-loop. This
> is the easiest to run on a standalone machine. However its very much possible
> to run nvme-tcp and nvme-rdma using a loopback network. Add capability to run
> tests with a new environment variable to set the transport type $nvme_trtype.
> 
> $ nvme_trtype=[loop|tcp|rdma] ./check nvme
> 
> This buys us some nice coverage on some more transport types. We also add
> some transport type specific helpers to mark tests that are relevant only
> for a single transport.
> 
> Changes from v6:
> - fix _nvme_discover wrong use of subsysnqn that is never passed
> - move shellcheck fixes to the correct patches (not fix in subsequent patches)
> Changes from v5:
> - fix shellcheck errors
> Changes from v4:
> - removed extra paranthesis
> - load either rdma_rxe or siw for rdma transport tests
> Changes from v3:
> - remove unload_module from tests/srp/rc
> - fixed test run cmd
> Changes from v2:
> - changed patch 6 to move unload_module to common/rc
> - changed helper to be named _require_nvme_trtype_is_fabrics
> Changes from v1:
> - added patch to remove use of module_unload
> - move trtype agnostic logig helpers in patch #3
> 
> Sagi Grimberg (7):
>   nvme: consolidate nvme requirements based on transport type
>   nvme: consolidate some nvme-cli utility functions
>   nvme: make tests transport type agnostic
>   tests/nvme: restrict tests to specific transports
>   nvme: support nvme-tcp when runinng tests
>   common: move module_unload to common
>   nvme: support rdma transport type

Looks good to me. For the whole series:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks,

Logan
