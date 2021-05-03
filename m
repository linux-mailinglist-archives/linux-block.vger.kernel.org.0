Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFEDE3711F3
	for <lists+linux-block@lfdr.de>; Mon,  3 May 2021 09:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhECH2x (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 3 May 2021 03:28:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:33818 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230137AbhECH2w (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 3 May 2021 03:28:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1620026879; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=azfYBmUD1J2ESdzSvWMMtdKvFhwUOp+oTgVQjUFLs98=;
        b=C2rBR4w7B4OxhJ1E+ROWPJH1T2uLRyRH//1ROKZYIklkaVHlJFNVPyb0EPwSQD4vd9HU08
        auajWKzu9KteDsvJQnG+desXsz+SX++W264ns8jVOILltMw7ypbuhs8xXVNymToNVN78gf
        Bsvwvz7i4fboOFtW/ydUBy3eNvbw/gk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 20E4FAFF4;
        Mon,  3 May 2021 07:27:59 +0000 (UTC)
Message-ID: <1d4fa494a307aa2d303e210c69d1f0c0d8675436.camel@suse.com>
Subject: Re: dm: dm_blk_ioctl(): implement failover for SG_IO on dm-multipath
From:   Martin Wilck <mwilck@suse.com>
To:     Mike Snitzer <snitzer@redhat.com>, Hannes Reinecke <hare@suse.de>
Cc:     Alasdair G Kergon <agk@redhat.com>, dm-devel@redhat.com,
        Daniel Wagner <dwagner@suse.de>, linux-block@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org
Date:   Mon, 03 May 2021 09:27:58 +0200
In-Reply-To: <20210430201542.GA7880@redhat.com>
References: <20210422202130.30906-1-mwilck@suse.com>
         <20210428195457.GA46518@lobo>
         <7124009b-1ea5-61eb-419f-956e659a0996@suse.de>
         <20210430201542.GA7880@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2021-04-30 at 16:15 -0400, Mike Snitzer wrote:
> 
> If calling sg_io() is an issue then how does Martin's latest
> patchset,
> that exports and calls sg_io direct from DM, work!?

It works by doing sg_io on the _path_ devices. There's no difference
wrt to the current code in this respect. My code just retries on a
different path when one fails.

Hannes' original idea had passed the _dm_ device directly to
scsi_cmd_blk_ioctl().

Martin


