Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E03F83D1183
	for <lists+linux-block@lfdr.de>; Wed, 21 Jul 2021 16:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239172AbhGUN47 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 21 Jul 2021 09:56:59 -0400
Received: from verein.lst.de ([213.95.11.211]:59021 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238646AbhGUN46 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jul 2021 09:56:58 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B449A67373; Wed, 21 Jul 2021 16:37:33 +0200 (CEST)
Date:   Wed, 21 Jul 2021 16:37:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Garry <john.garry@huawei.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V5 3/3] blk-mq: don't deactivate hctx if managed irq
 isn't used
Message-ID: <20210721143733.GC11058@lst.de>
References: <20210721091723.1152456-1-ming.lei@redhat.com> <20210721091723.1152456-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721091723.1152456-4-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
