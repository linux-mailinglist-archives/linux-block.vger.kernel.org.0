Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5251D34B3
	for <lists+linux-block@lfdr.de>; Thu, 14 May 2020 17:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgENPMc (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 14 May 2020 11:12:32 -0400
Received: from verein.lst.de ([213.95.11.211]:52337 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbgENPMc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 May 2020 11:12:32 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D259068BEB; Thu, 14 May 2020 17:12:30 +0200 (CEST)
Date:   Thu, 14 May 2020 17:12:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2] nvme: Fix io_opt limit setting
Message-ID: <20200514151230.GD29964@lst.de>
References: <20200514055626.1111729-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514055626.1111729-1-damien.lemoal@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks,

applied to nvme-5.8.
