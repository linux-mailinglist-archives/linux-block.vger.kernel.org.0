Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8702860C8
	for <lists+linux-block@lfdr.de>; Wed,  7 Oct 2020 16:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgJGOBN (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 7 Oct 2020 10:01:13 -0400
Received: from verein.lst.de ([213.95.11.211]:37466 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728177AbgJGOBM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 7 Oct 2020 10:01:12 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A20626736F; Wed,  7 Oct 2020 16:01:09 +0200 (CEST)
Date:   Wed, 7 Oct 2020 16:01:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        sth@linux.ibm.com, linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH] partitions/ibm: fix non-DASD devices
Message-ID: <20201007140109.GA1042@lst.de>
References: <20201007124009.1438269-1-hch@lst.de> <a8b1c076-c280-d201-8403-2392a42d2163@kernel.dk> <20201007135411.GA1000@lst.de> <874c518d-7c15-d08a-61a2-116f605c4b5a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874c518d-7c15-d08a-61a2-116f605c4b5a@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 07, 2020 at 07:54:45AM -0600, Jens Axboe wrote:
> On 10/7/20 7:54 AM, Christoph Hellwig wrote:
> > On Wed, Oct 07, 2020 at 07:53:27AM -0600, Jens Axboe wrote:
> >> On 10/7/20 6:40 AM, Christoph Hellwig wrote:
> >>> Don't error out if the dasd_biodasdinfo symbol is not available.
> >>
> >> Should this be marked for 5.8-stable?
> > 
> > The Fixes tag should automatically take care of that.
> 
> Not if it's not marked for stable. Maybe auto-selection will pick it
> up, but it's not a given.

Yes, trivial patches with a fixes tag get reliably picked out.  But
if you don't trust the system feel free to add a stable tag.
