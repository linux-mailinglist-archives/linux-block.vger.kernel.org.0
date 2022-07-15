Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB105758FF
	for <lists+linux-block@lfdr.de>; Fri, 15 Jul 2022 03:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbiGOBK0 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 14 Jul 2022 21:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbiGOBKZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 21:10:25 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DEF5F9AA
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 18:10:23 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 26F19vGJ002500
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 21:09:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1657847399; bh=xf8giMoDn8uh0DIpEEzLBnO2p5mF61e2s60RIPXrB7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ba8yscV7gY9WSFIrEJSJMjGrJL6HP7+4fJvuNOBI04+gLBcELbUqQAdWGjPCttQBx
         mZiJ8iUFEp9j58r846fgrT00TA6RviSlwBgU6tu0ViK5Fz+oIQEmM40fkKPlrIX/cI
         BoNJhRrLrg6ShRWvJje/Dd8U0jUje367tSa/kNUv1KI2U+bemy6ci4MZMaldbOSVZ5
         P3vcPdCEJj7paf+jLnsM9Pp+jD1SzSM0PUKMHUhqVBFZpF6Myujq0w7jHjLsZR/srb
         ZACJ633hQLK+0Zw4iB0Hf9wYt9TOUECsHTQjw+M4aLHpIm2JF4JLRstB2Xv+6Y4kRz
         nfgyoxYWFgCkw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4673315C003C; Thu, 14 Jul 2022 21:09:57 -0400 (EDT)
Date:   Thu, 14 Jul 2022 21:09:57 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Baokun Li <libaokun1@huawei.com>, Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH v3 51/63] fs/ext4: Use the new blk_opf_t type
Message-ID: <YtC+ZflE5MzDvBvk@mit.edu>
References: <20220714180729.1065367-1-bvanassche@acm.org>
 <20220714180729.1065367-52-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714180729.1065367-52-bvanassche@acm.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 14, 2022 at 11:07:17AM -0700, Bart Van Assche wrote:
> Improve static type checking by using the new blk_opf_t type for
> variables that represent request flags.
> 
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Baokun Li <libaokun1@huawei.com>
> Cc: Ye Bin <yebin10@huawei.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Acked-by: Theodore Ts'o <tytso@mit.edu>
