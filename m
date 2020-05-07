Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06FEE1C8280
	for <lists+linux-block@lfdr.de>; Thu,  7 May 2020 08:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725849AbgEGG1s (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 7 May 2020 02:27:48 -0400
Received: from verein.lst.de ([213.95.11.211]:44818 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbgEGG1r (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 May 2020 02:27:47 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6109268C7B; Thu,  7 May 2020 08:27:44 +0200 (CEST)
Date:   Thu, 7 May 2020 08:27:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, hdegoede@redhat.com,
        gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: PING for Re: bdi: fix use-after-free for dev_name(bdi->dev) v3
 (resend)
Message-ID: <20200507062743.GA5814@lst.de>
References: <20200504124801.2832087-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504124801.2832087-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 04, 2020 at 02:47:52PM +0200, Christoph Hellwig wrote:
> Hi Jens,
> 
> can you pick up this series?

ping?  Especially as 1-4 fix a kernel crash and should probably be
5.7 material.
