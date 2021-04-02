Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03E9352931
	for <lists+linux-block@lfdr.de>; Fri,  2 Apr 2021 12:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhDBKA4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 2 Apr 2021 06:00:56 -0400
Received: from verein.lst.de ([213.95.11.211]:43159 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229605AbhDBKA4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 2 Apr 2021 06:00:56 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7BD1F68BEB; Fri,  2 Apr 2021 12:00:53 +0200 (CEST)
Date:   Fri, 2 Apr 2021 12:00:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 0/3] blk-mq: Fix a race between iterating over
 requests and freeing requests
Message-ID: <20210402100053.GA14047@lst.de>
References: <20210329020028.18241-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329020028.18241-1-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
