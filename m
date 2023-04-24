Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3126D673F
	for <lists+linux-block@lfdr.de>; Tue,  4 Apr 2023 17:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjDDP0j (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 4 Apr 2023 11:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234743AbjDDP0h (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Apr 2023 11:26:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182B9449C
        for <linux-block@vger.kernel.org>; Tue,  4 Apr 2023 08:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=QjyFYj2Hhx3MMd7wYyRJ3UZuOT
        qK2tT1zyQTybX4z4wlDlJ2E5PUusFW6Djk7vm16KyrW1UZCfn12uLCiMK2ZP4pgqF+8l5YtOFRRxA
        dgW1GbwqCbFGxGR2JUCSTsxzGaj/MzFKYCq0gRhh7+nsKCfOiOLVWsgVAh86237xD4zztzMTNMf7h
        uOnaeaIT9wRllZd/3oRAv0+8gmVGhZbPbRTfirelIi2fbbA6RTiSSB4qBHcCWw8H/Gzoyh0O1E2Ql
        D2bxMVx7PoK9M8vtQNdH9xDewNJdlnkBwGTWd3GbhcVo7SjCZrCS0N/vsNp0K3+GJ4L24Cdn33LY0
        bgkbU8sQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pjiYO-0020C8-30;
        Tue, 04 Apr 2023 15:26:36 +0000
Date:   Tue, 4 Apr 2023 08:26:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ondrej Kozina <okozina@redhat.com>
Cc:     linux-block@vger.kernel.org, bluca@debian.org, gmazyland@gmail.com,
        axboe@kernel.dk, hch@infradead.org, brauner@kernel.org,
        rafael.antognolli@intel.com
Subject: Re: [PATCH 4/5] sed-opal: add helper to get multiple columns at once.
Message-ID: <ZCxBrBJXSvpOVJT+@infradead.org>
References: <20230322151604.401680-1-okozina@redhat.com>
 <20230322151604.401680-5-okozina@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322151604.401680-5-okozina@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
