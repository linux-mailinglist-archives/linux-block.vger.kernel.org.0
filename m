Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB7B3185A1
	for <lists+linux-block@lfdr.de>; Thu, 11 Feb 2021 08:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbhBKHVg (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 11 Feb 2021 02:21:36 -0500
Received: from verein.lst.de ([213.95.11.211]:54258 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229451AbhBKHVg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Feb 2021 02:21:36 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3FDA16736F; Thu, 11 Feb 2021 08:20:53 +0100 (CET)
Date:   Thu, 11 Feb 2021 08:20:53 +0100
From:   "hch@lst.de" <hch@lst.de>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "hch@lst.de" <hch@lst.de>, Damien Le Moal <Damien.LeMoal@wdc.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V9 0/9] nvmet: add ZBD backend support
Message-ID: <20210211072053.GA14044@lst.de>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com> <BYAPR04MB4965A4A8B3BD9E070F492EDF868D9@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB4965A4A8B3BD9E070F492EDF868D9@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 10, 2021 at 10:42:42PM +0000, Chaitanya Kulkarni wrote:
> I can see that Damien's granularity series is in the linux-block tree, I'm
> planning to send v10 of this series given that it also has a block layer
> patch
> [1] should I use the linux-block/for-next or linux-nvme/nvme-5.12 ?

I'd just wait for -rc1.
