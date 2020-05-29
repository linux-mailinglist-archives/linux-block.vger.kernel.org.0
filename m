Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6EEF1E824A
	for <lists+linux-block@lfdr.de>; Fri, 29 May 2020 17:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgE2Pmq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 29 May 2020 11:42:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:45758 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727023AbgE2Pmq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 May 2020 11:42:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B56D1B17D;
        Fri, 29 May 2020 15:42:44 +0000 (UTC)
Date:   Fri, 29 May 2020 17:42:43 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        alan.adamson@oracle.com,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCHv4 2/2] nvme: force complete cancelled requests
Message-ID: <20200529154243.xy6mslkweyveejl2@beryllium.lan>
References: <20200529145200.3545747-1-kbusch@kernel.org>
 <20200529145200.3545747-2-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529145200.3545747-2-kbusch@kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 29, 2020 at 07:52:00AM -0700, Keith Busch wrote:
> Use blk_mq_foce_complete_rq() to bypass fake timeout error injection so
> that request reclaim may proceed.
> 
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Reviewed-by: Daniel Wagner <dwagner@suse.de>
