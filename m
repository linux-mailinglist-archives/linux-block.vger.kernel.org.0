Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC6A036B4FC
	for <lists+linux-block@lfdr.de>; Mon, 26 Apr 2021 16:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbhDZOgm (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 26 Apr 2021 10:36:42 -0400
Received: from verein.lst.de ([213.95.11.211]:41532 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232575AbhDZOgl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Apr 2021 10:36:41 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 79A7668C4E; Mon, 26 Apr 2021 16:35:58 +0200 (CEST)
Date:   Mon, 26 Apr 2021 16:35:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        Yuanyuan Zhong <yzhong@purestorage.com>,
        Casey Chen <cachen@purestorage.com>
Subject: Re: [PATCHv2 2/5] nvme: use blk_execute_rq() for passthrough
 commands
Message-ID: <20210426143558.GB20668@lst.de>
References: <20210423220558.40764-1-kbusch@kernel.org> <20210423220558.40764-3-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423220558.40764-3-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
