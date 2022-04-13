Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0AB4FEE61
	for <lists+linux-block@lfdr.de>; Wed, 13 Apr 2022 06:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbiDMEzk (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 13 Apr 2022 00:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiDMEzj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Apr 2022 00:55:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C912625C7A
        for <linux-block@vger.kernel.org>; Tue, 12 Apr 2022 21:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=e/0TrA6Xb2T/hiRqFbr3DIsyyeb8eW4T7g7FyK0xLMc=; b=a32hab8xykS5XP36L2VtxRASC4
        2+9WMPElR6L9jEZe34b6UmpWUIpTpujRCYxTuHLKf9XLGZVXHWNe+m4qJerwnGy2d2bde5AxAAnpI
        4pD20ji+xBz4HuBTpxixeq4uPtzmWPnysdfxXilDetkpIp0vyt+mRL9TLmwWXJVBEHG35gA49wm4V
        iLdn+QfSU/gjuBWjsu4W4Tw7KHfjRBjRHAfFZy5l/HUfk3s2ZCNFI/Y32BoLB9M8tWvSCQy8+SiPB
        bOpETGnmi4YxvcfIUWrz+Ugcx8NTtkavXMYKtLH5M9U275GlrJhe/pTvGXZHgHKbx4E+d6bjhlspP
        SKAXLP2w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1neV0C-00GmLq-NL; Wed, 13 Apr 2022 04:53:12 +0000
Date:   Tue, 12 Apr 2022 21:53:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     bvanassche@acm.org, yi.zhang@redhat.com, sagi@grimberg.me,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: can't run nvme-mp blktests
Message-ID: <YlZXOC4VgmDrUGIP@infradead.org>
References: <YlYYJC/WUEsnI9Im@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlYYJC/WUEsnI9Im@bombadil.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 12, 2022 at 05:24:04PM -0700, Luis Chamberlain wrote:
> I do have CONFIG_NVME_MULTIPATH=y but I also have:

I'd suggest to ignore broken tests that require a deprecated option
that will eventually be removed.
