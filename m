Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C29AB3F9E16
	for <lists+linux-block@lfdr.de>; Fri, 27 Aug 2021 19:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbhH0Rip (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 27 Aug 2021 13:38:45 -0400
Received: from vps.thesusis.net ([34.202.238.73]:35900 "EHLO vps.thesusis.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230035AbhH0Rio (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Aug 2021 13:38:44 -0400
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 404784805B; Fri, 27 Aug 2021 13:37:55 -0400 (EDT)
References: <20210827075045.642269-1-damien.lemoal@wdc.com>
 <874kbbugtw.fsf@vps.thesusis.net>
 <63D90989-AFAF-410B-AD11-EDF71CEEE666@seagate.com>
User-agent: mu4e 1.5.13; emacs 27.1
From:   Phillip Susi <phill@thesusis.net>
To:     Tim Walker <tim.t.walker@seagate.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH v6 0/5] Initial support for multi-actuator HDDs
Date:   Fri, 27 Aug 2021 13:34:53 -0400
In-reply-to: <63D90989-AFAF-410B-AD11-EDF71CEEE666@seagate.com>
Message-ID: <87ilzqu6to.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Tim Walker <tim.t.walker@seagate.com> writes:

> The IO Scheduler is a useful place to implement per-actuator load
> management, but with the LBA-to-actuator mapping available to user
> space (via sysfs) it could also be done at the user level. Or pretty
> much anywhere else where we have knowledge and control of the various
> streams.

I suppose there may be some things user space could do with the
information, but mainly doesn't it have to be done in the IO scheduler?
As it stands now, it is going to try to avoid seeking between the two
regions even though the drive can service a contiguous stream from both
just fine, right?

