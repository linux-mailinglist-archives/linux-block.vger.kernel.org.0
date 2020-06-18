Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764541FF811
	for <lists+linux-block@lfdr.de>; Thu, 18 Jun 2020 17:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbgFRPwN (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 18 Jun 2020 11:52:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:34272 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728212AbgFRPwM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 11:52:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BE1FCADC8;
        Thu, 18 Jun 2020 15:52:10 +0000 (UTC)
Date:   Thu, 18 Jun 2020 17:52:10 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 05/12] blk-mq: short cut the IPI path in
 blk_mq_force_complete_rq for !SMP
Message-ID: <20200618155210.qozt54zi7265vozj@beryllium.lan>
References: <20200611064452.12353-1-hch@lst.de>
 <20200611064452.12353-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611064452.12353-6-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 11, 2020 at 08:44:45AM +0200, Christoph Hellwig wrote:
> Let the compile optimize out the entire IPI path, given that we are
> obviously not going to use it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Daniel Wagner <dwagner@suse.de>


