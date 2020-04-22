Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4321B4BEF
	for <lists+linux-block@lfdr.de>; Wed, 22 Apr 2020 19:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgDVRk3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 22 Apr 2020 13:40:29 -0400
Received: from verein.lst.de ([213.95.11.211]:53911 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbgDVRk2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Apr 2020 13:40:28 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A5B8C68CEC; Wed, 22 Apr 2020 19:40:26 +0200 (CEST)
Date:   Wed, 22 Apr 2020 19:40:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Martijn Coenen <maco@android.com>
Cc:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com,
        narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        jaegeuk@kernel.org
Subject: Re: [PATCH v2 2/5] loop: Factor out configuring loop from status
Message-ID: <20200422174026.GB30852@lst.de>
References: <20200422100636.46357-1-maco@android.com> <20200422100636.46357-3-maco@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422100636.46357-3-maco@android.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 22, 2020 at 12:06:33PM +0200, Martijn Coenen wrote:
> Factor out this code into a separate function, so it can be reused by
> other code more easily.
> 
> Signed-off-by: Martijn Coenen <maco@android.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
