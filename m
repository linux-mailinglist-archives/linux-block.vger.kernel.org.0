Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 295872A4EEA
	for <lists+linux-block@lfdr.de>; Tue,  3 Nov 2020 19:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbgKCScu (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 3 Nov 2020 13:32:50 -0500
Received: from verein.lst.de ([213.95.11.211]:38602 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgKCScu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 3 Nov 2020 13:32:50 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 26CA66736F; Tue,  3 Nov 2020 19:32:47 +0100 (CET)
Date:   Tue, 3 Nov 2020 19:32:46 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        hch@lst.de, sagi@grimberg.me, kbusch@kernel.org,
        logang@deltatee.com
Subject: Re: [PATCH V3 0/6] nvmet: passthru fixes and improvements
Message-ID: <20201103183246.GA23697@lst.de>
References: <20201022010234.8304-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022010234.8304-1-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Btw, what is fixed by the series?  It looks like just (useful) cleanups
to me.
