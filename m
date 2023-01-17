Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866A866D823
	for <lists+linux-block@lfdr.de>; Tue, 17 Jan 2023 09:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbjAQI1F (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 17 Jan 2023 03:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236075AbjAQI1E (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Jan 2023 03:27:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3A610C4
        for <linux-block@vger.kernel.org>; Tue, 17 Jan 2023 00:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673943976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CGG6nTGxkZXGoYdS9YZATBVEC4tK6YnOhWeyJms4Rik=;
        b=a6qoxQu4nSQ3KMLmZkeTmYHxbypK8YT7W/Uz785DsVQCevM4YCa8GIJCFy3sC/jqYzWn4h
        3vxh+T95TEKDvJoLVFVWygssWsCHdx7im86Q9zjG8WAKEWkE+xuU2VlZIdP073aMeoagYY
        1gD+ToYcVJpcSyT0rkZ7f8uc2Cqy7Vw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-468-vQEnYVWdPSevVZXYYs2M1A-1; Tue, 17 Jan 2023 03:26:11 -0500
X-MC-Unique: vQEnYVWdPSevVZXYYs2M1A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B31ED3C22740;
        Tue, 17 Jan 2023 08:26:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 659F140C2064;
        Tue, 17 Jan 2023 08:26:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y8ZXQArEsIRNO9k/@infradead.org>
References: <Y8ZXQArEsIRNO9k/@infradead.org> <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk> <167391056047.2311931.6772604381276147664.stgit@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 11/34] iov_iter, block: Make bio structs pin pages rather than ref'ing if appropriate
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2330753.1673943968.1@warthog.procyon.org.uk>
Date:   Tue, 17 Jan 2023 08:26:08 +0000
Message-ID: <2330754.1673943968@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> > +	bio_clear_flag(bio, BIO_PAGE_REFFED);
> 
> .. and this should not be needed.  Instead:
> 
> > +	cleanup_mode = iov_iter_extract_mode(iter, gup_flags);
> > +	if (cleanup_mode & FOLL_GET)
> > +		bio_set_flag(bio, BIO_PAGE_REFFED);
> > +	if (cleanup_mode & FOLL_PIN)
> > +		bio_set_flag(bio, BIO_PAGE_PINNED);
> 
> We could warn if a not match flag is set here if we really care.

Um... With these patches, BIO_PAGE_REFFED is set by default when the bio is
initialised otherwise every user of struct bio that currently adds pages
directly (assuming there are any) rather than going through
bio_iov_iter_get_pages() will have to set the flag, hence the need to clear
it.

Actually, I could do:

	if (!(cleanup_mode & FOLL_GET))
		bio_clear_flag(bio, BIO_PAGE_REFFED);
	if (cleanup_mode & FOLL_PIN)
		bio_set_flag(bio, BIO_PAGE_PINNED);

which should also work.

David


