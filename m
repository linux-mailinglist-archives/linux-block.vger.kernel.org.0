Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8D0678486
	for <lists+linux-block@lfdr.de>; Mon, 23 Jan 2023 19:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbjAWSWp (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 23 Jan 2023 13:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbjAWSWm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Jan 2023 13:22:42 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9471C27D79;
        Mon, 23 Jan 2023 10:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uX1FU2QW6fhRi3bfPePvGfHUldz+VlZS/BdfnfTFzOM=; b=dL3pGez1eZOm5WrislEPELrwXD
        3yYyounbJm8ddljIrjp7QHwwVkAxd9uMJo/y28OtvWTMK5F+IN+MrlmGSgDQnz0FnXunjWAo8032d
        LsusjrIHogjlXYoGyrTQT7cZNI/jlLVhVxMpuYTbOUuXMyiumgtFtTtaXd30zICvxTrHADeyQI1ti
        6LhcjXrI5U0WmjKkw/8y8Zq9H+y9epSxAmsCqUaekt1dEN1TOS3oG+aLmUJEh7u/t8AKkI7F4F2F1
        I2L8RtcrPEjkXxWPQ6ii+j4LOnXiIHbMdpwNMsmexEz9JGvHPbP+D2hCu5gRAINdE/Vp1UZwqKS5H
        93x6wpVw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pK1Sb-00107A-La; Mon, 23 Jan 2023 18:22:25 +0000
Date:   Mon, 23 Jan 2023 10:22:25 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v8 04/10] iomap: don't get an reference on ZERO_PAGE for
 direct I/O block zeroing
Message-ID: <Y87QYbl5rLZVdFRm@infradead.org>
References: <20230123173007.325544-1-dhowells@redhat.com>
 <20230123173007.325544-5-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123173007.325544-5-dhowells@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 23, 2023 at 05:30:01PM +0000, David Howells wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> ZERO_PAGE can't go away, no need to hold an extra reference.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: David Howells <dhowells@redhat.com>

I did originally attribute this to you as it's just extracted as
an intermedia step from your patch.  But I can live with it being
credited to me if you want.
