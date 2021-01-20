Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC6422FCF5B
	for <lists+linux-block@lfdr.de>; Wed, 20 Jan 2021 13:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389415AbhATLX2 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 20 Jan 2021 06:23:28 -0500
Received: from verein.lst.de ([213.95.11.211]:55332 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728864AbhATKIX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Jan 2021 05:08:23 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1F72A68AFE; Wed, 20 Jan 2021 11:07:38 +0100 (CET)
Date:   Wed, 20 Jan 2021 11:07:38 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@wdc.com>
Subject: Re: [PATCH v2 0/2] block: add zone write granularity limit
Message-ID: <20210120100738.GA25746@lst.de>
References: <20210119131723.1637853-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119131723.1637853-1-damien.lemoal@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Shouldn't zonefs (in addition to the pending btrfs and nvmet patches)
start using this new value instead pf the physical block size?
