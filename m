Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6DE21D7054
	for <lists+linux-block@lfdr.de>; Mon, 18 May 2020 07:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgERFXH (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 18 May 2020 01:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgERFXH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 May 2020 01:23:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E5FC061A0C
        for <linux-block@vger.kernel.org>; Sun, 17 May 2020 22:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+mRDJz2576NEe0WfZ8cUXmxGznAwW67bCZs5FTVyvIw=; b=GXCbCL77UwOylFDmhLHeQY8eXO
        Mgm6feMc7E61cJxKoUd1pXpyzxy9UfI9d+vGZTusefr8sS/VMXjnWJJN5hy3CYEb5VKW6uvVlEEFa
        Ms8PfAk/53uKaM+wrTjV65Ghhz9O3ztfiBEoavtUpZSs0Ra3kMg/UykXnBoYC/2AkiYb0xU0XjCHO
        cbVk4lrgJ+OHC6sPJlNWVdpcMP0jAGuItpufIJP0RPXs3nRBdmviCMs9s6a0wGxQVvTvTQDHPY+2O
        ehn6bFECo+r5o/Gfwp3U78/zODzXeMc1S8cZiNCzX+1tnTxsFTH/w7cH2ld5rJ2u8Rb+g+hEXpOdk
        QNiZrpFg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jaYEv-0005Ri-SY; Mon, 18 May 2020 05:23:01 +0000
Date:   Sun, 17 May 2020 22:23:01 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 3/4] block: Document the bio_vec properties
Message-ID: <20200518052301.GA20810@infradead.org>
References: <20200518014807.7749-1-bvanassche@acm.org>
 <20200518014807.7749-4-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518014807.7749-4-bvanassche@acm.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, May 17, 2020 at 06:48:06PM -0700, Bart Van Assche wrote:
> Since it is nontrivial that nth_page() does not have to be used for a
> bio_vec, document this.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
