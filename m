Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A653EE5D7
	for <lists+linux-block@lfdr.de>; Tue, 17 Aug 2021 06:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237376AbhHQErR (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 17 Aug 2021 00:47:17 -0400
Received: from verein.lst.de ([213.95.11.211]:56999 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234145AbhHQErP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Aug 2021 00:47:15 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1881D6736F; Tue, 17 Aug 2021 06:46:41 +0200 (CEST)
Date:   Tue, 17 Aug 2021 06:46:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/7] genirq/affinity: pass affinity managed mask array
 to irq_build_affinity_masks
Message-ID: <20210817044640.GB3874@lst.de>
References: <20210814123532.229494-1-ming.lei@redhat.com> <20210814123532.229494-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210814123532.229494-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
