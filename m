Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A08B24F4D
	for <lists+linux-block@lfdr.de>; Tue, 21 May 2019 14:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbfEUMxp (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 21 May 2019 08:53:45 -0400
Received: from verein.lst.de ([213.95.11.211]:60098 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbfEUMxp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 May 2019 08:53:45 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id F1EB268AFE; Tue, 21 May 2019 14:53:22 +0200 (CEST)
Date:   Tue, 21 May 2019 14:53:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/3] block: move blk_exit_queue into __blk_release_queue
Message-ID: <20190521125322.GA4577@lst.de>
References: <20190515030310.20393-1-ming.lei@redhat.com> <20190515030310.20393-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515030310.20393-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
