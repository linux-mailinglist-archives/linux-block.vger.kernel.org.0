Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1DD4D7D2C
	for <lists+linux-block@lfdr.de>; Mon, 14 Mar 2022 09:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237466AbiCNIGY (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 14 Mar 2022 04:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237983AbiCNID0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Mar 2022 04:03:26 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BBCB7FB
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 00:59:57 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 929E468AFE; Mon, 14 Mar 2022 08:58:58 +0100 (CET)
Date:   Mon, 14 Mar 2022 08:58:58 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        jiangbo.365@bytedance.com, kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Message-ID: <20220314075858.GA4921@lst.de>
References: <e02dfd21-31c6-95b6-1127-3f18c79116ee@samsung.com> <20220310144449.GA1695@lst.de> <Yiuu2h38owO9ioIW@bombadil.infradead.org> <20220311205135.GA413653@dhcp-10-100-145-180.wdc.com> <Yiu5YzxU/PjxLiUL@bombadil.infradead.org> <20220311213102.GA2309@dhcp-10-100-145-180.wdc.com> <YivMBj7+j/EZcMVV@bombadil.infradead.org> <bc0e53a9-f623-c69f-002e-d62e697a43d1@opensource.wdc.com> <20220314073537.GA4204@lst.de> <05a1fde2-12bd-1059-6177-2291307dbd8d@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05a1fde2-12bd-1059-6177-2291307dbd8d@opensource.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 14, 2022 at 04:45:12PM +0900, Damien Le Moal wrote:
> Nope, this is currently not possible: DM requires the target zone size
> to be the same as the underlying device zone size. So that would not work.

Indeed.
