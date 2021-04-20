Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F12D365584
	for <lists+linux-block@lfdr.de>; Tue, 20 Apr 2021 11:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhDTJh4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 20 Apr 2021 05:37:56 -0400
Received: from verein.lst.de ([213.95.11.211]:49879 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229937AbhDTJhy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Apr 2021 05:37:54 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CC71A68C4E; Tue, 20 Apr 2021 11:37:20 +0200 (CEST)
Date:   Tue, 20 Apr 2021 11:37:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 0/4] nvme: improve error handling and ana_state to
 work well with dm-multipath
Message-ID: <20210420093720.GA28874@lst.de>
References: <20210416235329.49234-1-snitzer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416235329.49234-1-snitzer@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> RHEL9 is coming, would really prefer that these changes land upstream
> rather than carry them within RHEL.

We've told from the very beginning that dm-multipth on nvme is not
a support configuration.  Red Hat decided to ignore that and live with the
pain.  Your major version change is a chance to fix this up on the Red Hat
side, not to resubmit bogus patches upstream.

In other words: please get your house in order NOW.
