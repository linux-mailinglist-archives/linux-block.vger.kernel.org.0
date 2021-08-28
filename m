Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 414473FA43A
	for <lists+linux-block@lfdr.de>; Sat, 28 Aug 2021 09:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbhH1HPS (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 28 Aug 2021 03:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbhH1HPD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 Aug 2021 03:15:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EEEC0613D9;
        Sat, 28 Aug 2021 00:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=W4eRB3CuAwPNucz89uWUzvsXo4
        jEyUTMiSlThDBk7KPM9rI3pL/Gmf8nYzlfArXcAH1OzrfQf/4r7FWBZZLv7irREI+EzQTilRSgTIV
        WuGIUmue/B5W9AoSWldhgwDE1SoFotLL9+VyZfsNIiz7bQg3X2L6VB6aR4IoM+PKHgb1CLj+D+neC
        OghX2Qw9MNXZLWXSgBJcRxrP3FJW6ot1ZfmaBR2Pr/W9kCh5kltmVk58wzjDmsIX+KF7CSfaUatOY
        KWaBTGFheO4ZRCyAP6xFk8ZZuy6LQToYPZLAS2oE6XiTmV3n1xikYV9V36baRwYuXlI+YM8XHBM3k
        GREAbHSQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mJsUo-00FMa7-Nt; Sat, 28 Aug 2021 07:11:36 +0000
Date:   Sat, 28 Aug 2021 08:11:18 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, martin.petersen@oracle.com, jejb@linux.ibm.com,
        kbusch@kernel.org, sagi@grimberg.me, adrian.hunter@intel.com,
        beanhuo@micron.com, ulf.hansson@linaro.org, avri.altman@wdc.com,
        swboyd@chromium.org, agk@redhat.com, snitzer@redhat.com,
        josef@toxicpanda.com, hch@infradead.org, hare@suse.de,
        bvanassche@acm.org, ming.lei@redhat.com,
        linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-mmc@vger.kernel.org, dm-devel@redhat.com,
        nbd@other.debian.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] nvme: add error handling support for add_disk()
Message-ID: <YSnhlvCsX9RsT6a5@infradead.org>
References: <20210827190504.3103362-1-mcgrof@kernel.org>
 <20210827190504.3103362-4-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827190504.3103362-4-mcgrof@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
