Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF3A3B5BC3
	for <lists+linux-block@lfdr.de>; Mon, 28 Jun 2021 11:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbhF1J4K (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 28 Jun 2021 05:56:10 -0400
Received: from verein.lst.de ([213.95.11.211]:35789 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230256AbhF1J4J (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jun 2021 05:56:09 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 30AFC67373; Mon, 28 Jun 2021 11:53:41 +0200 (CEST)
Date:   Mon, 28 Jun 2021 11:53:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     mwilck@suse.com
Cc:     Mike Snitzer <snitzer@redhat.com>,
        Alasdair G Kergon <agk@redhat.com>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>,
        Daniel Wagner <dwagner@suse.de>, linux-block@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Benjamin Marzinski <bmarzins@redhat.com>, nkoenig@redhat.com,
        emilne@redhat.com
Subject: Re: [PATCH v4 1/3] scsi: scsi_ioctl: export
 __scsi_result_to_blk_status()
Message-ID: <20210628095341.GA4105@lst.de>
References: <20210628095210.26249-1-mwilck@suse.com> <20210628095210.26249-2-mwilck@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628095210.26249-2-mwilck@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 28, 2021 at 11:52:08AM +0200, mwilck@suse.com wrote:
> From: Martin Wilck <mwilck@suse.com>
> 
> This makes it possible to use scsi_result_to_blk_status() from
> code that shouldn't depend on scsi_mod (e.g. device mapper).

This really has no business being used outside of low-level SCSI code.
