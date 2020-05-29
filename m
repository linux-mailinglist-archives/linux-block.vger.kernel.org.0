Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9581E808F
	for <lists+linux-block@lfdr.de>; Fri, 29 May 2020 16:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgE2OlZ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 29 May 2020 10:41:25 -0400
Received: from verein.lst.de ([213.95.11.211]:33325 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727793AbgE2OlZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 May 2020 10:41:25 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B6DA768BFE; Fri, 29 May 2020 16:41:21 +0200 (CEST)
Date:   Fri, 29 May 2020 16:41:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        alan.adamson@oracle.com
Subject: Re: [PATCHv3 1/2] blk-mq: export blk_mq_force_complete_rq
Message-ID: <20200529144121.GA4987@lst.de>
References: <20200529143744.3545429-1-kbusch@kernel.org> <20200529143744.3545429-2-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529143744.3545429-2-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 29, 2020 at 07:37:43AM -0700, Keith Busch wrote:
> For when drivers have a need to bypass error injection.

The subject doesn't quite match the content, and the commit log in
general could be a little more verbose.  The changes itself look
fine to me.
