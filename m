Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A161FB272
	for <lists+linux-block@lfdr.de>; Tue, 16 Jun 2020 15:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgFPNrp (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 16 Jun 2020 09:47:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:51888 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726306AbgFPNro (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jun 2020 09:47:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E196FAD25;
        Tue, 16 Jun 2020 13:47:46 +0000 (UTC)
Date:   Tue, 16 Jun 2020 15:47:41 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Keith Busch <keith.busch@wdc.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Matias =?utf-8?B?QmrDuHJsaW5n?= <matias.bjorling@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 1/5] block: add capacity field to zone descriptors
Message-ID: <20200616134741.zvs55r6pga5w2pvo@beryllium.lan>
References: <20200615233424.13458-1-keith.busch@wdc.com>
 <20200615233424.13458-2-keith.busch@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200615233424.13458-2-keith.busch@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 16, 2020 at 08:34:20AM +0900, Keith Busch wrote:
> From: Matias Bjørling <matias.bjorling@wdc.com>
> 
> In the zoned storage model, the sectors within a zone are typically all
> writeable. With the introduction of the Zoned Namespace (ZNS) Command
> Set in the NVM Express organization, the model was extended to have a
> specific writeable capacity.
> 
> Extend the zone descriptor data structure with a zone capacity field to
> indicate to the user how many sectors in a zone are writeable.
> 
> Introduce backward compatibility in the zone report ioctl by extending
> the zone report header data structure with a flags field to indicate if
> the capacity field is available.
> 
> Signed-off-by: Matias Bjørling <matias.bjorling@wdc.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>
