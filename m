Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A57EF1C6E
	for <lists+linux-block@lfdr.de>; Wed,  6 Nov 2019 18:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbfKFRYs (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 6 Nov 2019 12:24:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:39186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728466AbfKFRYr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 Nov 2019 12:24:47 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 691BA217F5;
        Wed,  6 Nov 2019 17:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573061087;
        bh=RE/IsLYOi2qChANIsA+38p9u4anE+4jM8pf89/vGfV8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uRcO8ENWLOSL55xJV8FjH/gc8IsTO1ytR8fzhZkfXV9yI6351IP1hpLpcOto0SHCB
         iwFqwUtI0WqlwOkIxIZLQxLKQKgylzVQtKxcRs/wk2JZT30x7dK4rbQ4WjjhYA/vzl
         CgxQRnCL+r3sbXtu+O3pK3zfMijrb2cJqa+XkVGs=
Date:   Thu, 7 Nov 2019 02:24:39 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/5] block: merge invalidate_partitions into
 rescan_partitions
Message-ID: <20191106172439.GA29853@redsun51.ssa.fujisawa.hgst.com>
References: <20191106151439.30056-1-hch@lst.de>
 <20191106151439.30056-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106151439.30056-3-hch@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 06, 2019 at 04:14:36PM +0100, Christoph Hellwig wrote:
> A lot of the logic in invalidate_partitions and invalidate_partitions

One of these should say 'rescan_partitions'. Otherwise, patch looks good.
