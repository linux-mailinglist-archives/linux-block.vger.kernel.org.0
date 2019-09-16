Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00E56B35F3
	for <lists+linux-block@lfdr.de>; Mon, 16 Sep 2019 09:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbfIPHv4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 16 Sep 2019 03:51:56 -0400
Received: from verein.lst.de ([213.95.11.211]:42930 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbfIPHvz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Sep 2019 03:51:55 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2AE1668B05; Mon, 16 Sep 2019 09:51:52 +0200 (CEST)
Date:   Mon, 16 Sep 2019 09:51:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        martin.petersen@oracle.com, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, hch@lst.de, sagi@grimberg.me,
        shlomin@mellanox.com, israelr@mellanox.com
Subject: Re: [PATCH v6 1/2] block: use symbolic constants for t10_pi type
Message-ID: <20190916075151.GA25796@lst.de>
References: <1568493253-18142-1-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568493253-18142-1-git-send-email-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Sep 14, 2019 at 11:34:12PM +0300, Max Gurtovoy wrote:
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>

A little bit of a changelog would have been nice, but otherwise this
looks fine to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
