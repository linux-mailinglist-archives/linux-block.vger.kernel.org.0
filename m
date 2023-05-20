Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFEE870A61D
	for <lists+linux-block@lfdr.de>; Sat, 20 May 2023 09:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjETHWn (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 20 May 2023 03:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjETHWm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 May 2023 03:22:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD83E0
        for <linux-block@vger.kernel.org>; Sat, 20 May 2023 00:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684567315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tMJ2UA9C086zsdoWMPyTFKlyEmN1wmL+SV81fprldkY=;
        b=VMAECOTU+QwKrnfDulB2Gjfd+pv+MhwZ7/smec0T1NaGzXkXDUs0MgPhxFRbbrbvoDXfO3
        pNplj4aw1aKwSlgrZaiA0UM+GWQ+vrvLCKGc1qWMzYQd2lPK3qLHbBfbrJ2nE3QqE6zTl1
        2/PS5fKwqO7KxgG2hxlN5uFLeHQPf+8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367-sQc6AOqrP_Cwo3YRKP2QvA-1; Sat, 20 May 2023 03:21:48 -0400
X-MC-Unique: sQc6AOqrP_Cwo3YRKP2QvA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 74C912800C31;
        Sat, 20 May 2023 07:21:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.221])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A9A0E4F2DE3;
        Sat, 20 May 2023 07:21:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <ZGhIpbrgQaPRPC3c@infradead.org>
References: <ZGhIpbrgQaPRPC3c@infradead.org> <20230520000049.2226926-1-dhowells@redhat.com> <20230520000049.2226926-19-dhowells@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v21 18/30] ext4: Provide a splice-read stub
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2233564.1684567304.1@warthog.procyon.org.uk>
Date:   Sat, 20 May 2023 08:21:44 +0100
Message-ID: <2233565.1684567304@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> Not sure I'd call this a stub, but then again I'm not a native speaker.

"Wrapper"?

David

