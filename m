Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE2C498101
	for <lists+linux-block@lfdr.de>; Mon, 24 Jan 2022 14:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243090AbiAXN2W (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 24 Jan 2022 08:28:22 -0500
Received: from verein.lst.de ([213.95.11.211]:55816 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243074AbiAXN2W (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jan 2022 08:28:22 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id A5A4968BEB; Mon, 24 Jan 2022 14:28:18 +0100 (CET)
Date:   Mon, 24 Jan 2022 14:28:18 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH V2 12/13] block: move rq_qos_exit() into disk_release()
Message-ID: <20220124132818.GA27997@lst.de>
References: <20220122111054.1126146-1-ming.lei@redhat.com> <20220122111054.1126146-13-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220122111054.1126146-13-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Jan 22, 2022 at 07:10:53PM +0800, Ming Lei wrote:
> There can't be FS IO in disk_release(), so it is safe to move rq_qos_exit()
> there.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
