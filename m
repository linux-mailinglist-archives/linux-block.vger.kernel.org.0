Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 007F62F28E9
	for <lists+linux-block@lfdr.de>; Tue, 12 Jan 2021 08:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730416AbhALH16 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 12 Jan 2021 02:27:58 -0500
Received: from verein.lst.de ([213.95.11.211]:54146 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbhALH16 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jan 2021 02:27:58 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id EDBA068AFE; Tue, 12 Jan 2021 08:27:15 +0100 (CET)
Date:   Tue, 12 Jan 2021 08:27:15 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        hch@lst.de, sagi@grimberg.me, damien.lemoal@wdc.com
Subject: Re: [PATCH V9 3/9] nvmet: add NVM command set identifier support
Message-ID: <20210112072715.GB24155@lst.de>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com> <20210112042623.6316-4-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112042623.6316-4-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The Command Set Identifier has no "NVM" in its name.


> +static inline bool nvmet_cc_css_check(u8 cc_css)
> +{
> +	switch (cc_css <<= NVME_CC_CSS_SHIFT) {
> +	case NVME_CC_CSS_NVM:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}

This hunk looks misplaced, it isn't very useful on its own, but
should go together with the multiple command set support.
