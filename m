Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118B54C50AB
	for <lists+linux-block@lfdr.de>; Fri, 25 Feb 2022 22:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238832AbiBYVYl (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 25 Feb 2022 16:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238579AbiBYVY3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Feb 2022 16:24:29 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB6F188A37
        for <linux-block@vger.kernel.org>; Fri, 25 Feb 2022 13:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r8ZKGime/wRXPVljCBNfhFYzidDX0agM4lTDoTb2t9k=; b=mlQfmFc+YBkoO5SjCbnNXjOH6U
        V0jEVfu3CahjBuefewEKcZfCevR9gVMbLPgo1fe96RglhAPR+lfQoFgsOFTBcInx7BlydMXnq7fPO
        KCaB19eq2AF+Q9alQgFouPO523fg4H/RjrtJHjS24P1ZJwMttmtzU1qcZaVv0oqobdPkcVO4Q4/Tb
        pP1tzCJxbwB0ygCMGs5qGOYsrUvHhlJieK0mDafoGL/VQIGpLjCOD08tilq1JBDFrLmJrZXxe1rQ0
        JGqWdnQpV1Ooleb1w+YC0PlAH0yDiMNVkkmjdoDHnKTP0Wo8/0GIxcqmSh9ilrY80Q1KkQIwq8aXB
        bypS4PVQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNi41-0070QO-DJ; Fri, 25 Feb 2022 21:23:45 +0000
Date:   Fri, 25 Feb 2022 13:23:45 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Jeff Mahoney <jeffm@suse.com>, Karel Zak <kzak@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: default BLOCK_LEGACY_AUTOLOAD to y
Message-ID: <YhlI4bKqYpknNgBa@bombadil.infradead.org>
References: <20220225181440.1351591-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225181440.1351591-1-hch@lst.de>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 25, 2022 at 07:14:40PM +0100, Christoph Hellwig wrote:
> As Luis reported, losetup currently doesn't properly create the loop
> device without this if the device node already exists because old
> scripts created it manually.  So default to y for now and remove the
> aggressive removal schedule.
> 
> Reported-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

I'm saddened by the fact that we're not going to get an idea of how far
and wide the stupid mknod prior to modprobe use is by making this
as y default even though I know this is the right thing to do.

I think our ownly measure of success here is to really push
Linux distributions to start disabling BLOCK_LEGACY_AUTOLOAD
and getting their help to see what burts into flames.

Without that endevour we're positioning ourselves to keep the stupid
BLOCK_LEGACY_AUTOLOAD forever.

I *thought* that for some odd uses cases, maybe early-init, or virt-io,
mknod might be used to this day, because of some odd boot failures I saw
with linux-next, but I'm no longer seeing those boot failures anymore
and I cannot confirm.

  Luis
