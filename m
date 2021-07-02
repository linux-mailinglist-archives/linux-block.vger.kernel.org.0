Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72D23BA2C7
	for <lists+linux-block@lfdr.de>; Fri,  2 Jul 2021 17:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhGBPdz (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 2 Jul 2021 11:33:55 -0400
Received: from verein.lst.de ([213.95.11.211]:50742 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229854AbhGBPdz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 2 Jul 2021 11:33:55 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 50BDA67373; Fri,  2 Jul 2021 17:31:21 +0200 (CEST)
Date:   Fri, 2 Jul 2021 17:31:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] loop: remove unused variable in loop_set_status()
Message-ID: <20210702153121.GA20689@lst.de>
References: <20210702152714.7978-1-penguin-kernel@I-love.SAKURA.ne.jp> <bb8c95b3-b062-131a-d963-5422a0e7933a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb8c95b3-b062-131a-d963-5422a0e7933a@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 02, 2021 at 09:29:26AM -0600, Jens Axboe wrote:
> On 7/2/21 9:27 AM, Tetsuo Handa wrote:
> > Commit 0384264ea8a39bd9 ("block: pass a gendisk to bdev_disk_changed")
> > changed to pass lo->lo_disk instead of lo->lo_device.
> 
> Applied, thanks.

FYI, I also sent a patch on June 25th for this..
