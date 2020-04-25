Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3101B8480
	for <lists+linux-block@lfdr.de>; Sat, 25 Apr 2020 09:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgDYH7J (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 25 Apr 2020 03:59:09 -0400
Received: from verein.lst.de ([213.95.11.211]:38961 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbgDYH7J (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Apr 2020 03:59:09 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id AC15E68C4E; Sat, 25 Apr 2020 09:59:06 +0200 (CEST)
Date:   Sat, 25 Apr 2020 09:59:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, hdegoede@redhat.com,
        gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: bdi: fix use-after-free for dev_name(bdi->dev) v3
Message-ID: <20200425075906.GA5250@lst.de>
References: <20200422073851.303714-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422073851.303714-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Any more comments?  Are we ready to merge this now?

On Wed, Apr 22, 2020 at 09:38:42AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> the first three patches are my take on the proposal from Yufen Yu
> to fix the use after free of the device name of the bdi device.
> 
> The rest is vaguely related cleanups.
> 
> Changes since v2:
>  - switch vboxsf to a shorter bdi name
> 
> Changes since v1:
>  - use a static dev_name buffer inside struct backing_dev_info
---end quoted text---
