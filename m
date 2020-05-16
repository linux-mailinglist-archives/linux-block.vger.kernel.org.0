Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3611D60D8
	for <lists+linux-block@lfdr.de>; Sat, 16 May 2020 14:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgEPMiF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 16 May 2020 08:38:05 -0400
Received: from verein.lst.de ([213.95.11.211]:60417 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbgEPMiE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 May 2020 08:38:04 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id AE09368B05; Sat, 16 May 2020 14:38:01 +0200 (CEST)
Date:   Sat, 16 May 2020 14:38:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Coly Li <colyli@suse.de>
Cc:     linux-block@vger.kernel.org, damien.lemoal@wdc.com, hare@suse.com,
        hch@lst.de, axboe@kernel.dk, linux-bcache@vger.kernel.org,
        kbusch@kernel.org, Hannes Reinecke <hare@suse.de>,
        Jens Axboe <axboe@fb.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shaun Tancheff <shaun.tancheff@seagate.com>
Subject: Re: [RFC PATCH v2 1/4] block: change REQ_OP_ZONE_RESET from 6 to 13
Message-ID: <20200516123801.GB13448@lst.de>
References: <20200516035434.82809-1-colyli@suse.de> <20200516035434.82809-2-colyli@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200516035434.82809-2-colyli@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, May 16, 2020 at 11:54:31AM +0800, Coly Li wrote:
> For a zoned device, e.g. host managed SMR hard drive, REQ_OP_ZONE_RESET
> is to reset the LBA of a zone's write pointer back to the start LBA of
> this zone. After the write point is reset, all previously stored data
> in this zone is invalid and unaccessible anymore. Therefore, this op
> code changes on disk data, belongs to a WRITE request op code.
> 
> Current REQ_OP_ZONE_RESET is defined as number 6, but the convention of
> the op code is, READ requests are even numbers, and WRITE requests are
> odd numbers. See how op_is_write defined,

The convention is all about data transfer, and zone reset does not
transfer any data.
