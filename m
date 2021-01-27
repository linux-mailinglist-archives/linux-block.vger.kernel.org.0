Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E566830627A
	for <lists+linux-block@lfdr.de>; Wed, 27 Jan 2021 18:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236373AbhA0RrV (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 27 Jan 2021 12:47:21 -0500
Received: from verein.lst.de ([213.95.11.211]:53937 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236383AbhA0RrT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jan 2021 12:47:19 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id C7B6068B05; Wed, 27 Jan 2021 18:46:32 +0100 (CET)
Date:   Wed, 27 Jan 2021 18:46:32 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] nvme: add tracing of zns commands
Message-ID: <20210127174632.GC28180@lst.de>
References: <46eeed2fcf2530d02fe5727a0a91a6e4675f6edd.1611683161.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46eeed2fcf2530d02fe5727a0a91a6e4675f6edd.1611683161.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks,

applied to nvme-5.12.
