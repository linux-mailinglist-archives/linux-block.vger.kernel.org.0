Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76EB32FA8BA
	for <lists+linux-block@lfdr.de>; Mon, 18 Jan 2021 19:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407509AbhARSYw (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 18 Jan 2021 13:24:52 -0500
Received: from verein.lst.de ([213.95.11.211]:49139 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436796AbhARSVr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jan 2021 13:21:47 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 30E6B6736F; Mon, 18 Jan 2021 19:21:06 +0100 (CET)
Date:   Mon, 18 Jan 2021 19:21:05 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH V9 3/9] nvmet: add NVM command set identifier support
Message-ID: <20210118182105.GB11082@lst.de>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com> <20210112042623.6316-4-chaitanya.kulkarni@wdc.com> <20210112072715.GB24155@lst.de> <BYAPR04MB4965017878A807316A0A1BBA86A90@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB4965017878A807316A0A1BBA86A90@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 13, 2021 at 04:16:51AM +0000, Chaitanya Kulkarni wrote:
> We advertise the support for command sets supported in
> nvmet_init_cap() -> ctrl->cap = (1ULL << 37). This results in
> nvme_enable_ctrl() setting the ctrl->ctrl_config -> NVME_CC_CSS_NVM.
> In current code in nvmet_start_ctrl() ->  nvmet_cc_css(ctrl->cc) != 0
> checks if value is not = 0 but doesn't use the macro used by the host.
> Above function does that also makes it helper that we use in the next
> patch where cc_css value is != 0 but NVME_CC_CSS_CSI with
> ctrl->cap set to 1ULL << 43.
> 
> With code flow in [1] above function is needed to make sure css value
> matches the value set by the host using the same macro in
> nvme_enable_ctrl() NVME_CC_CSS_NVM. Otherwise patch looks incomplete
> and adding check for the CSS NVM with CSS_CSI looks mixing up things
> to me.
> 
> Are you okay with that ?

Yeah, we can probably include it in an overall multiple command sets
support patch.
