Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 315EA1FF98F
	for <lists+linux-block@lfdr.de>; Thu, 18 Jun 2020 18:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732032AbgFRQrq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 18 Jun 2020 12:47:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:55016 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728090AbgFRQrp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 12:47:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0693AACC3;
        Thu, 18 Jun 2020 16:47:43 +0000 (UTC)
Date:   Thu, 18 Jun 2020 18:47:44 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 12/12] nvme: use blk_mq_complete_request_remote to avoid
 an indirect function call
Message-ID: <20200618164744.f2kba2s3yvlcz4s5@beryllium.lan>
References: <20200611064452.12353-1-hch@lst.de>
 <20200611064452.12353-13-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611064452.12353-13-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 11, 2020 at 08:44:52AM +0200, Christoph Hellwig wrote:
> Use the new blk_mq_complete_request_remote helper to avoid an indirect
> function call in the completion fast path.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Daniel Wagner <dwagner@suse.de>
