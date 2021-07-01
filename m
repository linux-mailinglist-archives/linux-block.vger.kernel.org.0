Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD4293B913B
	for <lists+linux-block@lfdr.de>; Thu,  1 Jul 2021 13:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236204AbhGALhQ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 1 Jul 2021 07:37:16 -0400
Received: from verein.lst.de ([213.95.11.211]:47319 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236130AbhGALhQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 1 Jul 2021 07:37:16 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 01CD567357; Thu,  1 Jul 2021 13:34:42 +0200 (CEST)
Date:   Thu, 1 Jul 2021 13:34:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Martin Wilck <mwilck@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>,
        Alasdair G Kergon <agk@redhat.com>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>,
        Daniel Wagner <dwagner@suse.de>, linux-block@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Benjamin Marzinski <bmarzins@redhat.com>, nkoenig@redhat.com,
        emilne@redhat.com
Subject: Re: [PATCH v5 3/3] dm mpath: add CONFIG_DM_MULTIPATH_SG_IO -
 failover for SG_IO
Message-ID: <20210701113442.GA10793@lst.de>
References: <20210628151558.2289-1-mwilck@suse.com> <20210628151558.2289-4-mwilck@suse.com> <20210701075629.GA25768@lst.de> <de1e3dcbd26a4c680b27b557ea5384ba40fc7575.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de1e3dcbd26a4c680b27b557ea5384ba40fc7575.camel@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 01, 2021 at 12:35:53PM +0200, Martin Wilck wrote:
> I respectfully disagree. Users of dm-multipath devices expect that IO
> succeeds as long as there's at least one healthy path. This is a
> fundamental property of multipath devices. Whether IO is sent
> "normally" or via SG_IO doesn't make a difference wrt this expectation.

If you have those (pretty reasonable) expections don't use SG_IO.
That is what the regular read/write path is for.  SG_IO gives you
raw access to the SCSI logic unit, and you get to keep the pieces
if anything goes wrong.
