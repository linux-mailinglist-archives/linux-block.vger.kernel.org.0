Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 687E43F8C44
	for <lists+linux-block@lfdr.de>; Thu, 26 Aug 2021 18:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbhHZQfM (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 26 Aug 2021 12:35:12 -0400
Received: from verein.lst.de ([213.95.11.211]:59817 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229787AbhHZQfM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Aug 2021 12:35:12 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4E9226736F; Thu, 26 Aug 2021 18:34:22 +0200 (CEST)
Date:   Thu, 26 Aug 2021 18:34:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Milan Broz <gmazyland@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Hillf Danton <hdanton@sina.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        "Reviewed-by : Tyler Hicks" <tyhicks@linux.microsoft.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 5/8] loop: merge the cryptoloop module into the main
 loop module
Message-ID: <20210826163422.GA28718@lst.de>
References: <20210826133810.3700-1-hch@lst.de> <20210826133810.3700-6-hch@lst.de> <977860f6-efc4-a55e-50e3-c5204fc762c5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <977860f6-efc4-a55e-50e3-c5204fc762c5@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 26, 2021 at 06:31:50PM +0200, Milan Broz wrote:
> the cryptoloop is insecure, most of the encryption modes are deprecated
> (and known to be problematic); util-linux no longer support cryptoloop
> options in losetup.
> 
> Isn't the better way to go just to remove cryptoloop completely?

I'm not sure if we're going to break existing users.  So maybe for now
get rid of the horrible registration interface, an add a patch to
deprecate it with a warning when people actually use it, and then
eventually remove it. 
