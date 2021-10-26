Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D47243AD1D
	for <lists+linux-block@lfdr.de>; Tue, 26 Oct 2021 09:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbhJZHXu (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 26 Oct 2021 03:23:50 -0400
Received: from verein.lst.de ([213.95.11.211]:60732 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233064AbhJZHXt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Oct 2021 03:23:49 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 06EA46732D; Tue, 26 Oct 2021 09:21:24 +0200 (CEST)
Date:   Tue, 26 Oct 2021 09:21:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/8] loop: move flush_dcache_page to ->complete of
 request
Message-ID: <20211026072123.GA31967@lst.de>
References: <20211025094437.2837701-1-ming.lei@redhat.com> <20211025094437.2837701-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025094437.2837701-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
