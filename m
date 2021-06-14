Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB413A5C8F
	for <lists+linux-block@lfdr.de>; Mon, 14 Jun 2021 07:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbhFNFwY (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 14 Jun 2021 01:52:24 -0400
Received: from verein.lst.de ([213.95.11.211]:42440 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231968AbhFNFwX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jun 2021 01:52:23 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B670567373; Mon, 14 Jun 2021 07:50:19 +0200 (CEST)
Date:   Mon, 14 Jun 2021 07:50:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        Yuanyuan Zhong <yzhong@purestorage.com>,
        Casey Chen <cachen@purestorage.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCHv4 4/4] nvme: use return value from blk_execute_rq()
Message-ID: <20210614055019.GB27731@lst.de>
References: <20210610214437.641245-1-kbusch@kernel.org> <20210610214437.641245-5-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610214437.641245-5-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
