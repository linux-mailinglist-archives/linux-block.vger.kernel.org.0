Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B762A3D7A68
	for <lists+linux-block@lfdr.de>; Tue, 27 Jul 2021 18:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbhG0QC3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 27 Jul 2021 12:02:29 -0400
Received: from verein.lst.de ([213.95.11.211]:50470 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229580AbhG0QC2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jul 2021 12:02:28 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6DD8867357; Tue, 27 Jul 2021 18:02:26 +0200 (CEST)
Date:   Tue, 27 Jul 2021 18:02:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: use regular gendisk registration in device mapper
Message-ID: <20210727160226.GA17989@lst.de>
References: <20210725055458.29008-1-hch@lst.de> <YQAtNkd8T1w/cSLc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQAtNkd8T1w/cSLc@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 27, 2021 at 11:58:46AM -0400, Mike Snitzer wrote:
> > This did not make a different to my testing
> > using dmsetup and the lvm2 tools.
> 
> I'll try these changes running through the lvm2 testsuite.

Btw, is ther documentation on how to run it somewhere?  I noticed
tests, old-tests and unit-tests directories, but no obvious way
to run them.
