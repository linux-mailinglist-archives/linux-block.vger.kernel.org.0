Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90764399A48
	for <lists+linux-block@lfdr.de>; Thu,  3 Jun 2021 07:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbhFCFuk (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 3 Jun 2021 01:50:40 -0400
Received: from verein.lst.de ([213.95.11.211]:60403 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229635AbhFCFuk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 3 Jun 2021 01:50:40 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 25F5F68AFE; Thu,  3 Jun 2021 07:48:54 +0200 (CEST)
Date:   Thu, 3 Jun 2021 07:48:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Colin King <colin.king@canonical.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] null_blk: Fix null pointer dereference on
 nullb->disk on blk_cleanup_disk call
Message-ID: <20210603054853.GA2650@lst.de>
References: <20210602100659.11058-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602100659.11058-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
