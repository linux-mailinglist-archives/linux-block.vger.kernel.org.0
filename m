Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFB8810A25B
	for <lists+linux-block@lfdr.de>; Tue, 26 Nov 2019 17:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfKZQnB (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 26 Nov 2019 11:43:01 -0500
Received: from verein.lst.de ([213.95.11.211]:41638 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727532AbfKZQnB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Nov 2019 11:43:01 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id D81B068C4E; Tue, 26 Nov 2019 17:42:58 +0100 (CET)
Date:   Tue, 26 Nov 2019 17:42:58 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Ming Lei <ming.lei@redhat.com>,
        Bart van Assche <bvanassche@acm.org>,
        John Garry <john.garry@huawei.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 3/8] blk-mq: Use a pointer for sbitmap
Message-ID: <20191126164258.GA8108@lst.de>
References: <20191126131009.71726-1-hare@suse.de> <20191126131009.71726-4-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126131009.71726-4-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 26, 2019 at 02:10:04PM +0100, Hannes Reinecke wrote:
> Instead of allocating the tag bitmap in place we should be using a
> pointer. This is in preparation for shared host-wide bitmaps.

We should is a rather vague statement that needs to be followed up by
an actual reason.
