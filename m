Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCA82FF28A
	for <lists+linux-block@lfdr.de>; Thu, 21 Jan 2021 18:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389310AbhAURy5 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 21 Jan 2021 12:54:57 -0500
Received: from verein.lst.de ([213.95.11.211]:33550 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389026AbhAURyX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jan 2021 12:54:23 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3F16768B05; Thu, 21 Jan 2021 18:53:40 +0100 (CET)
Date:   Thu, 21 Jan 2021 18:53:39 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     mwilck@suse.com
Cc:     Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Alasdair G Kergon <agk@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        dm-devel@redhat.com
Subject: Re: [PATCH v2] dm: avoid filesystem lookup in dm_get_dev_t()
Message-ID: <20210121175339.GA828@lst.de>
References: <20210121175056.20078-1-mwilck@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121175056.20078-1-mwilck@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

Mike, Jens - can we make sure this goes in before branching off the
block branch for 5.12?  I have some work pending that would otherwise
conflict.
