Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 749B334EF87
	for <lists+linux-block@lfdr.de>; Tue, 30 Mar 2021 19:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbhC3Rb2 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 30 Mar 2021 13:31:28 -0400
Received: from verein.lst.de ([213.95.11.211]:59932 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232259AbhC3RbR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Mar 2021 13:31:17 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9836968B05; Tue, 30 Mar 2021 19:31:13 +0200 (CEST)
Date:   Tue, 30 Mar 2021 19:31:13 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Khalid Aziz <khalid@gonehiking.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Ondrej Zary <linux@rainbow-software.org>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 2/8] Buslogic: remove ISA support
Message-ID: <20210330173113.GA14707@lst.de>
References: <20210326055822.1437471-1-hch@lst.de> <20210326055822.1437471-3-hch@lst.de> <90427abe-f0a3-c6fc-a674-7a3967e20882@gonehiking.org> <20210330170320.GC13829@lst.de> <45e94e2d-e359-732b-f704-a789774ed901@gonehiking.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45e94e2d-e359-732b-f704-a789774ed901@gonehiking.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 30, 2021 at 11:15:22AM -0600, Khalid Aziz wrote:
> Awesome! Thanks. Updates to Documentation/scsi/BusLogic.rst to match
> these changes would be great. Doc currently lists "IO:" and "NoProbeISA"
> which can go away. "Supported Host Adapters: section lists ISA and EISA
> adapters that can go away as well. There is reference to ISA in
> "QueueDepth:<integer>" - "For Host Adapters that require ISA Bounce
> Buffers, the Queue Depth is automatically set by default to
> BusLogic_TaggedQueueDepthBB or BusLogic_UntaggedQueueDepthBB to avoid
> excessive preallocation of DMA Bounce Buffer memory." which is
> irrelevant now.

Thanks, I've added these changes as well.
