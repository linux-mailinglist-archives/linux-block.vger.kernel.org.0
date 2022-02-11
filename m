Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52A54B1ED9
	for <lists+linux-block@lfdr.de>; Fri, 11 Feb 2022 07:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbiBKGx2 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 11 Feb 2022 01:53:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiBKGx1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Feb 2022 01:53:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83A790
        for <linux-block@vger.kernel.org>; Thu, 10 Feb 2022 22:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v7Rcpas2mjKtdBymBHzFJE+MqkNyqWK+H8/1t8QY0Q0=; b=FTO8kNEOLcBcWa9E9fwM/zZD30
        MVHc3xezzeoV8uVEwkhoWo+lceVZm44vfp51zya8PKsHslNvhSSL2XfK1AEzZG/dWkyJEe3b85Ey9
        cDGrjSamdTfj4V8FB4tEuhNnWtuAIxzGHA3AR0IGcev4SZhNsW+4vRhIEUxKFU70yaAXoIZnYcGYi
        78OrRGX3XrAxH4PYf6LFgVeSq7vCPaMtG47xU/94vvYDjqPLZa6Um/0ui4z+RDzwSYAmVCq84nsvN
        UXZZgsw0rJv+xfvhci9yN1FWmAbgxMQ1WZX5U3tDd9LfhiGxNbo22nRqVMlRo2FnfJs55AjT4/yVT
        XYC526Bg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nIPo5-0061TC-Ft; Fri, 11 Feb 2022 06:53:25 +0000
Date:   Thu, 10 Feb 2022 22:53:25 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH 05/14] dm: remove impossible BUG_ON in __send_empty_flush
Message-ID: <YgYH5V9qNKkGQVjo@infradead.org>
References: <20220210223832.99412-1-snitzer@redhat.com>
 <20220210223832.99412-6-snitzer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210223832.99412-6-snitzer@redhat.com>
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

On Thu, Feb 10, 2022 at 05:38:23PM -0500, Mike Snitzer wrote:
> The flush_bio in question was just initialized to be empty, so there
> is no way bio_has_data() will retrun true.  So remove stale BUG_ON().

s/retrun/return/

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
