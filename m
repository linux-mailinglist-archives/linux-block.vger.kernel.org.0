Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8938C414C1A
	for <lists+linux-block@lfdr.de>; Wed, 22 Sep 2021 16:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236178AbhIVOfK (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 22 Sep 2021 10:35:10 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47048 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbhIVOfJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Sep 2021 10:35:09 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 307A91FE9B;
        Wed, 22 Sep 2021 14:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632321219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k/gJ/AWM2V+0oCuteAUShxfa63FrnRH0Y7CimawHM5g=;
        b=PbEqlvOGmHDWX5xfRdEK+7zhxJc9SotNGT7WBtrq3cIBw8KkWdGRok+IIOstRLW2mnHC+/
        Is3YDZ5ptzMWgWh0PyIq6qkO+KM1YIeSUASUqKAwzsVLjdw+5/e826P+gDIzcK4N/UDfqR
        2PhS6INVCswXr2K/u3eZGFpqzZK853g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632321219;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k/gJ/AWM2V+0oCuteAUShxfa63FrnRH0Y7CimawHM5g=;
        b=OBI3yP9jNUvJvnSlKS7sLEuUGFs2gtA6tGot/A11bwYbUSZB+I9f3b757xJr1IxmJPKhQ5
        igjk5rO5jwi/1sCQ==
Received: from quack2.suse.cz (jack.udp.ovpn2.nue.suse.de [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id 23404A3B81;
        Wed, 22 Sep 2021 14:33:39 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 85CA51E37A2; Wed, 22 Sep 2021 16:33:36 +0200 (CEST)
Date:   Wed, 22 Sep 2021 16:33:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jan Kara <jack@suse.cz>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 0/3 v2] bfq: Limit number of allocated scheduler tags per
 cgroup
Message-ID: <20210922143336.GA13760@quack2.suse.cz>
References: <20210715132047.20874-1-jack@suse.cz>
 <751F4AB5-1FDF-45B0-88E1-0C76ED1AAAD6@linaro.org>
 <20210831095930.GB17119@blackbody.suse.cz>
 <20210915131512.GB6166@quack2.suse.cz>
 <AF7AAF20-7D9E-4305-901A-86A3717A9CFB@linaro.org>
 <20210920092815.GA6607@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210920092815.GA6607@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon 20-09-21 11:28:15, Jan Kara wrote:
> On Sat 18-09-21 12:58:34, Paolo Valente wrote:
> > > Il giorno 15 set 2021, alle ore 15:15, Jan Kara <jack@suse.cz> ha scritto:
> > > 
> > > On Tue 31-08-21 11:59:30, Michal Koutn� wrote:
> > >> Hello Paolo.
> > >> 
> > >> On Fri, Aug 27, 2021 at 12:07:20PM +0200, Paolo Valente <paolo.valente@linaro.org> wrote:
> > >>> Before discussing your patches in detail, I need a little help on this
> > >>> point.  You state that the number of scheduler tags must be larger
> > >>> than the number of device tags.  So, I expected some of your patches
> > >>> to address somehow this issue, e.g., by increasing the number of
> > >>> scheduler tags.  Yet I have not found such a change.  Did I miss
> > >>> something?
> > >> 
> > >> I believe Jan's conclusions so far are based on "manual" modifications
> > >> of available scheduler tags by /sys/block/$dev/queue/nr_requests.
> > >> Finding a good default value may be an additional change.
> > > 
> > > Exactly. So far I was manually increasing nr_requests. I agree that
> > > improving the default nr_requests value selection would be desirable as
> > > well so that manual tuning is not needed. But for now I've left that aside.
> > > 
> > 
> > Ok. So, IIUC, to recover control on bandwidth you need to
> > (1) increase nr_requests manually
> > and
> > (2) apply your patch
> > 
> > If you don't do (1), then (2) is not sufficient, and viceversa. Correct?
> 
> Correct, although 1) depends on HW capabilities - e.g. for standard SATA
> NCQ drive with queue depth of 32, the current nr_requests setting of 256 is
> fine and just 2) is enough to recover control. If you run on top of virtio
> device or storage controller card with queue depth of 1024, you need to
> bump up the nr_requests setting.

Paolo, do you have any thoughts about the patches? Any estimate when you
can have a look into them? BTW I have sligthly updated version locally
which also helps with restoring service differentiation for IO priorities
but in principle there's no fundamental difference.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
