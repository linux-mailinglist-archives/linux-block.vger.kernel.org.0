Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9786BB360A
	for <lists+linux-block@lfdr.de>; Mon, 16 Sep 2019 09:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbfIPH7a (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 16 Sep 2019 03:59:30 -0400
Received: from verein.lst.de ([213.95.11.211]:42946 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbfIPH73 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Sep 2019 03:59:29 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3E90D68B05; Mon, 16 Sep 2019 09:59:26 +0200 (CEST)
Date:   Mon, 16 Sep 2019 09:59:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        martin.petersen@oracle.com, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, hch@lst.de, sagi@grimberg.me,
        shlomin@mellanox.com, israelr@mellanox.com
Subject: Re: [PATCH 2/2] block: centralize PI remapping logic to the block
 layer
Message-ID: <20190916075925.GB25796@lst.de>
References: <1568493253-18142-1-git-send-email-maxg@mellanox.com> <1568493253-18142-2-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568493253-18142-2-git-send-email-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
