Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0514644454C
	for <lists+linux-block@lfdr.de>; Wed,  3 Nov 2021 17:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbhKCQIl (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 3 Nov 2021 12:08:41 -0400
Received: from verein.lst.de ([213.95.11.211]:60047 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232749AbhKCQIl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Nov 2021 12:08:41 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 79E7368AA6; Wed,  3 Nov 2021 17:06:02 +0100 (CET)
Date:   Wed, 3 Nov 2021 17:06:02 +0100
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
Subject: Re: [PATCH v2 05/13] nvdimm/blk: add error handling support for
 add_disk()
Message-ID: <20211103160602.GE31562@lst.de>
References: <20211103122157.1215783-1-mcgrof@kernel.org> <20211103122157.1215783-6-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103122157.1215783-6-mcgrof@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
