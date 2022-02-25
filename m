Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FB14C4CE6
	for <lists+linux-block@lfdr.de>; Fri, 25 Feb 2022 18:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiBYRx7 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 25 Feb 2022 12:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiBYRx7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Feb 2022 12:53:59 -0500
Received: from relay5.hostedemail.com (relay5.hostedemail.com [64.99.140.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3322187BA7
        for <linux-block@vger.kernel.org>; Fri, 25 Feb 2022 09:53:26 -0800 (PST)
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay07.hostedemail.com (Postfix) with ESMTP id 1280E22362;
        Fri, 25 Feb 2022 17:53:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id F0D6F20026;
        Fri, 25 Feb 2022 17:53:13 +0000 (UTC)
Message-ID: <cc8405c39037d1b63df3d901051118f9b12c36a9.camel@perches.com>
Subject: Re: [PATCHv3 03/10] asm-generic: introduce be48 unaligned accessors
From:   Joe Perches <joe@perches.com>
To:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk,
        martin.petersen@oracle.com, colyli@suse.de,
        Hannes Reinecke <hare@suse.de>, Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 25 Feb 2022 09:53:11 -0800
In-Reply-To: <20220225160300.GC13610@lst.de>
References: <20220222163144.1782447-1-kbusch@kernel.org>
         <20220222163144.1782447-4-kbusch@kernel.org>
         <20220225160300.GC13610@lst.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Stat-Signature: spz4ukuecs8kzmbxa6om18zqso8poejr
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: F0D6F20026
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+7WrsVDd0XN45qTzKLE5sj7V3piTJ4Lf8=
X-HE-Tag: 1645811593-962451
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2022-02-25 at 17:03 +0100, Christoph Hellwig wrote:
> On Tue, Feb 22, 2022 at 08:31:37AM -0800, Keith Busch wrote:
> > The NVMe protocol extended the data integrity fields with unaligned
> > 48-bit reference tags. Provide some helper accessors in
> > preparation for these.
> > 
> > Reviewed-by: Hannes Reinecke <hare@suse.de>
> > Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> 
> Looks good,
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Perhaps for completeness this should also add the le48 variants
like the 24 bit accessors above this.

