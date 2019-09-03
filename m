Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6825BA64A3
	for <lists+linux-block@lfdr.de>; Tue,  3 Sep 2019 11:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfICJFH (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 3 Sep 2019 05:05:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41598 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfICJFH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Sep 2019 05:05:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=W1X+nR6XySisPLATvmJ9CU3qE
        xDMKgiWv6HV48giATpJ3PN84FEYNKCCDgIrFwJVJu3hAZhS4+Nm8VRzJA6grIE340Y2MHkpqgJ8ui
        iD0diR1O/2/qgQoRl9WAOS0Oz7wBX6+L530HF+XMxVPLwdcesoTSnWQ4DgY0FXI4o7BenyOAYvIf2
        n74U+VmposVFzF1luBJRF7+m6ZnYTPBrEcmTC3X/jJQbNij3h6qv0xV66P76yxi9bqg7G9xuLsvLD
        swENK28RiSqM/v7rvv8r/tWP7sfey/meDfr3AUbBodqjVoD1tfJlMrehgk8FanejEIZReKbaL2zyG
        /MqlhFwJA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i54kM-0002PE-VQ; Tue, 03 Sep 2019 09:05:06 +0000
Date:   Tue, 3 Sep 2019 02:05:06 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Hans Holmberg <Hans.Holmberg@wdc.com>
Subject: Re: [PATCH] block: mq-deadline: Fix queue restart handling
Message-ID: <20190903090506.GH23783@infradead.org>
References: <20190828044020.23915-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828044020.23915-1-damien.lemoal@wdc.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
