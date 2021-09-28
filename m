Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6F641A71E
	for <lists+linux-block@lfdr.de>; Tue, 28 Sep 2021 07:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbhI1F3e (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 28 Sep 2021 01:29:34 -0400
Received: from verein.lst.de ([213.95.11.211]:50094 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234213AbhI1F3a (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Sep 2021 01:29:30 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5E11A67373; Tue, 28 Sep 2021 07:27:50 +0200 (CEST)
Date:   Tue, 28 Sep 2021 07:27:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 7/7] blk-mq: build default queue map via
 group_cpus_evenly()
Message-ID: <20210928052749.GC29020@lst.de>
References: <20210928005558.243352-1-ming.lei@redhat.com> <20210928005558.243352-8-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928005558.243352-8-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
