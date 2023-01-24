Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7A7679AD9
	for <lists+linux-block@lfdr.de>; Tue, 24 Jan 2023 14:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbjAXN71 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 24 Jan 2023 08:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234164AbjAXN7Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2023 08:59:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163EE47414
        for <linux-block@vger.kernel.org>; Tue, 24 Jan 2023 05:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674568637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DgD/f9BNb2oVu+Rz4+nVO6VWZZv2jdeOteZmp96pjN8=;
        b=fj5HAHMPr6nTu70BFuxgPGaWVHQVMzKExUIUHeqxV0YnroB31UG9K2iopyGgfKQ1TeVWCE
        1cSe8P9/MRo1j6tZxhiAEnNVowdn8VHLSu5d2vR99oYbJberlV3wYXsAIQVxs3GO4PDWhp
        kcr83YtvNZeC4/qJRLgiUL3YLoKqMA0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-DeVOvTxrOxOtsQT31D-5ag-1; Tue, 24 Jan 2023 08:57:11 -0500
X-MC-Unique: DeVOvTxrOxOtsQT31D-5ag-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 56726858F09;
        Tue, 24 Jan 2023 13:57:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B59712026D4B;
        Tue, 24 Jan 2023 13:57:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y8/hhvfDtVcsgQd6@nvidia.com>
References: <Y8/hhvfDtVcsgQd6@nvidia.com> <Y8/ZekMEAfi8VeFl@nvidia.com> <20230123173007.325544-1-dhowells@redhat.com> <20230123173007.325544-11-dhowells@redhat.com> <31f7d71d-0eb9-2250-78c0-2e8f31023c66@nvidia.com> <84721e8d-d40e-617c-b75e-ead51c3e1edf@nvidia.com> <852117.1674567983@warthog.procyon.org.uk>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     dhowells@redhat.com, John Hubbard <jhubbard@nvidia.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-mm@kvack.org
Subject: Re: [PATCH v8 10/10] mm: Renumber FOLL_PIN and FOLL_GET down
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <852913.1674568628.1@warthog.procyon.org.uk>
Date:   Tue, 24 Jan 2023 13:57:08 +0000
Message-ID: <852914.1674568628@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jason Gunthorpe <jgg@nvidia.com> wrote:

> I moved FOLL_PIN to internal.h because it is not supposed to be used
> outside mm/*
> 
> I would prefer to keep it that way.

I'll need to do something else, then, such as creating a new pair of 'cleanup'
flags:

	[include/linux/mm_types.h]
	#define PAGE_CLEANUP_UNPIN	(1U << 0)
	#define PAGE_CLEANUP_PUT	(1U << 0)

	[mm/gup.h]
	void folio_put_unpin(struct folio *folio, unsigned int cleanup_flags)
	{
		unsigned int gup_flags = 0;

		cleanup_flags &= PAGE_CLEANUP_UNPIN | PAGE_CLEANUP_PUT;
		if (!cleanup_flags)
			return;
		gup_flags |= cleanup_flags & PAGE_CLEANUP_UNPIN ? FOLL_PIN : 0;
		gup_flags |= cleanup_flags & PAGE_CLEANUP_PUT ? FOLL_GET : 0;
		gup_put_folio(folio, 1, flags);
	}
	EXPORT_SYMBOL_GPL(folio_put_unpin);

David

