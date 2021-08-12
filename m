Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCD53EA166
	for <lists+linux-block@lfdr.de>; Thu, 12 Aug 2021 11:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235825AbhHLJBF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 12 Aug 2021 05:01:05 -0400
Received: from verein.lst.de ([213.95.11.211]:43485 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235800AbhHLJBF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Aug 2021 05:01:05 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A638467373; Thu, 12 Aug 2021 11:00:38 +0200 (CEST)
Date:   Thu, 12 Aug 2021 11:00:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Dan Schatzberg <schatzberg.dan@gmail.com>
Subject: Re: [PATCH V4 0/7] loop: cleanup charging io to mem/blkcg
Message-ID: <20210812090037.GE2867@lst.de>
References: <20210806080302.298297-1-ming.lei@redhat.com> <20210809064159.GA19070@lst.de> <YRHx/qaKgEqWdXOP@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRHx/qaKgEqWdXOP@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 10, 2021 at 11:26:54AM +0800, Ming Lei wrote:
> Can you share us what your expectations are in the re-write? Such as:
> 
> 1) no impact on normal non-cgroup path
> 2) ...
> 3) ...

Get the call cgroup mess out of this driver entirely?
