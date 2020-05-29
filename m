Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99271E8245
	for <lists+linux-block@lfdr.de>; Fri, 29 May 2020 17:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgE2PmR (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 29 May 2020 11:42:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:45586 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbgE2PmQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 May 2020 11:42:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 58E6AACB8;
        Fri, 29 May 2020 15:42:15 +0000 (UTC)
Date:   Fri, 29 May 2020 17:42:14 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        alan.adamson@oracle.com
Subject: Re: [PATCHv4 1/2] blk-mq: blk-mq: provide forced completion method
Message-ID: <20200529154214.k4tl3uhtdg5sftex@beryllium.lan>
References: <20200529145200.3545747-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529145200.3545747-1-kbusch@kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 29, 2020 at 07:51:59AM -0700, Keith Busch wrote:
> Drivers may need to bypass error injection for error recovery. Rename
> __blk_mq_complete_request() to blk_mq_force_complete_rq() and export
> that function so drivers may skip potential fake timeouts after they've
> reclaimed lost requests.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Reviewed-by: Daniel Wagner <dwagner@suse.de>
