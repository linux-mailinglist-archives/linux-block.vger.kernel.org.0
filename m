Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5596C34A6EF
	for <lists+linux-block@lfdr.de>; Fri, 26 Mar 2021 13:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhCZMOY (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 26 Mar 2021 08:14:24 -0400
Received: from verein.lst.de ([213.95.11.211]:45475 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229744AbhCZMOB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Mar 2021 08:14:01 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 529B367373; Fri, 26 Mar 2021 13:13:59 +0100 (CET)
Date:   Fri, 26 Mar 2021 13:13:59 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     yanfei.xu@windriver.com
Cc:     hch@lst.de, axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: export disk_part_iter_* helpers
Message-ID: <20210326121359.GA14989@lst.de>
References: <20210326121059.597172-1-yanfei.xu@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326121059.597172-1-yanfei.xu@windriver.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 26, 2021 at 08:10:59PM +0800, yanfei.xu@windriver.com wrote:
> From: Yanfei Xu <yanfei.xu@windriver.com>
> 
> disk_part_iter_* helpers might be used by other external modules, like
> lttng-modules. But it was unexport in 'commit bc359d03c7ec ("block: add
> a disk_uevent helper")'. Here export them again.

Err, no.  We never export things for out of tree modules.  And any kind
of driver code has absolutely no business looking at the partition tables
to start with, modular or not.
