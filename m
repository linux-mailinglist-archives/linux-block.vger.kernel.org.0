Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63D14044F0
	for <lists+linux-block@lfdr.de>; Thu,  9 Sep 2021 07:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350719AbhIIFYC (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 9 Sep 2021 01:24:02 -0400
Received: from verein.lst.de ([213.95.11.211]:41231 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350499AbhIIFYB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 Sep 2021 01:24:01 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9CC8567373; Thu,  9 Sep 2021 07:22:49 +0200 (CEST)
Date:   Thu, 9 Sep 2021 07:22:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, fujita.tomonori@lab.ntt.co.jp,
        axboe@kernel.dk, martin.petersen@oracle.com, hch@lst.de,
        gregkh@linuxfoundation.org, wanghaibin.wang@huawei.com
Subject: Re: [PATCH] scsi: bsg: Fix device unregistration
Message-ID: <20210909052249.GA24029@lst.de>
References: <20210909034608.1435-1-yuzenghui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909034608.1435-1-yuzenghui@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
