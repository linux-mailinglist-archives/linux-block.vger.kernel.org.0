Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEFE53562F1
	for <lists+linux-block@lfdr.de>; Wed,  7 Apr 2021 07:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344706AbhDGFR7 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 7 Apr 2021 01:17:59 -0400
Received: from verein.lst.de ([213.95.11.211]:57407 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229603AbhDGFR7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 7 Apr 2021 01:17:59 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E8E2968B05; Wed,  7 Apr 2021 07:17:48 +0200 (CEST)
Date:   Wed, 7 Apr 2021 07:17:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH] blk-zoned: Remove the definition of blk_zone_start()
Message-ID: <20210407051748.GA18319@lst.de>
References: <20210406200820.15180-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406200820.15180-1-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
