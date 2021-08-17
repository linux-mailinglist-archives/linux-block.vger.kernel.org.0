Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBF53EE5EF
	for <lists+linux-block@lfdr.de>; Tue, 17 Aug 2021 06:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbhHQEx3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 17 Aug 2021 00:53:29 -0400
Received: from verein.lst.de ([213.95.11.211]:57022 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230272AbhHQEx3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Aug 2021 00:53:29 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 680206736F; Tue, 17 Aug 2021 06:52:55 +0200 (CEST)
Date:   Tue, 17 Aug 2021 06:52:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 6/7] lib/group_cpus: allow to group cpus in case of
 !CONFIG_SMP
Message-ID: <20210817045255.GF3874@lst.de>
References: <20210814123532.229494-1-ming.lei@redhat.com> <20210814123532.229494-7-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210814123532.229494-7-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Aug 14, 2021 at 08:35:31PM +0800, Ming Lei wrote:
> Allows group_cpus_evenly() to be called in case of !CONFIG_SMP by simply
> assigning all CPUs into the 1st group.

Looks good, but almost too large for an inline function.
