Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C07F2103FD
	for <lists+linux-block@lfdr.de>; Wed,  1 Jul 2020 08:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgGAGhY (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 1 Jul 2020 02:37:24 -0400
Received: from verein.lst.de ([213.95.11.211]:38807 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgGAGhY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 1 Jul 2020 02:37:24 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B99F768B02; Wed,  1 Jul 2020 08:37:20 +0200 (CEST)
Date:   Wed, 1 Jul 2020 08:37:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
        linux-block@vger.kernel.org, axboe@kernel.dk
Subject: Re: [PATCHv4 0/5] nvme support for zoned namespace command set
Message-ID: <20200701063720.GA28954@lst.de>
References: <20200629190641.1986462-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629190641.1986462-1-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks,

applied to nvme-5.9.
