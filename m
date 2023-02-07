Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4C068E099
	for <lists+linux-block@lfdr.de>; Tue,  7 Feb 2023 19:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjBGSwJ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 7 Feb 2023 13:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbjBGSwF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Feb 2023 13:52:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290C91B1
        for <linux-block@vger.kernel.org>; Tue,  7 Feb 2023 10:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675795879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TVeylEZeMhpYYMRKttVHrNV6zbKjTMnp/gJrjK7L9wE=;
        b=VWVnDtekB8hpPSx30pyMsGSguEKG4TcBlEXYKHRzUQxKYTeYnUKO8XS6ViugaoiGc178C0
        nGrPWRYCkXKEfCQxh9bv+6EhPhgEtkSR2oY/MKF0ONPy+22rP/cUDjIS6Hc4EZtectgEwp
        7W4MGKoizE7J04IFUyMLpjHvuurbiVE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-ZzkiR0mOOiKjrHHzY8209A-1; Tue, 07 Feb 2023 13:51:14 -0500
X-MC-Unique: ZzkiR0mOOiKjrHHzY8209A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F2DB101A52E;
        Tue,  7 Feb 2023 18:51:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 54773140EBF4;
        Tue,  7 Feb 2023 18:51:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <88fcfd5a-cf73-f417-cea6-eed5094d71ed@kernel.dk>
References: <88fcfd5a-cf73-f417-cea6-eed5094d71ed@kernel.dk> <20230207171305.3716974-1-dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v12 00/10] iov_iter: Improve page extraction (pin or just list)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3814632.1675795869.1@warthog.procyon.org.uk>
Date:   Tue, 07 Feb 2023 18:51:09 +0000
Message-ID: <3814633.1675795869@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens Axboe <axboe@kernel.dk> wrote:

> I've updated the for-6.3/iov-extract branch and the for-next branch. This
> isn't done to bypass any review, just so we can get some more testing on
> this (and because the old one is known broken).

Thanks!

David

