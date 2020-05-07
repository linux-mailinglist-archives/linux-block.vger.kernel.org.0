Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD021C8CC3
	for <lists+linux-block@lfdr.de>; Thu,  7 May 2020 15:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgEGNnQ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 7 May 2020 09:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725969AbgEGNnQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 May 2020 09:43:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FFBC05BD43
        for <linux-block@vger.kernel.org>; Thu,  7 May 2020 06:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IkTIfnCuUdfzkCQIu83TZMurI22TqEIsThsv/B2BQHU=; b=J5xepBZEN6H3HIaVu6WlHffHUE
        CrEBGGQwR5c7aMqT9BQAFYA9bsFb2PZ4hnU+aYqbSz388tpk3gERlgCGXsILAL+ArY5B20gX6sRpQ
        mef+0CHSa7AA52yzuChdhvrBMb+xHxDmJRcqDP4FJs88HuZndgjkmtOCfhyROJTRWcECFOsy0Rib5
        43Ydct+56WaYHuBxBqyOCJA69js82vAy9g4gosnjvnIHEEJPAlmaXgnyYRjrvX0na/HvSp+Yhekvf
        XKmJVX4m+9OdqQMmU+EP9QdrGVUPmZ+QyVlNCn4AQpzt9qdaknOkGcwykGuNU1+sv9awYgoVIlic0
        QhGO9xsQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWgns-0006o0-2r; Thu, 07 May 2020 13:43:08 +0000
Date:   Thu, 7 May 2020 06:43:08 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     axboe@kernel.dk, tom.leiming@gmail.com, bvanassche@acm.org,
        hch@infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v6 0/5] Fix potential kernel panic when increase hardware
 queue
Message-ID: <20200507134308.GA26100@infradead.org>
References: <cover.1588856361.git.zhangweiping@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1588856361.git.zhangweiping@didiglobal.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The whole series looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
