Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A94245C61
	for <lists+linux-block@lfdr.de>; Mon, 17 Aug 2020 08:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgHQGW2 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 17 Aug 2020 02:22:28 -0400
Received: from verein.lst.de ([213.95.11.211]:55170 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726235AbgHQGW1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Aug 2020 02:22:27 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0D0A567357; Mon, 17 Aug 2020 08:22:25 +0200 (CEST)
Date:   Mon, 17 Aug 2020 08:22:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, hch@lst.de,
        baolin.wang7@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 2/5] block: Remove redundant
 blk_mq_sched_allow_merge() validation
Message-ID: <20200817062224.GB12248@lst.de>
References: <cover.1597637287.git.baolin.wang@linux.alibaba.com> <b9d51f4bc9f0ff4ec3b8fb7fa6dc366afd69290e.1597637287.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9d51f4bc9f0ff4ec3b8fb7fa6dc366afd69290e.1597637287.git.baolin.wang@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 17, 2020 at 12:09:16PM +0800, Baolin Wang wrote:
> Only software queue and kyber IO scheduler will call blk_mq_bio_list_merge()
> to merge a bio, and kyber IO scheduler did not implement the ops->allow_merge().

Please line wrap your changelogs after 73 characters.

> Thus we can remove the redundant blk_mq_sched_allow_merge() in
> blk_mq_bio_list_merge() function.

This seems potentially dangerous, and I don't think it really buys
us much.
