Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419331FCDC2
	for <lists+linux-block@lfdr.de>; Wed, 17 Jun 2020 14:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgFQMvx (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 17 Jun 2020 08:51:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:34572 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbgFQMvx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jun 2020 08:51:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 08596AED8;
        Wed, 17 Jun 2020 12:51:55 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8BA3F1E128D; Wed, 17 Jun 2020 14:51:51 +0200 (CEST)
Date:   Wed, 17 Jun 2020 14:51:51 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 0/2 v3] blktrace: Fix sparse annotations and warn if
 enabling multiple traces
Message-ID: <20200617125151.GA30907@quack2.suse.cz>
References: <20200605145349.18454-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605145349.18454-1-jack@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Jens!

On Fri 05-06-20 16:58:35, Jan Kara wrote:
> this series contains a patch from Luis' blktrace series and then my patch
> to fix sparse warnings in blktrace. Luis' patch stands on its own, was
> reviewed, and changes what I need to change as well so I've decided it's just
> simplest to pull it in with my patch.

Can you please merge this series?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
