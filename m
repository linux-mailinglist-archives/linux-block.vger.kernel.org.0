Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A4B4447B1
	for <lists+linux-block@lfdr.de>; Wed,  3 Nov 2021 18:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhKCRvk (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 3 Nov 2021 13:51:40 -0400
Received: from verein.lst.de ([213.95.11.211]:60613 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229888AbhKCRvh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Nov 2021 13:51:37 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id BFD1168AA6; Wed,  3 Nov 2021 18:48:56 +0100 (CET)
Date:   Wed, 3 Nov 2021 18:48:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, hch@lst.de, penguin-kernel@i-love.sakura.ne.jp,
        dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, richard@nod.at,
        miquel.raynal@bootlin.com, vigneshr@ti.com, efremov@linux.com,
        song@kernel.org, martin.petersen@oracle.com, hare@suse.de,
        jack@suse.cz, ming.lei@redhat.com, tj@kernel.org,
        linux-mtd@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 12/13] block: fix __register_blkdev() probe
 add_disk() failures
Message-ID: <20211103174856.GA7034@lst.de>
References: <20211103174521.1426407-1-mcgrof@kernel.org> <20211103174521.1426407-13-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103174521.1426407-13-mcgrof@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Sorry for being annoying, but I think this really should be three
patches: the documentation fix and one each for the two floppy
drivers.  And the two floppy probe routines would probably
benefit from using goto unwinding as well.
