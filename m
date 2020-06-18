Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34571FF95F
	for <lists+linux-block@lfdr.de>; Thu, 18 Jun 2020 18:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgFRQjJ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 18 Jun 2020 12:39:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:51980 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728929AbgFRQjJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 12:39:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 98088ABCE;
        Thu, 18 Jun 2020 16:39:07 +0000 (UTC)
Date:   Thu, 18 Jun 2020 18:39:07 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 10/12] blk-mq: add a new blk_mq_complete_request_remote
 API
Message-ID: <20200618163907.e43oml4dvvix6eko@beryllium.lan>
References: <20200611064452.12353-1-hch@lst.de>
 <20200611064452.12353-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611064452.12353-11-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 11, 2020 at 08:44:50AM +0200, Christoph Hellwig wrote:
> This is a variant of blk_mq_complete_request_remote that only completes
> the request if it needs to be bounced to another CPU or a softirq.  If
> the request can be completed locally the function returns false and lets
> the driver complete it without requring and indirect function call.

s/requring/requiring/

> Suggestions for a better name welcome.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Daniel Wagner <dwagner@suse.de>
