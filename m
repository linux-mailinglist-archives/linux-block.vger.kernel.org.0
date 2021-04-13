Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B9D35D92A
	for <lists+linux-block@lfdr.de>; Tue, 13 Apr 2021 09:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbhDMHoi (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 13 Apr 2021 03:44:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:49628 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242903AbhDMHoh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Apr 2021 03:44:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7348BAC6E;
        Tue, 13 Apr 2021 07:44:16 +0000 (UTC)
Date:   Tue, 13 Apr 2021 09:44:15 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        John Garry <john.garry@huawei.com>,
        Khazhy Kumykov <khazhy@google.com>
Subject: Re: [PATCH v6 1/5] blk-mq: Move the elevator_exit() definition
Message-ID: <20210413074415.li54p7ktpmcm55g4@beryllium.lan>
References: <20210406214905.21622-1-bvanassche@acm.org>
 <20210406214905.21622-2-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406214905.21622-2-bvanassche@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 06, 2021 at 02:49:01PM -0700, Bart Van Assche wrote:
> Since elevator_exit() has only one caller, move its definition from
> block/blk.h into block/elevator.c. Remove the inline keyword since modern
> compilers are smart enough to decide when to inline functions that occur
> in the same compilation unit.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Martin K. Petersen <martin.petersen@oracle.com>
> Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Khazhy Kumykov <khazhy@google.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

