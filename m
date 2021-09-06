Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0B94018CD
	for <lists+linux-block@lfdr.de>; Mon,  6 Sep 2021 11:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241255AbhIFJ2N (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 6 Sep 2021 05:28:13 -0400
Received: from verein.lst.de ([213.95.11.211]:60744 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241166AbhIFJ2N (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 6 Sep 2021 05:28:13 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8E34767373; Mon,  6 Sep 2021 11:27:06 +0200 (CEST)
Date:   Mon, 6 Sep 2021 11:27:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hou Tao <houtao1@huawei.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, nbd@other.debian.org, hch@lst.de
Subject: Re: [PATCH v2 1/3] nbd: use pr_err to output error message
Message-ID: <20210906092706.GA30790@lst.de>
References: <20210904122519.1963983-1-houtao1@huawei.com> <20210904122519.1963983-2-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210904122519.1963983-2-houtao1@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
