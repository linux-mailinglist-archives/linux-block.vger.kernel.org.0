Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E791D9B03
	for <lists+linux-block@lfdr.de>; Tue, 19 May 2020 17:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgESPV3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 19 May 2020 11:21:29 -0400
Received: from verein.lst.de ([213.95.11.211]:44553 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728847AbgESPV3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 May 2020 11:21:29 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B3A9768B02; Tue, 19 May 2020 17:21:26 +0200 (CEST)
Date:   Tue, 19 May 2020 17:21:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 3/4] block: Document the bio_vec properties
Message-ID: <20200519152126.GA22286@lst.de>
References: <20200519040737.4531-1-bvanassche@acm.org> <20200519040737.4531-4-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519040737.4531-4-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 18, 2020 at 09:07:36PM -0700, Bart Van Assche wrote:
> Since it is nontrivial that nth_page() does not have to be used for a
> bio_vec, document this.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
