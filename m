Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C437FFC8E8
	for <lists+linux-block@lfdr.de>; Thu, 14 Nov 2019 15:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfKNOcs (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 14 Nov 2019 09:32:48 -0500
Received: from verein.lst.de ([213.95.11.211]:39909 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbfKNOcr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Nov 2019 09:32:47 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id CDCB868B05; Thu, 14 Nov 2019 15:32:45 +0100 (CET)
Date:   Thu, 14 Nov 2019 15:32:45 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: disk revalidation cleanups and fixlets
Message-ID: <20191114143245.GB1591@lst.de>
References: <20191106151439.30056-1-hch@lst.de> <e994fc4b-cc72-c2db-cc2c-754a0aa03057@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e994fc4b-cc72-c2db-cc2c-754a0aa03057@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 14, 2019 at 07:08:55AM -0700, Jens Axboe wrote:
> On 11/6/19 8:14 AM, Christoph Hellwig wrote:
> > Hi Jens and Jan,
> > 
> > this series takes the disk size change detection and revalidations
> > from Jan a step further and fully integrate the code path for
> > partitioned vs non-partitioned devices.  It also fixes up a few
> > bits where we have unintentionally differing behavior.
> > 
> 
> Were you going to re-send this on top of the other stuff for 5.5?
> If so, should probably get queued up...

Hmm.  I am pretty sure I resent it, but I can't find it in the
archives either.  Let me do that now with the typo fix and review
tags added to it.
