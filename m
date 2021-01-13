Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C482F4C0F
	for <lists+linux-block@lfdr.de>; Wed, 13 Jan 2021 14:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbhAMNKP (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 13 Jan 2021 08:10:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:51052 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbhAMNKP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Jan 2021 08:10:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E4CFAAB92;
        Wed, 13 Jan 2021 13:09:33 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A4E091E0872; Wed, 13 Jan 2021 14:09:33 +0100 (CET)
Date:   Wed, 13 Jan 2021 14:09:33 +0100
From:   Jan Kara <jack@suse.cz>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Andreas Herrmann <aherrmann@suse.com>
Subject: Re: [PATCH 1/2] bfq: Fix check detecting whether waker queue should
 be selected
Message-ID: <20210113130933.GE6854@quack2.suse.cz>
References: <20200409170915.30570-1-jack@suse.cz>
 <20200409170915.30570-2-jack@suse.cz>
 <F338859F-DAD2-4D16-8E66-52387356E78D@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F338859F-DAD2-4D16-8E66-52387356E78D@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun 10-01-21 10:20:22, Paolo Valente wrote:
> 
> 
> > Il giorno 9 apr 2020, alle ore 19:09, Jan Kara <jack@suse.cz> ha scritto:
> > 
> > The check in bfq_select_queue() checking whether a waker queue should be
> > selected has a bug and is checking bfqq->next_rq instead of
> > bfqq->waker_bfqq->next_rq to verify whether the waker queue has a
> > request to dispatch. This often results in the condition being false
> > (most notably when the current queue is idling waiting for next request)
> > and thus the waker queue logic is ineffective. Fix the condition.
> > 
> 
> Hi Jan,
> my huge delay causes problems again, because a student of mine already
> made this same fix a few months ago.  But I did not send it out yet,
> for lack of time.  If ok for you, we could go for a common commit with
> two authors (I seem to remember it is feasible).

No problem for me. Or just give the student a credit instead of me. A
commit in the kernel is likely more interesting for him than for me ;) Just
reply to the v2 series I've sent today (you should be on CC) so that Jens
knows the author should be changed.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
