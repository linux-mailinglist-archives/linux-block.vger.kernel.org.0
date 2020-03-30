Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE781975DB
	for <lists+linux-block@lfdr.de>; Mon, 30 Mar 2020 09:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbgC3HjO (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 30 Mar 2020 03:39:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:42770 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729425AbgC3HjO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Mar 2020 03:39:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4706EAE4D;
        Mon, 30 Mar 2020 07:39:13 +0000 (UTC)
Date:   Mon, 30 Mar 2020 09:39:12 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH blktests v4 4/4] Add a test that triggers the
 blk_mq_realloc_hw_ctxs() error path
Message-ID: <20200330073912.wm2rozdfpu737kmf@beryllium.lan>
References: <20200328182251.19945-1-bvanassche@acm.org>
 <20200328182251.19945-5-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200328182251.19945-5-bvanassche@acm.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Bart,

On Sat, Mar 28, 2020 at 11:22:51AM -0700, Bart Van Assche wrote:
> Add a test that triggers the code touched by commit d0930bb8f46b ("blk-mq:
> Fix a recently introduced regression in blk_mq_realloc_hw_ctxs()"). This
> test only runs if a recently added fault injection feature is available,
> namely commit 596444e75705 ("null_blk: Add support for init_hctx() fault
> injection").
> 
> Cc: Ming Lei <ming.lei@redhat.com>
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

Thanks,
Daniel
