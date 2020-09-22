Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA922742AF
	for <lists+linux-block@lfdr.de>; Tue, 22 Sep 2020 15:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgIVNKY (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 22 Sep 2020 09:10:24 -0400
Received: from verein.lst.de ([213.95.11.211]:44524 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbgIVNKY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Sep 2020 09:10:24 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 73FCD68BEB; Tue, 22 Sep 2020 15:10:19 +0200 (CEST)
Date:   Tue, 22 Sep 2020 15:10:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com
Subject: Re: [PATCHv3 0/4] zoned block device specific errors
Message-ID: <20200922131018.GA20195@lst.de>
References: <20200917231841.4029747-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917231841.4029747-1-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
