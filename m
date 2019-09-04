Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63BC8A7B04
	for <lists+linux-block@lfdr.de>; Wed,  4 Sep 2019 07:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfIDFyY (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 4 Sep 2019 01:54:24 -0400
Received: from verein.lst.de ([213.95.11.211]:36163 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbfIDFyY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 4 Sep 2019 01:54:24 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2605A227A8A; Wed,  4 Sep 2019 07:54:20 +0200 (CEST)
Date:   Wed, 4 Sep 2019 07:54:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Max Gurtovoy <maxg@mellanox.com>, linux-block@vger.kernel.org,
        axboe@kernel.dk, martin.petersen@oracle.com,
        linux-nvme@lists.infradead.org, keith.busch@intel.com, hch@lst.de,
        shlomin@mellanox.com, israelr@mellanox.com
Subject: Re: [PATCH 3/4] nvme-tcp: introduce nvme_tcp_complete_rq callback
Message-ID: <20190904055419.GD10553@lst.de>
References: <1567523655-23989-1-git-send-email-maxg@mellanox.com> <1567523655-23989-3-git-send-email-maxg@mellanox.com> <c5757c95-2a4f-410d-a275-85d8c9da737f@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5757c95-2a4f-410d-a275-85d8c9da737f@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 03, 2019 at 12:15:48PM -0700, Sagi Grimberg wrote:
>
>> The nvme_cleanup_cmd function should be called to avoid resource leakage
>> (it's the opposite to nvme_setup_cmd). Fix the error flow during command
>> submission and also fix the missing call in command completion.
>
> Is it always called with nvme_complete_rq? Why not just put it there?

Yes, unless I am missing something we could call nvme_cleanup_cmd
at the beginning of nvme_complete_rq.

Max, can you send one series for all the nvme_cleanup_cmd fixes and
cleanups and split that from the PI work?  That might be a little
less confusing.
