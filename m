Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95EAC1FF97C
	for <lists+linux-block@lfdr.de>; Thu, 18 Jun 2020 18:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbgFRQmT (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 18 Jun 2020 12:42:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:52842 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728587AbgFRQmS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 12:42:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BADA6AC22;
        Thu, 18 Jun 2020 16:42:16 +0000 (UTC)
Date:   Thu, 18 Jun 2020 18:42:16 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-block@vger.kernel.org, linux-nvme@lists.infrdead.org
Subject: Re: [PATCH 11/12] nvme-rdma: factor out a nvme_rdma_end_request
 helper
Message-ID: <20200618164216.dpfhijmlrd5xfofn@beryllium.lan>
References: <20200611064452.12353-1-hch@lst.de>
 <20200611064452.12353-12-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611064452.12353-12-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 11, 2020 at 08:44:51AM +0200, Christoph Hellwig wrote:
> Factor a small sniplet of duplicated code into a new helper in
> preparation for making this sniplet a little bit less trivial.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Daniel Wagner <dwagner@suse.de>
