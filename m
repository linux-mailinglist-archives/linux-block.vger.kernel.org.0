Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2DA42CB88F
	for <lists+linux-block@lfdr.de>; Wed,  2 Dec 2020 10:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbgLBJVC (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 2 Dec 2020 04:21:02 -0500
Received: from verein.lst.de ([213.95.11.211]:53116 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgLBJVC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 Dec 2020 04:21:02 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 403D868AFE; Wed,  2 Dec 2020 10:20:20 +0100 (CET)
Date:   Wed, 2 Dec 2020 10:20:19 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me, hch@lst.de, damien.lemoal@wdc.com,
        johannes.thumshirn@wdc.com
Subject: Re: [PATCH V4 0/9] nvmet: add ZBD backend support
Message-ID: <20201202092019.GA3957@lst.de>
References: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Unless I'm missing something this fails to advertise multiple command
support in the CAP property, as well as the enablement in the CC
property.  How does the host manage to even use this?
