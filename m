Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 764CE5B50B
	for <lists+linux-block@lfdr.de>; Mon,  1 Jul 2019 08:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfGAGbI (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 1 Jul 2019 02:31:08 -0400
Received: from verein.lst.de ([213.95.11.211]:58566 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbfGAGbH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Jul 2019 02:31:07 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E2EB568CEE; Mon,  1 Jul 2019 08:31:06 +0200 (CEST)
Date:   Mon, 1 Jul 2019 08:31:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, hch@lst.de, bvanassche@acm.org,
        axboe@kernel.dk
Subject: Re: [PATCH 5/5] null_blk: create a helper for req completion
Message-ID: <20190701063106.GI20073@lst.de>
References: <20190629050442.8459-1-chaitanya.kulkarni@wdc.com> <20190629050442.8459-6-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190629050442.8459-6-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 28, 2019 at 10:04:42PM -0700, Chaitanya Kulkarni wrote:
> This patch creates a helper function for handling the request
> completion in the null_handle_cmd().
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
