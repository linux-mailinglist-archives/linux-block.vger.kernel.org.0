Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336E23F947C
	for <lists+linux-block@lfdr.de>; Fri, 27 Aug 2021 08:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234736AbhH0GqA (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 27 Aug 2021 02:46:00 -0400
Received: from verein.lst.de ([213.95.11.211]:32989 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232463AbhH0Gp7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Aug 2021 02:45:59 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 872026736F; Fri, 27 Aug 2021 08:45:06 +0200 (CEST)
Date:   Fri, 27 Aug 2021 08:45:05 +0200
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
Message-ID: <20210827064505.GA23147@lst.de>
References: <20210826133810.3700-1-hch@lst.de> <20210826133810.3700-6-hch@lst.de> <977860f6-efc4-a55e-50e3-c5204fc762c5@gmail.com> <20210826163422.GA28718@lst.de> <ebfe4404-e251-ec0d-e46d-0a02b031bcb2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebfe4404-e251-ec0d-e46d-0a02b031bcb2@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 26, 2021 at 06:44:32PM +0200, Milan Broz wrote:
> Yes, I know that removal is far disturbing thing here, if it
> can be planned for removal later, I think it is the best thing to do...
> 
> And I would like to know actually if there are existing users
> (and how and why they are using this interface - it cannot be configured
> through losetup for years IIRC).

We could just try to drop it entirely and see if anyone screams.  You
are probably right that no one will.
